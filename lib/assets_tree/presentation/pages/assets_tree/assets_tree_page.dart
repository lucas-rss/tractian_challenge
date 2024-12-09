import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_test/assets_tree/presentation/pages/assets_tree/assets_tree_bloc.dart';
import 'package:tractian_test/assets_tree/presentation/pages/assets_tree/assets_tree_state.dart';
import 'package:tractian_test/assets_tree/presentation/widgets/tree_branch.dart';
import 'package:tractian_test/core/utils/svg_icons.dart';

class AssetsTreePage extends StatefulWidget {
  final String companyId;
  final AssetsTreeBloc bloc;

  const AssetsTreePage({
    super.key,
    required this.companyId,
    required this.bloc,
  });

  @override
  State<AssetsTreePage> createState() => _AssetsTreePageState();
}

class _AssetsTreePageState extends State<AssetsTreePage> {
  late final AssetsTreeBloc _bloc;

  @override
  void initState() {
    _bloc = widget.bloc;
    _bloc.buildUnitAssetsTree(widget.companyId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Assets',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF17192D),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: SvgPicture.asset(SvgIcons.arrowBack),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 32,
              child: TextFormField(
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Buscar Ativo ou Local',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xFF8E98A3),
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      SvgIcons.search,
                      width: 18,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFEAEFF3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFD8DFE6),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          SvgIcons.bolt,
                          theme: const SvgTheme(
                            currentColor: Color(0xFF77818C),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Sensor de Energia',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xFF77818C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                        side: const BorderSide(
                          width: 1,
                          color: Color(0xFFD8DFE6),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          SvgIcons.critical,
                          theme: const SvgTheme(
                            currentColor: Color(0xFF77818C),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Crítico',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xFF77818C),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 0),
          const SizedBox(height: 16),
          BlocBuilder(
            bloc: _bloc,
            builder: (context, state) {
              if (state is AssetsTreeLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF17192D),
                  ),
                );
              }
              if (state is AssetsTreeSuccess) {
                return TreeBranch(treeNode: state.rootNode);
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
