import 'package:tractian_test/assets_tree/data/datasources/assets_tree_datasource.dart';
import 'package:tractian_test/assets_tree/data/models/company_model.dart';

class GetCompaniesUsecase {
  final AssetsTreeDatasource _datasource;

  GetCompaniesUsecase({
    required AssetsTreeDatasource datasource,
  }) : _datasource = datasource;

  Future<List<CompanyModel>> call() async {
    return await _datasource.getCompanies();
  }
}
