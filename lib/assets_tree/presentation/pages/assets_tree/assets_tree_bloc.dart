import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/asset_node_model.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/location_node_model.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/tree_node_model.dart';
import 'package:tractian_test/assets_tree/domain/usecases/get_assets_tree_usecase.dart';
import 'package:tractian_test/assets_tree/presentation/pages/assets_tree/assets_tree_state.dart';
import 'package:tractian_test/assets_tree/utils/enums/status_sensor_filter_enum.dart';

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

  void setStatusSensorFilter(StatusSensorFilterEnum statusSensorFilter) {
    StatusSensorFilterEnum? newStatusSensorFilter;

    if (statusSensorFilter == state.statusSensorFilter) {
      newStatusSensorFilter = null;
    } else {
      newStatusSensorFilter = statusSensorFilter;
    }

    emit(
      AssetsTreeLoading(
        statusSensorFilter: newStatusSensorFilter,
        initialRootNode: state.initialRootNode,
        filteredRootNode: state.filteredRootNode,
        searchString: state.searchString,
      ),
    );

    if (state.statusSensorFilter != null ||
        (state.searchString != null && state.searchString!.isNotEmpty)) {
      final filteredNode = filterTree(
        state.initialRootNode!,
        searchString: state.searchString,
        statusSensorFilter: state.statusSensorFilter,
      );
      emit(
        AssetsTreeFiltered(
          filteredRootNode: filteredNode,
          initialRootNode: state.initialRootNode,
          searchString: state.searchString,
          statusSensorFilter: state.statusSensorFilter,
        ),
      );
    } else {
      emit(AssetsTreeSuccess(initialRootNode: state.initialRootNode));
    }
  }

  void setSearchString(String searchString) {
    emit(
      AssetsTreeLoading(
        statusSensorFilter: state.statusSensorFilter,
        initialRootNode: state.initialRootNode,
        filteredRootNode: state.filteredRootNode,
        searchString: searchString,
      ),
    );

    if (searchString.isNotEmpty || state.statusSensorFilter != null) {
      final filteredNode = filterTree(
        state.initialRootNode!,
        searchString: state.searchString,
        statusSensorFilter: state.statusSensorFilter,
      );
      emit(
        AssetsTreeFiltered(
          filteredRootNode: filteredNode,
          initialRootNode: state.initialRootNode,
          searchString: state.searchString,
          statusSensorFilter: state.statusSensorFilter,
        ),
      );
    } else {
      emit(AssetsTreeSuccess(initialRootNode: state.initialRootNode));
    }
  }

  TreeNodeModel? filterTree(
    TreeNodeModel node, {
    StatusSensorFilterEnum? statusSensorFilter,
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

    if (statusSensorFilter != null &&
        statusSensorFilter == StatusSensorFilterEnum.energySensor) {
      matches = node is AssetNodeModel && node.sensorType == 'energy';
    } else if (statusSensorFilter != null &&
        statusSensorFilter == StatusSensorFilterEnum.criticalStatus) {
      matches = node is AssetNodeModel && node.status == 'alert';
    }

    if (searchString != null && searchString.isNotEmpty) {
      matches = node.name.toLowerCase().contains(searchString.toLowerCase());
    }

    for (var child in node.children) {
      var filteredChild = filterTree(
        child,
        statusSensorFilter: statusSensorFilter,
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
