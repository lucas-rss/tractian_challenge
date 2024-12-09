import 'package:flutter/material.dart';
import 'package:tractian_test/assets_tree/presentation/routes/assets_tree_routes.dart';
import 'package:tractian_test/core/utils/injector/injector_config.dart';
import 'package:tractian_test/core/utils/routes/app_router.dart';

void main() {
  final appRouter = AppRouter(
    moduleRoutes: [
      AssetsTreeRoutes(),
    ],
  );
  InjectorConfig.initializeAllInjectors();

  runApp(
    AssetsTree(appRouter: appRouter),
  );
}

class AssetsTree extends StatelessWidget {
  final AppRouter _appRouter;

  const AssetsTree({
    super.key,
    required AppRouter appRouter,
  }) : _appRouter = appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tractian',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: '/menu',
      onGenerateRoute: _appRouter.onGenerateRoutes,
    );
  }
}
