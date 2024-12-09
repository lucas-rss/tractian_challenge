import 'dart:developer';

import 'package:tractian_test/assets_tree/data/datasources/assets_tree_datasource.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/asset_node_model.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/location_node_model.dart';

class GetAssetsTreeUsecase {
  final AssetsTreeDatasource _datasource;

  GetAssetsTreeUsecase({
    required AssetsTreeDatasource datasource,
  }) : _datasource = datasource;

  Future call(String companyId) async {
    final response = await Future.wait([
      _datasource.getLocationsByCompany(companyId),
      _datasource.getAssetsByCompany(companyId),
    ]);

    final locations = response[0] as List<LocationNodeModel>;
    final assets = response[1] as List<AssetNodeModel>;

    inspect(locations);
    inspect(assets);
  }
}
