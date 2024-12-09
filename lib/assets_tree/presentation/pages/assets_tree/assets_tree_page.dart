import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_test/assets_tree/presentation/pages/assets_tree/assets_tree_bloc.dart';
import 'package:tractian_test/assets_tree/presentation/pages/assets_tree/assets_tree_state.dart';
import 'package:tractian_test/assets_tree/presentation/widgets/tree_branch.dart';
import 'package:tractian_test/assets_tree/utils/enums/asset_filter_type_enum.dart';
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
      body: SingleChildScrollView(
        child: Column(
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
              child: BlocBuilder<AssetsTreeBloc, AssetsTreeState>(
                bloc: _bloc,
                builder: (context, state) {
                  return Row(
                    children: [
                      SizedBox(
                        height: 32,
                        child: ElevatedButton(
                          onPressed: () {
                            _bloc.setEnergyOrCriticalFilter(
                              AssetFilterTypeEnum.energySensor,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: state.filterType ==
                                    AssetFilterTypeEnum.energySensor
                                ? const Color(0xFF2188FF)
                                : Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              side: state.filterType ==
                                      AssetFilterTypeEnum.energySensor
                                  ? BorderSide.none
                                  : const BorderSide(
                                      width: 1,
                                      color: Color(0xFFD8DFE6),
                                    ),
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                SvgIcons.bolt,
                                colorFilter: ColorFilter.mode(
                                  state.filterType ==
                                          AssetFilterTypeEnum.energySensor
                                      ? Colors.white
                                      : const Color(0xFF77818C),
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Sensor de Energia',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: state.filterType ==
                                          AssetFilterTypeEnum.energySensor
                                      ? Colors.white
                                      : const Color(0xFF77818C),
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
                          onPressed: () {
                            _bloc.setEnergyOrCriticalFilter(
                              AssetFilterTypeEnum.criticalStatus,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: state.filterType ==
                                    AssetFilterTypeEnum.criticalStatus
                                ? const Color(0xFF2188FF)
                                : Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                              side: state.filterType ==
                                      AssetFilterTypeEnum.criticalStatus
                                  ? BorderSide.none
                                  : const BorderSide(
                                      width: 1,
                                      color: Color(0xFFD8DFE6),
                                    ),
                            ),
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                SvgIcons.critical,
                                colorFilter: ColorFilter.mode(
                                  state.filterType ==
                                          AssetFilterTypeEnum.criticalStatus
                                      ? Colors.white
                                      : const Color(0xFF77818C),
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Crítico',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: state.filterType ==
                                          AssetFilterTypeEnum.criticalStatus
                                      ? Colors.white
                                      : const Color(0xFF77818C),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
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
                  return TreeBranch(
                    treeNode: state.currentRootNode ?? state.initialRootNode!,
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
