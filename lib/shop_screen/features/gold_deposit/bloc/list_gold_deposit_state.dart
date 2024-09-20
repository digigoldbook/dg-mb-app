part of 'list_gold_deposit_bloc.dart';

sealed class ListGoldDepositState extends Equatable {
  const ListGoldDepositState();

  @override
  List<Object> get props => [];
}

final class ListGoldDepositInitial extends ListGoldDepositState {}

class GoldDepostLoading extends ListGoldDepositState {}

class GoldDepostLoaded extends ListGoldDepositState {
  final GoldDepositModel goldDeposit;

  const GoldDepostLoaded({
    required this.goldDeposit,
  });

  @override
  List<Object> get props => [goldDeposit];
}

class GoldDepostError extends ListGoldDepositState {
  final String message;

  const GoldDepostError({required this.message});

  @override
  List<Object> get props => [message];
}
