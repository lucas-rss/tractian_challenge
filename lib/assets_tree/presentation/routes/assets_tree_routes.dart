import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tractian_test/assets_tree/presentation/pages/assets_tree/assets_tree_page.dart';
import 'package:tractian_test/assets_tree/presentation/pages/menu/menu_page.dart';
import 'package:tractian_test/core/utils/routes/module_routes.dart';

class AssetsTreeRoutes extends ModuleRoutes {
  final _getIt = GetIt.instance;

  @override
  Map<String, WidgetBuilder> getRoutes() {
    return {
      '/menu': (context) {
        return MenuPage(bloc: _getIt.get());
      },
      '/assets_tree': (context) {
        final companyId = ModalRoute.of(context)!.settings.arguments as String;
        return AssetsTreePage(
          companyId: companyId,
          bloc: _getIt.get(),
        );
      }
    };
  }
}
