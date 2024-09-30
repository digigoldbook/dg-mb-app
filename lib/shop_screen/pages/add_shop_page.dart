import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../components/config/app_icons.dart';
import '../../components/config/app_localization.dart';
import '../../components/utils/toast_utils.dart';
import '../../components/widget/btn_widget.dart';
import '../../components/widget/text_field_widget.dart';
import '../../components/widget/txt_widget.dart';
import '../domain/fetch_bloc/shop_bloc.dart';
import '../services/add_shop.dart';

class AddShopPage extends StatefulWidget {
  const AddShopPage({super.key});

  @override
  State<AddShopPage> createState() => _AddShopPageState();
}

class _AddShopPageState extends State<AddShopPage> {
  final TextEditingController _shopName = TextEditingController();
  final TextEditingController _shopAddress = TextEditingController();
  final TextEditingController _shopRegNo = TextEditingController();
  final TextEditingController _shopContact = TextEditingController();

  bool _isLoading = false; // To track the loading state

  Future<bool> _addNewShop() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final Response success = await addNewShopService(
        shopName: _shopName.text,
        shopAddress: _shopAddress.text,
        shopRegNo: _shopRegNo.text,
        shopContact: _shopContact.text,
      );

      if (success.statusCode == 201) {
        showToast('Shop created successfully!');
        return true;
      } else {
        showToast('Failed to create shop.');
        return false;
      }
    } catch (e) {
      showToast('Error: $e');
      return false;
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Center(
            child: TxtWidget(
              strText: AppLocalizations.of(context)!.translate("registerShop"),
              style: TxtStyle.mdb,
            ),
          ),
          const Gap(8 * 4),
          TextFieldWidget(
            controller: _shopName,
            inputType: TextInputType.text,
            hintText: AppLocalizations.of(context)!.translate("shopName"),
            prefixIcon: AppIcons.instance.shop,
          ),
          const Gap(16),
          TextFieldWidget(
            controller: _shopAddress,
            inputType: TextInputType.text,
            hintText: AppLocalizations.of(context)!.translate("address"),
            prefixIcon: AppIcons.instance.navigation,
          ),
          const Gap(16),
          TextFieldWidget(
            controller: _shopRegNo,
            inputType: TextInputType.text,
            hintText: AppLocalizations.of(context)!.translate("registrationNo"),
            prefixIcon: AppIcons.instance.number,
          ),
          const Gap(16),
          TextFieldWidget(
            controller: _shopContact,
            inputType: TextInputType.number,
            hintText: AppLocalizations.of(context)!.translate("contactNo"),
            prefixIcon: AppIcons.instance.phone,
          ),
          const Gap(8 * 4),
          _isLoading // Show loader if it's loading
              ? const CircularProgressIndicator()
              : BtnWidget(
                  btnText: "Register Shop",
                  onTap: () async {
                    final bool response = await _addNewShop();
                    if (response == true) {
                      context.read<ShopBloc>().add(GetShopList());
                      Navigator.pop(context);
                    }
                  },
                ),
        ],
      ),
    );
  }
}
