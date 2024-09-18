import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

import '../domain/fetch_bloc/shop_bloc.dart';
import '../model/shop_model.dart';
import '../widgets/shop_page_delete_widget.dart';
import '../widgets/shop_page_update_widget.dart';

class ShopUiPage extends StatefulWidget {
  const ShopUiPage({super.key});

  @override
  State<ShopUiPage> createState() => _ShopUiPageState();
}

class _ShopUiPageState extends State<ShopUiPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<ShopBloc>().add(GetShopList());
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ShopBloc>().add(GetShopList());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= maxScroll * 0.9;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        if (state is ShopLoading && state is! ShopSuccess) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ShopError) {
          return Center(child: Text(state.strError));
        } else if (state is ShopSuccess) {
          final shops = state.shopModel.shopData!;
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            separatorBuilder: (context, index) => const Divider(),
            controller: _scrollController,
            itemCount: shops.length,
            itemBuilder: (context, index) {
              final ShopData shop = shops[index];
              if (index == shops.length) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Slidable(
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      ShopPageUpdateWidget(shopId: shop.id!),
                      ShopPageDeleteWidget(shopId: shop.id!),
                    ],
                  ),
                  child: ListTile(
                    onTap: () => context.pushNamed("shop-details"),
                    title: Text(shop.shopName ?? 'Unknown Shop'),
                    subtitle: Text(shop.shopAddress ?? 'No Address'),
                    trailing: Text(shop.shopContact ?? 'No Contact'),
                  ),
                );
              }
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
