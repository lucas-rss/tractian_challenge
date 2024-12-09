import 'package:flutter/material.dart';
import 'package:tractian_test/core/utils/routes/module_routes.dart';

class AppRouter {
  final List<ModuleRoutes> _moduleRoutes;

  AppRouter({
    required List<ModuleRoutes> moduleRoutes,
  }) : _moduleRoutes = moduleRoutes;

  Route<dynamic>? onGenerateRoutes(RouteSettings settings) {
    for (var module in _moduleRoutes) {
      var routes = module.getRoutes();
      if (routes.containsKey(settings.name)) {
        return MaterialPageRoute(
          builder: routes[settings.name]!,
          settings: settings,
        );
      }
    }

    return MaterialPageRoute(
      builder: (context) => Container(),
      settings: settings,
    );
  }
}
