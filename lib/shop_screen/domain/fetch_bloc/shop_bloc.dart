import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/shop_model.dart';
import '../../services/fetch_shop.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final FetchShopService shopService = FetchShopService();

  ShopBloc() : super(ShopInitial()) {
    on<GetShopList>((event, emit) async {
      emit(ShopLoading()); // Emit loading state

      try {
        // Fetch all shops without pagination
        final ShopModel? shopModel = await shopService.getShops();

        if (shopModel != null &&
            shopModel.shopData != null &&
            shopModel.shopData!.isNotEmpty) {
          // Emit success state with all shop data
          emit(ShopSuccess(shopModel: shopModel));
        } else {
          // Handle the case where no data is returned
          emit(const ShopError(strError: 'No shops found'));
        }
      } on DioException catch (e) {
        emit(ShopError(strError: e.message ?? 'An error occurred'));
      } catch (error) {
        emit(ShopError(strError: 'Unexpected error: $error'));
      }
    });
  }
}
