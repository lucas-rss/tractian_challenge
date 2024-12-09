import 'package:tractian_test/assets_tree/data/models/company_model.dart';

abstract class MenuState {}

class MenuInitial extends MenuState {}

class MenuLoading extends MenuState {}

class MenuSuccess extends MenuState {
  final List<CompanyModel> companies;

  MenuSuccess({required this.companies});
}

class MenuError extends MenuState {}
