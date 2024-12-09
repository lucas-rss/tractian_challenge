import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_test/assets_tree/domain/usecases/get_assets_tree_usecase.dart';
import 'package:tractian_test/assets_tree/presentation/pages/assets_tree/assets_tree_state.dart';

class AssetsTreeBloc extends Cubit<AssetsTreeState> {
  final GetAssetsTreeUsecase _getAssetsTreeUsecase;

  AssetsTreeBloc({
    required GetAssetsTreeUsecase getAssetsTreeUsecase,
  })  : _getAssetsTreeUsecase = getAssetsTreeUsecase,
        super(AssetsTreeInitial());

  Future<void> buildUnitAssetsTree(String companyId) async {
    await _getAssetsTreeUsecase(companyId);
  }
}
