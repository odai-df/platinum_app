import 'package:flutter/material.dart';


@immutable
abstract class ContractState {}


class ContractInitial extends ContractState {}


class ContractLoading extends ContractState {}


class ContractLoaded extends ContractState {}


class ContractEmpty extends ContractState {}


class ContractError extends ContractState {

  final String message;

  ContractError(this.message);
}

class ContractDetailsLoaded extends ContractState {}