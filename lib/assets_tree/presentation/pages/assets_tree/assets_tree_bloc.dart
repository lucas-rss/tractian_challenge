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
      state.searchString,
      state.filterType,
    );
    emit(
      AssetsTreeSuccess(
        initialRootNode: state.initialRootNode,
        currentRootNode: filteredNode,
        filterType: state.filterType,
      ),
    );
  }

  TreeNodeModel? filterTree(
    TreeNodeModel rootNode,
    String? searchQuery,
    AssetFilterTypeEnum? filterType,
  ) {
    bool matchesFilter(TreeNodeModel node) {
      if (searchQuery != null &&
          !node.name.toLowerCase().contains(searchQuery.toLowerCase())) {
        return false;
      }
      if (filterType == AssetFilterTypeEnum.energySensor &&
          node is AssetNodeModel &&
          node.sensorType != 'energy') {
        return false;
      }
      if (filterType == AssetFilterTypeEnum.criticalStatus &&
          node is AssetNodeModel &&
          node.status != 'critical') {
        return false;
      }
      return true;
    }

    List<TreeNodeModel> filteredChildren = rootNode.children
        .map((child) => filterTree(child, searchQuery, filterType))
        .where((child) => child != null)
        .cast<TreeNodeModel>()
        .toList();

    if (matchesFilter(rootNode) || filteredChildren.isNotEmpty) {
      if (rootNode is LocationNodeModel) {
        return LocationNodeModel(
          id: rootNode.id,
          name: rootNode.name,
          parentId: rootNode.parentId,
        );
      } else if (rootNode is AssetNodeModel) {
        return AssetNodeModel(
          id: rootNode.id,
          name: rootNode.name,
          parentId: rootNode.parentId,
          locationId: rootNode.locationId,
          sensorId: rootNode.sensorId,
          sensorType: rootNode.sensorType,
          status: rootNode.status,
          gatewayId: rootNode.gatewayId,
          children: filteredChildren,
        );
      }
    }
    return null;
  }
}
