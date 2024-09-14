import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_shop_event.dart';
part 'add_shop_state.dart';

class AddShopBloc extends Bloc<AddShopEvent, AddShopState> {
  AddShopBloc() : super(AddShopInitial()) {
    on<AddShopEvent>((event, emit) {});
  }
}
