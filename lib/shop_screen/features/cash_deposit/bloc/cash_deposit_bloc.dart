import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/cash_deposit_model.dart';
import '../service/cash_deposit_service.dart';

part 'cash_deposit_event.dart';
part 'cash_deposit_state.dart';

class CashDepositBloc extends Bloc<CashDepositEvent, CashDepositState> {
  CashDepositBloc() : super(CashDepositInitial()) {
    final Cashdepositservice cashdepositservice = Cashdepositservice();
    on<ListCashDeposit>((event, emit) async {
      try {
        emit(CashDepositLoading());
        final items = await cashdepositservice.fetchItems();
        emit(CashDepositLoaded(cashDepositModel: items));
      } catch (error) {
        emit(CashDepositError(strError: "Error: $error"));
      }
    });
  }
}
