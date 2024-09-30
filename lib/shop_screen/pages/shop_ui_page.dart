import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart'; // For decoding JWT token
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../components/widget/txt_widget.dart';
import '../domain/fetch_bloc/shop_bloc.dart';
import '../model/shop_model.dart';
import '../../auth/sign_in/hive/token_storage.dart';
import '../widgets/shop_page_delete_widget.dart';
import '../widgets/shop_page_update_widget.dart'; // Import TokenStorage for access token

class ShopUiPage extends StatefulWidget {
  const ShopUiPage({super.key});

  @override
  State<ShopUiPage> createState() => _ShopUiPageState();
}

class _ShopUiPageState extends State<ShopUiPage> {
  int? _currentUserId;

  @override
  void initState() {
    super.initState();
    _getUserIdFromToken();
  }

  Future<void> _getUserIdFromToken() async {
    String? accessToken = await TokenStorage.getAccessToken();
    if (accessToken != null) {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(accessToken);
      setState(() {
        _currentUserId = int.tryParse(decodedToken['userId'].toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        if (state is ShopInitial) {
          context.read<ShopBloc>().add(GetShopList());
        }
        if (state is ShopLoading && state is! ShopSuccess) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ShopError) {
          return Center(child: Text(state.strError));
        } else if (state is ShopSuccess && _currentUserId != null) {
          final shops = state.shopModel.shopData!
              .where((shop) => _isShopOwnedByUser(shop, _currentUserId!))
              .toList();

          if (shops.isEmpty) {
            return const Center(child: Text("No shops found for this user."));
          }

          return LiquidPullToRefresh(
            key: const Key('pull_to_refresh'),
            onRefresh: () async {
              context.read<ShopBloc>().add(GetShopList()); // Fetch data
            },
            showChildOpacityTransition: false,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: shops.length,
              itemBuilder: (context, index) {
                final ShopData shop = shops[index];
                return Slidable(
                  key: ValueKey(shop.id),
                  startActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      ShopPageUpdateWidget(shopId: shop.id!),
                      ShopPageDeleteWidget(shopId: shop.id!),
                    ],
                  ),
                  child: ListTile(
                    tileColor: const Color(0xffDEE5D4),
                    onTap: () async {
                      context.pushNamed("shop-details");
                      final box = await Hive.openBox("shop_id");
                      box.put("shop_id", shop.id);
                    },
                    title: Text(shop.shopName ?? 'Unknown Shop'),
                    subtitle: Text(shop.shopAddress ?? 'No Address'),
                    leading: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(0xffFEF9D9),
                        shape: BoxShape.circle,
                      ),
                      child: TxtWidget(
                        strText: "${index + 1}",
                        style: TxtStyle.rg,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.call),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  bool _isShopOwnedByUser(ShopData shop, int currentUserId) {
    final ownerMeta = shop.shopMeta?.firstWhere(
      (meta) => meta.metaKey == 'owner',
    );

    return ownerMeta != null && ownerMeta.metaValue == currentUserId.toString();
  }
}
