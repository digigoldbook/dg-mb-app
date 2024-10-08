part of 'bottom_nav_cubit.dart';

sealed class BottomNavState extends Equatable {
  const BottomNavState();

  @override
  List<Object> get props => [];
}

final class BottomNavInitial extends BottomNavState {
  final int index;

  const BottomNavInitial({required this.index});

  @override
  List<Object> get props => [index];
}
