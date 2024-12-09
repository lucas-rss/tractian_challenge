import 'package:tractian_test/assets_tree/data/models/tree_models/tree_node_model.dart';

class LocationNodeModel extends TreeNodeModel {
  final String? parentId;

  LocationNodeModel({
    this.parentId,
    required super.id,
    required super.name,
    super.children = const [],
  });

  factory LocationNodeModel.fromJson(Map<String, dynamic> json) {
    return LocationNodeModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }
}
