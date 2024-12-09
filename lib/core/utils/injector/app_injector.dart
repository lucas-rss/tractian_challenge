import 'package:get_it/get_it.dart';
import 'package:tractian_test/core/services/http_service.dart';
import 'package:tractian_test/core/utils/constants/api_constants.dart';
import 'package:tractian_test/core/utils/injector/injector.dart';

class AppInjector extends Injector {
  final GetIt _getIt = GetIt.instance;

  @override
  void initialize() {
    registerServices();
    registerDatasources();
    registerUsecases();
    registerBlocs();
  }

  @override
  void registerServices() {
    _getIt.registerFactory<HttpService>(
      () => HttpService(ApiConstants.fakeTractianBaseUrl),
    );
  }

  @override
  void registerDatasources() {}

  @override
  void registerUsecases() {}

  @override
  void registerBlocs() {}
}
