part of 'shop_bloc.dart';

sealed class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

final class ShopInitial extends ShopState {}

final class ShopLoading extends ShopState {}

final class ShopError extends ShopState {
  final String strError;

  const ShopError({
    required this.strError,
  });
  @override
  List<Object> get props => [strError];
}

final class ShopSuccess extends ShopState {
  final ShopModel shopModel;

  const ShopSuccess({
    required this.shopModel,
  });

  @override
  List<Object> get props => [shopModel];
}
