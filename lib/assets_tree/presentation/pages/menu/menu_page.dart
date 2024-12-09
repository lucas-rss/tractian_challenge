import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tractian_test/assets_tree/presentation/pages/menu/menu_bloc.dart';
import 'package:tractian_test/assets_tree/presentation/pages/menu/menu_state.dart';
import 'package:tractian_test/assets_tree/presentation/routes/assets_tree_router.dart';
import 'package:tractian_test/assets_tree/presentation/widgets/company_card.dart';
import 'package:tractian_test/core/utils/svg_icons.dart';

class MenuPage extends StatefulWidget {
  final MenuBloc bloc;

  const MenuPage({super.key, required this.bloc});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late final MenuBloc _bloc;

  @override
  void initState() {
    _bloc = widget.bloc;
    _bloc.getCompanies();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: SvgPicture.asset(SvgIcons.tractian),
        backgroundColor: const Color(0xFF17192D),
        centerTitle: true,
      ),
      body: BlocBuilder<MenuBloc, MenuState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is MenuLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF17192D),
              ),
            );
          }
          if (state is MenuSuccess) {
            return ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 25,
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 45,
              ),
              itemCount: state.companies.length,
              itemBuilder: (context, index) {
                return CompanyCard(
                  company: state.companies.elementAt(index),
                  onTap: (companyId) {
                    AssetsTreeRouter.goToAssetsTreePage(
                      context: context,
                      companyId: companyId,
                    );
                  },
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
