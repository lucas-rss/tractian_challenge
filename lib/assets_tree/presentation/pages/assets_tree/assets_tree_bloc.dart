import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/asset_node_model.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/location_node_model.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/tree_node_model.dart';
import 'package:tractian_test/assets_tree/domain/usecases/get_assets_tree_usecase.dart';
import 'package:tractian_test/assets_tree/presentation/pages/assets_tree/assets_tree_state.dart';
import 'package:tractian_test/assets_tree/utils/enums/asset_filter_type_enum.dart';

class AssetsTreeBloc extends Cubit<AssetsTreeState> {
  final GetAssetsTreeUsecase _getAssetsTreeUsecase;

  AssetsTreeBloc({
    required GetAssetsTreeUsecase getAssetsTreeUsecase,
  })  : _getAssetsTreeUsecase = getAssetsTreeUsecase,
        super(AssetsTreeInitial());

  Future<void> buildUnitAssetsTree(String companyId) async {
    emit(AssetsTreeLoading());
    final rootNode = await _getAssetsTreeUsecase(companyId);
    emit(AssetsTreeSuccess(initialRootNode: rootNode));
  }

  void setEnergyOrCriticalFilter(AssetFilterTypeEnum filterType) {
    emit(
      AssetsTreeLoading(
        filterType: filterType,
        initialRootNode: state.initialRootNode,
      ),
    );
    final filteredNode = filterTree(
      state.initialRootNode!,
      filterType: filterType,
    );
    emit(
      AssetsTreeFiltered(
        initialRootNode: state.initialRootNode,
        filteredRootNode: filteredNode,
        filterType: state.filterType,
      ),
    );
  }

  TreeNodeModel? filterTree(
    TreeNodeModel node, {
    AssetFilterTypeEnum? filterType,
    String? searchString,
  }) {
    late final TreeNodeModel filteredNode;

    if (node is AssetNodeModel) {
      filteredNode = AssetNodeModel(
        id: node.id,
        name: node.name,
        parentId: node.parentId,
        sensorId: node.sensorId,
        sensorType: node.sensorType,
        status: node.status,
        gatewayId: node.gatewayId,
        locationId: node.locationId,
        children: [],
      );
    } else if (node is LocationNodeModel) {
      filteredNode = LocationNodeModel(
        id: node.id,
        name: node.name,
        parentId: node.parentId,
        children: [],
      );
    }

    bool matches = true;

    if (filterType != null && filterType == AssetFilterTypeEnum.energySensor) {
      matches = node is AssetNodeModel && node.sensorType == 'energy';
    } else if (filterType != null &&
        filterType == AssetFilterTypeEnum.criticalStatus) {
      matches = node is AssetNodeModel && node.status == 'alert';
    }

    if (searchString != null && searchString.isNotEmpty) {
      matches = node.name.contains(searchString);
    }

    for (var child in node.children) {
      var filteredChild = filterTree(
        child,
        filterType: filterType,
        searchString: searchString,
      );
      if (filteredChild != null) {
        filteredNode.children.add(filteredChild);
        matches = true;
      }
    }

    return matches ? filteredNode : null;
  }
}
