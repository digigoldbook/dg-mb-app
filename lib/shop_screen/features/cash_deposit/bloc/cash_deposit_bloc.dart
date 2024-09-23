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

    on<CalculateInterestEvent>((event, emit) {
      final interest =
          (event.amount * event.rate * event.time * 30) / (100 * 365);
      emit(InterestCalculated(interest));
    });

    on<AddToBookEvent>((event, emit) async {
      Map<String, dynamic> cashDepositData = {
        "amount": event.amount,
        "rate": event.rate,
        "time": event.time,
        "interest": event.interest,
        "customer_name": event.customerName,
        "customer_contact": event.customerContact,
        "shop_id": 14,
      };

      try {
        final response =
            await cashdepositservice.submitCashDeposit(cashDepositData);

        if (response.statusCode == 200) {
          emit(CashDepositSuccess());
        } else {
          emit(const CashDepositFailure("Failed to add. Try again!"));
        }
      } catch (e) {
        emit(CashDepositFailure("Error: $e"));
      }
    });

    on<DeleteCashDepositEvent>((event, emit) async {
      try {
        emit(CashDepositLoading());

        final response = await cashdepositservice.deleteCashDeposit({
          "itemId": event.id,
        });
        if (response.statusCode == 200) {
          final items = await cashdepositservice.fetchItems();
          emit(CashDepositLoaded(cashDepositModel: items));
        } else {
          emit(const CashDepositFailure("Failed to delete. Try again!"));
        }
      } catch (e) {
        emit(CashDepositFailure("Error: $e"));
      }
    });
  }
}
