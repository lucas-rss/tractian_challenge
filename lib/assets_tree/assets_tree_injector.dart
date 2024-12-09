import 'package:get_it/get_it.dart';
import 'package:tractian_test/assets_tree/data/datasources/assets_tree_datasource.dart';
import 'package:tractian_test/assets_tree/domain/usecases/get_assets_tree_usecase.dart';
import 'package:tractian_test/assets_tree/domain/usecases/get_companies_usecase.dart';
import 'package:tractian_test/assets_tree/presentation/pages/assets_tree/assets_tree_bloc.dart';
import 'package:tractian_test/assets_tree/presentation/pages/menu/menu_bloc.dart';
import 'package:tractian_test/core/utils/injector/injector.dart';

class AssetsTreeInjector extends Injector {
  final GetIt _getIt = GetIt.instance;

  @override
  void initialize() {
    registerServices();
    registerDatasources();
    registerUsecases();
    registerBlocs();
  }

  @override
  void registerServices() {}

  @override
  void registerDatasources() {
    _getIt.registerFactory<AssetsTreeDatasource>(
      () => AssetsTreeDatasource(
        httpService: _getIt.get(),
      ),
    );
  }

  @override
  void registerUsecases() {
    _getIt.registerFactory<GetAssetsTreeUsecase>(
      () => GetAssetsTreeUsecase(
        datasource: _getIt.get(),
      ),
    );
    _getIt.registerFactory<GetCompaniesUsecase>(
      () => GetCompaniesUsecase(
        datasource: _getIt.get(),
      ),
    );
  }

  @override
  void registerBlocs() {
    _getIt.registerFactory<MenuBloc>(
      () => MenuBloc(
        getCompaniesUsecase: _getIt.get(),
      ),
    );
    _getIt.registerFactory<AssetsTreeBloc>(
      () => AssetsTreeBloc(
        getAssetsTreeUsecase: _getIt.get(),
      ),
    );
  }
}
