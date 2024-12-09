import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/asset_node_model.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/location_node_model.dart';
import 'package:tractian_test/assets_tree/data/models/tree_models/tree_node_model.dart';
import 'package:tractian_test/core/utils/svg_icons.dart';

class TreeBranch extends StatefulWidget {
  final TreeNodeModel treeNode;

  const TreeBranch({super.key, required this.treeNode});

  @override
  State<TreeBranch> createState() => _TreeBranchState();
}

class _TreeBranchState extends State<TreeBranch> {
  late final TreeNodeModel _treeNode;
  late final String _leadingAssetPath;

  @override
  void initState() {
    _treeNode = widget.treeNode;
    if (_treeNode is LocationNodeModel) {
      _leadingAssetPath = SvgIcons.location;
    } else if (_treeNode is AssetNodeModel) {
      if (_treeNode.sensorType != null) {
        _leadingAssetPath = SvgIcons.component;
      } else {
        _leadingAssetPath = SvgIcons.asset;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_treeNode.children.isEmpty) {
      return ListTile(
        leading: SvgPicture.asset(_leadingAssetPath),
        title: Text(
          _treeNode.name,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xFF17192D),
          ),
        ),
      );
    }

    return ExpansionTile(
      leading: SvgPicture.asset(_leadingAssetPath),
      title: Text(
        _treeNode.name,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: Color(0xFF17192D),
        ),
      ),
      children: _treeNode.children
          .map((childNode) => TreeBranch(treeNode: childNode))
          .toList(),
    );
  }
}
