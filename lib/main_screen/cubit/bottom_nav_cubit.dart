import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavInitial(index: 0));

  void currentIndex(int value) {
    emit(BottomNavInitial(index: value));
  }
}
