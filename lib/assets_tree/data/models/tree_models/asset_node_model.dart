import 'package:tractian_test/assets_tree/data/models/tree_models/tree_node_model.dart';

class AssetNodeModel extends TreeNodeModel {
  final String? parentId;
  final String? sensorId;
  final String? sensorType;
  final String? status;
  final String? gatewayId;
  final String? locationId;

  AssetNodeModel({
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.gatewayId,
    this.locationId,
    required super.id,
    required super.name,
    super.children = const [],
  });

  factory AssetNodeModel.fromJson(Map<String, dynamic> json) {
    return AssetNodeModel(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: json['status'],
      gatewayId: json['gatewayId'],
      locationId: json['locationId'],
    );
  }
}
