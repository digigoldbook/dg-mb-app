part of 'cash_deposit_bloc.dart';

sealed class CashDepositEvent extends Equatable {
  const CashDepositEvent();

  @override
  List<Object> get props => [];
}

class ListCashDeposit extends CashDepositEvent {}
