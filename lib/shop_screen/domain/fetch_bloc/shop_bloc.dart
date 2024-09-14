import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../model/shop_model.dart';
import '../../services/fetch_shop.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  final FetchShopService shopService = FetchShopService();
  int currentPage = 1; // Track current page
  bool isFetching = false; // To avoid multiple fetches
  bool hasMoreData = true; // Track if more data is available
  ShopBloc() : super(ShopInitial()) {
    on<GetShopList>((event, emit) async {
      if (isFetching || !hasMoreData) return;
      isFetching = true;
      emit(ShopLoading());
      try {
        final ShopModel? shopModel =
            await shopService.getShops(page: currentPage);
        if (shopModel != null && shopModel.shopData != null) {
          // Check if there's more data to load
          if (currentPage >= shopModel.pagination!.totalPages!) {
            hasMoreData = false;
          } else {
            currentPage++;
          }

          emit(ShopSuccess(shopModel: shopModel));
        } else {
          emit(const ShopError(strError: 'No shops found'));
        }
      } on DioException catch (e) {
        emit(ShopError(strError: e.message ?? 'An error occurred'));
      } catch (error) {
        emit(ShopError(strError: 'Unexpected error: $error'));
      } finally {
        isFetching = false;
      }
    });
  }
}
