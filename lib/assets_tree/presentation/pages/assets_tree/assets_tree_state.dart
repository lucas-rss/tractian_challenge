import 'package:tractian_test/assets_tree/data/models/tree_models/tree_node_model.dart';
import 'package:tractian_test/assets_tree/utils/enums/asset_filter_type_enum.dart';

abstract class AssetsTreeState {
  final TreeNodeModel? filteredRootNode;
  final TreeNodeModel? initialRootNode;
  final AssetFilterTypeEnum? filterType;
  final String? searchString;

  AssetsTreeState({
    this.filteredRootNode,
    this.initialRootNode,
    this.filterType,
    this.searchString,
  });
}

class AssetsTreeInitial extends AssetsTreeState {}

class AssetsTreeLoading extends AssetsTreeState {
  AssetsTreeLoading({
    super.filteredRootNode,
    super.initialRootNode,
    super.filterType,
    super.searchString,
  });
}

class AssetsTreeSuccess extends AssetsTreeState {
  AssetsTreeSuccess({
    super.filteredRootNode,
    required super.initialRootNode,
    super.filterType,
    super.searchString,
  });
}

class AssetsTreeFiltered extends AssetsTreeState {
  AssetsTreeFiltered({
    required super.filteredRootNode,
    required super.initialRootNode,
    super.filterType,
    super.searchString,
  });
}

class AssetsTreeError extends AssetsTreeState {
  AssetsTreeError({
    super.filteredRootNode,
    super.initialRootNode,
    super.filterType,
    super.searchString,
  });
}
