import 'package:flutter/material.dart';

class AssetsTreeRouter {
  static Future<void> goToAssetsTreePage({
    required BuildContext context,
    required String companyId,
  }) async {
    await Navigator.of(context).pushNamed(
      '/assets_tree',
      arguments: companyId,
    );
  }
}
