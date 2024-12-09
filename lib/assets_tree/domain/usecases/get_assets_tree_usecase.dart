import 'package:tractian_test/assets_tree/data/datasources/assets_tree_datasource.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/asset_node_model.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/location_node_model.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/tree_node_model.dart';

class GetAssetsTreeUsecase {
  final AssetsTreeDatasource _datasource;

  GetAssetsTreeUsecase({
    required AssetsTreeDatasource datasource,
  }) : _datasource = datasource;

  Future<TreeNodeModel> call(String companyId) async {
    final response = await Future.wait([
      _datasource.getLocationsByCompany(companyId),
      _datasource.getAssetsByCompany(companyId),
    ]);

    final locations = response[0] as List<LocationNodeModel>;
    final assets = response[1] as List<AssetNodeModel>;

    Map<String, TreeNodeModel> locationsMap = {
      for (var location in locations) location.id: location..children = [],
    };

    Map<String, TreeNodeModel> assetsMap = {
      for (var asset in assets) asset.id: asset..children = [],
    };

    final root = LocationNodeModel(
      id: 'root_id',
      name: 'Root',
      children: [],
    );

    for (var location in locations) {
      if (location.parentId != null) {
        locationsMap[location.parentId]?.children.add(location);
      } else {
        root.children.add(location);
      }
    }

    for (var asset in assets) {
      if (asset.parentId != null) {
        assetsMap[asset.parentId]?.children.add(asset);
      } else if (asset.locationId != null) {
        locationsMap[asset.locationId]?.children.add(asset);
      } else {
        root.children.add(asset);
      }
    }

    return root;
  }
}
