part of 'add_shop_bloc.dart';

sealed class AddShopState extends Equatable {
  const AddShopState();
  
  @override
  List<Object> get props => [];
}

final class AddShopInitial extends AddShopState {}
