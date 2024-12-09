import 'package:tractian_test/assets_tree/data/models/tree_models/tree_node_model.dart';

abstract class AssetsTreeState {}

class AssetsTreeInitial extends AssetsTreeState {}

class AssetsTreeLoading extends AssetsTreeState {}

class AssetsTreeSuccess extends AssetsTreeState {
  final TreeNodeModel rootNode;

  AssetsTreeSuccess({required this.rootNode});
}

class AssetsTreeError extends AssetsTreeState {}
