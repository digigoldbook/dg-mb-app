import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../components/config/app_icons.dart';
import '../../components/utils/toast_utils.dart';
import '../../components/widget/btn_widget.dart';
import '../../components/widget/text_field_widget.dart';
import '../../components/widget/txt_widget.dart';
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

  Future<void> _addNewShop() async {
    setState(() {
      _isLoading = true; // Start loading
    });
    try {
      bool success = await addNewShopService(
        shopName: _shopName.text,
        shopAddress: _shopAddress.text,
        shopRegNo: _shopRegNo.text,
        shopContact: _shopContact.text,
      );

      if (success) {
        showToast('Shop created successfully!');
      } else {
        showToast('Failed to create shop.');
      }
    } catch (e) {
      showToast('Error: $e');
    } finally {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Center(
            child: TxtWidget(strText: "New Shop", style: TxtStyle.mdb),
          ),
          const Gap(8 * 4),
          TextFieldWidget(
            controller: _shopName,
            inputType: TextInputType.text,
            hintText: 'Sharma Pvt. Ltd.',
            prefixIcon: AppIcons.instance.shop,
          ),
          const Gap(16),
          TextFieldWidget(
            controller: _shopAddress,
            inputType: TextInputType.text,
            hintText: 'Kathmandu-16, Banasthali',
            prefixIcon: AppIcons.instance.locationCity,
          ),
          const Gap(16),
          TextFieldWidget(
            controller: _shopRegNo,
            inputType: TextInputType.text,
            hintText: '1244Px21',
            prefixIcon: AppIcons.instance.number,
          ),
          const Gap(16),
          TextFieldWidget(
            controller: _shopContact,
            inputType: TextInputType.number,
            hintText: '9845009423',
            prefixIcon: AppIcons.instance.phone,
          ),
          const Gap(8 * 4),
          _isLoading // Show loader if it's loading
              ? const CircularProgressIndicator()
              : BtnWidget(
                  btnText: "Add New",
                  onTap: () async {
                    await _addNewShop();
                  },
                ),
        ],
      ),
    );
  }
}
