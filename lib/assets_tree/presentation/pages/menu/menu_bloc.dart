import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_test/assets_tree/domain/usecases/get_companies_usecase.dart';
import 'package:tractian_test/assets_tree/presentation/pages/menu/menu_state.dart';

class MenuBloc extends Cubit<MenuState> {
  final GetCompaniesUsecase _getCompaniesUsecase;

  MenuBloc({
    required GetCompaniesUsecase getCompaniesUsecase,
  })  : _getCompaniesUsecase = getCompaniesUsecase,
        super(MenuInitial());

  Future<void> getCompanies() async {
    emit(MenuLoading());
    final companies = await _getCompaniesUsecase();
    emit(MenuSuccess(companies: companies));
  }
}
