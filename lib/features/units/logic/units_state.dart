import '../data/models/unit_model.dart';

abstract class UnitsState {}

class UnitsInitial extends UnitsState {}

class UnitsLoading extends UnitsState {}

class UnitsSuccess extends UnitsState {
  final List<UnitModel> units;
  final bool isLastPage;

  UnitsSuccess({
    required this.units,
    required this.isLastPage,
  });
}

class UnitsFailure extends UnitsState {
  final String message;

  UnitsFailure(this.message);
}

class UnitsLoadingMore extends UnitsState {}