import 'package:tractian_test/assets_tree/data/models/tree_models/tree_node_model.dart';
import 'package:tractian_test/assets_tree/utils/enums/status_sensor_filter_enum.dart';

abstract class AssetsTreeState {
  final TreeNodeModel? filteredRootNode;
  final TreeNodeModel? initialRootNode;
  final StatusSensorFilterEnum? statusSensorFilter;
  final String? searchString;

  AssetsTreeState({
    this.filteredRootNode,
    this.initialRootNode,
    this.statusSensorFilter,
    this.searchString,
  });
}

class AssetsTreeInitial extends AssetsTreeState {}

class AssetsTreeLoading extends AssetsTreeState {
  AssetsTreeLoading({
    super.filteredRootNode,
    super.initialRootNode,
    super.statusSensorFilter,
    super.searchString,
  });
}

class AssetsTreeSuccess extends AssetsTreeState {
  AssetsTreeSuccess({
    super.filteredRootNode,
    required super.initialRootNode,
    super.statusSensorFilter,
    super.searchString,
  });
}

class AssetsTreeFiltered extends AssetsTreeState {
  AssetsTreeFiltered({
    required super.filteredRootNode,
    required super.initialRootNode,
    super.statusSensorFilter,
    super.searchString,
  });
}

class AssetsTreeError extends AssetsTreeState {
  AssetsTreeError({
    super.filteredRootNode,
    super.initialRootNode,
    super.statusSensorFilter,
    super.searchString,
  });
}
