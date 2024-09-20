part of 'list_gold_deposit_bloc.dart';

sealed class ListGoldDepositEvent extends Equatable {
  const ListGoldDepositEvent();

  @override
  List<Object> get props => [];
}

class FetchGoldDeposit extends ListGoldDepositEvent {}
