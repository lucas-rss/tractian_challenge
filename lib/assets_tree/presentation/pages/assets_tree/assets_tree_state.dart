import 'package:tractian_test/assets_tree/data/models/tree_models/tree_node_model.dart';
import 'package:tractian_test/assets_tree/utils/enums/asset_filter_type_enum.dart';

abstract class AssetsTreeState {
  final TreeNodeModel? currentRootNode;
  final TreeNodeModel? initialRootNode;
  final AssetFilterTypeEnum? filterType;
  final String? searchString;

  AssetsTreeState({
    this.currentRootNode,
    this.initialRootNode,
    this.filterType,
    this.searchString,
  });
}

class AssetsTreeInitial extends AssetsTreeState {}

class AssetsTreeLoading extends AssetsTreeState {
  AssetsTreeLoading({
    super.currentRootNode,
    super.initialRootNode,
    super.filterType,
    super.searchString,
  });
}

class AssetsTreeSuccess extends AssetsTreeState {
  AssetsTreeSuccess({
    super.currentRootNode,
    required super.initialRootNode,
    super.filterType,
    super.searchString,
  });
}

class AssetsTreeError extends AssetsTreeState {
  AssetsTreeError({
    super.currentRootNode,
    super.initialRootNode,
    super.filterType,
    super.searchString,
  });
}
