part of 'cash_deposit_bloc.dart';

sealed class CashDepositState extends Equatable {
  const CashDepositState();

  @override
  List<Object> get props => [];
}

final class CashDepositInitial extends CashDepositState {}

final class CashDepositLoading extends CashDepositState {}

final class CashDepositError extends CashDepositState {
  final String strError;

  const CashDepositError({
    required this.strError,
  });

  @override
  List<Object> get props => [strError];
}

final class CashDepositLoaded extends CashDepositState {
  final CashDepositModel cashDepositModel;

  const CashDepositLoaded({
    required this.cashDepositModel,
  });

  @override
  List<Object> get props => [cashDepositModel];
}

class InterestCalculated extends CashDepositState {
  final double interest;

  const InterestCalculated(this.interest);

  @override
  List<Object> get props => [interest];
}

class CashDepositSuccess extends CashDepositState {}

class CashDepositFailure extends CashDepositState {
  final String error;

  const CashDepositFailure(this.error);

  @override
  List<Object> get props => [error];
}
