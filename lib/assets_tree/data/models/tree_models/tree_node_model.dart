abstract class TreeNodeModel {
  final String id;
  final String name;
  final List<TreeNodeModel> children;

  const TreeNodeModel({
    required this.id,
    required this.name,
    required this.children,
  });
}
