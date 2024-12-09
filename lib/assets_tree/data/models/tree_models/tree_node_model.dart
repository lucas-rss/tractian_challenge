abstract class TreeNodeModel {
  final String id;
  final String name;
  List<TreeNodeModel> children;

  TreeNodeModel({
    required this.id,
    required this.name,
    required this.children,
  });
}
