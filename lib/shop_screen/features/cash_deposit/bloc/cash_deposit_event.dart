part of 'cash_deposit_bloc.dart';

sealed class CashDepositEvent extends Equatable {
  const CashDepositEvent();

  @override
  List<Object> get props => [];
}

class ListCashDeposit extends CashDepositEvent {}

class CalculateInterestEvent extends CashDepositEvent {
  final double amount;
  final double rate;
  final int time;

  const CalculateInterestEvent(
    this.amount,
    this.rate,
    this.time,
  );

  @override
  List<Object> get props => [amount, rate, time];
}

class AddToBookEvent extends CashDepositEvent {
  final double amount;
  final double rate;
  final int time;
  final double interest;
  final String customerName;
  final String customerContact;

  const AddToBookEvent(
    this.amount,
    this.rate,
    this.time,
    this.interest,
    this.customerName,
    this.customerContact,
  );

  @override
  List<Object> get props =>
      [amount, rate, time, interest, customerName, customerContact];
}

class DeleteCashDepositEvent extends CashDepositEvent {
  final int id;

  const DeleteCashDepositEvent(this.id);
}
