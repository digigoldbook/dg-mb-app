import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../model/gold_deposit_model.dart';
import '../services/gold_deposite_service.dart';

part 'list_gold_deposit_event.dart';
part 'list_gold_deposit_state.dart';

class ListGoldDepositBloc
    extends Bloc<ListGoldDepositEvent, ListGoldDepositState> {
  ListGoldDepositBloc() : super(ListGoldDepositInitial()) {
    final Golddepositservice golddepositservice = Golddepositservice();
    on<FetchGoldDeposit>((event, emit) async {
      try {
        emit(GoldDepostLoading());
        final items = await golddepositservice.fetchItems();
        emit(GoldDepostLoaded(goldDeposit: items));
      } catch (error) {
        emit(GoldDepostError(message: "Error: $error"));
      }
    });
  }
}
