import '../data/models/unit_detail_model.dart';

abstract class UnitDetailState {}

class UnitDetailInitial extends UnitDetailState {}

class UnitDetailLoading extends UnitDetailState {}

class UnitDetailSuccess extends UnitDetailState {
  final UnitDetailModel unit;

  UnitDetailSuccess(this.unit);
}

class UnitDetailFailure extends UnitDetailState {
  final String message;

  UnitDetailFailure(this.message);
}