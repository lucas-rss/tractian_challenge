import 'package:tractian_test/assets_tree/assets_tree_injector.dart';
import 'package:tractian_test/core/utils/injector/app_injector.dart';
import 'package:tractian_test/core/utils/injector/injector.dart';

class InjectorConfig {
  static final List<Injector> _injectorsToRegister = [
    AppInjector(),
    AssetsTreeInjector(),
  ];

  static void initializeAllInjectors() {
    for (var injector in _injectorsToRegister) {
      injector.initialize();
    }
  }
}
