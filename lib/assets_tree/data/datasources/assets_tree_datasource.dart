import 'package:tractian_test/assets_tree/data/models/company_model.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/asset_node_model.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/location_node_model.dart';
import 'package:tractian_test/core/services/http_service.dart';

class AssetsTreeDatasource {
  final HttpService _httpService;

  AssetsTreeDatasource({
    required HttpService httpService,
  }) : _httpService = httpService;

  Future<List<CompanyModel>> getCompanies() async {
    final response = await _httpService.get('/companies');
    return (response.data as List)
        .map((json) => CompanyModel.fromJson(json))
        .toList();
  }

  Future<List<LocationNodeModel>> getLocationsByCompany(
    String companyId,
  ) async {
    final response = await _httpService.get('/companies/$companyId/locations');
    return (response.data as List)
        .map((json) => LocationNodeModel.fromJson(json))
        .toList();
  }

  Future<List<AssetNodeModel>> getAssetsByCompany(String companyId) async {
    final response = await _httpService.get('/companies/$companyId/assets');
    return (response.data as List)
        .map((json) => AssetNodeModel.fromJson(json))
        .toList();
  }
}
