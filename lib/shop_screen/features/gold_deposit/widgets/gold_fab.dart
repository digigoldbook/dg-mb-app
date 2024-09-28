import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../components/config/app_icons.dart';
import '../../../../components/config/app_localization.dart';
import '../../../../components/utils/toast_utils.dart';
import '../../../../components/widget/app_bar.dart';
import '../../../../components/widget/btn_widget.dart';
import '../../../../components/widget/text_field_widget.dart';
import '../services/gold_deposite_service.dart';

class GoldFAB extends StatefulWidget {
  const GoldFAB({super.key});

  @override
  State<GoldFAB> createState() => _GoldFABState();
}

class _GoldFABState extends State<GoldFAB> {
  final TextEditingController _customerName = TextEditingController();
  final TextEditingController _billNo = TextEditingController();
  final TextEditingController _contactNo = TextEditingController();
  final TextEditingController _postTitle = TextEditingController();
  final TextEditingController _productAmtController = TextEditingController();
  final TextEditingController _periodController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _countController = TextEditingController();

  String _periodUnit = 'month';
  String _weightUnit = 'grams';

  List<ProductFields> productList = [ProductFields()];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    // Dispose of all controllers
    _customerName.dispose();
    _contactNo.dispose();
    _postTitle.dispose();
    _billNo.dispose();
    _productAmtController.dispose();
    _periodController.dispose();
    _rateController.dispose();
    _weightController.dispose();
    _countController.dispose();
    for (var product in productList) {
      product.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFieldWidget(
              controller: _billNo,
              inputType: TextInputType.text,
              hintText: AppLocalizations.of(context)!.translate("billNo"),
              prefixIcon: AppIcons.instance.number,
            ),
            const Gap(16),
            TextFieldWidget(
              controller: _customerName,
              inputType: TextInputType.text,
              hintText: AppLocalizations.of(context)!.translate("customerName"),
              prefixIcon: AppIcons.instance.person,
            ),
            const Gap(16),

            TextFieldWidget(
              controller: _contactNo,
              inputType: TextInputType.text,
              hintText: AppLocalizations.of(context)!.translate("contactNo"),
              prefixIcon: AppIcons.instance.number,
            ),
            const Gap(16),
            TextFieldWidget(
              controller: _postTitle,
              inputType: TextInputType.text,
              hintText: AppLocalizations.of(context)!.translate("recordTitle"),
              prefixIcon: Icons.abc,
            ),
            const Gap(16),
            ...List.generate(productList.length, (index) {
              return Row(
                children: [
                  Expanded(
                    child: TextFieldWidget(
                      controller: productList[index].productTitleController,
                      inputType: TextInputType.text,
                      hintText: AppLocalizations.of(context)!
                          .translate("productTitle"),
                      prefixIcon: Icons.abc,
                      // Display + for the last item, and delete for others
                      suffix: IconButton(
                        icon: Icon(
                          index == productList.length - 1
                              ? Icons.add
                              : Icons.delete,
                          color: index == productList.length - 1
                              ? Colors.green
                              : Colors.red,
                        ),
                        onPressed: index == productList.length - 1
                            ? () {
                                // Add a new field when + is clicked
                                setState(() {
                                  productList.add(ProductFields());
                                });
                              }
                            : productList.length > 1
                                ? () {
                                    // Remove the field if there are more than one
                                    setState(() {
                                      productList.removeAt(index);
                                    });
                                  }
                                : null, // Disable delete if it's the only field
                      ),
                    ),
                  ),
                ],
              );
            }),

            const Gap(16),

            Row(
              children: [
                Expanded(
                  child: TextFieldWidget(
                    controller: _weightController,
                    inputType: TextInputType.number,
                    hintText: AppLocalizations.of(context)!.translate("weight"),
                    prefixIcon: Icons.scale,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _weightUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        _weightUnit = newValue!;
                      });
                    },
                    items: <String>['grams', 'tola', 'lal', 'rathi']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const Gap(16),

            // Common fields for all products (outside the dynamic product section)
            TextFieldWidget(
              controller: _productAmtController,
              inputType: TextInputType.number,
              hintText: AppLocalizations.of(context)!.translate("amount"),
              prefixIcon: Icons.currency_rupee_sharp,
            ),
            const Gap(16),

            Row(
              children: [
                Expanded(
                  child: TextFieldWidget(
                    controller: _periodController,
                    inputType: TextInputType.number,
                    hintText: AppLocalizations.of(context)!.translate("period"),
                    prefixIcon: Icons.watch_later_outlined,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _periodUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        _periodUnit = newValue!;
                      });
                    },
                    items: <String>['month', 'year']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const Gap(16),

            TextFieldWidget(
              controller: _rateController,
              inputType: TextInputType.number,
              hintText: AppLocalizations.of(context)!.translate("rate"),
              prefixIcon: Icons.percent,
            ),
            const Gap(16),

            TextFieldWidget(
              controller: _countController,
              inputType: TextInputType.number,
              hintText: AppLocalizations.of(context)!.translate("total"),
              prefixIcon: Icons.format_list_numbered,
            ),
            const Gap(16),

            // Submit Button
            BtnWidget(
              btnText: "Submit",
              onTap: _submitForm,
            ),

            if (_isLoading) const Center(child: CircularProgressIndicator()),

            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final postTitle = _postTitle.text;
    final items = productList.map((product) {
      return {
        'item': product.productTitleController.text,
      };
    }).toList();

    final requestBody = {
      'product_name': postTitle,
      'product_title': items,
      'shop_id': 14,
      'customer_name': _customerName.text,
      'customer_contact': _contactNo.text,
      'bank_bone_number': "",
      'product_amount': double.tryParse(_productAmtController.text) ?? 0.0,
      'product_rate': double.tryParse(_rateController.text) ?? 0.0,
      'duration': int.tryParse(_periodController.text) ?? 0,
      'duration_unit': _periodUnit,
      'item_count': int.tryParse(_countController.text) ?? 0,
      'product_status': 'running',
      'unique_code': _billNo.text,
    };

    try {
      final goldDepositService = Golddepositservice();
      final response = await goldDepositService.submitGoldDeposit(requestBody);
      if (response.statusCode == 201) {
        showToast("New Record has been added to the book");
      } else {
        showToast("$_errorMessage");
        setState(() {
          _errorMessage = 'Error ${response.statusCode}: ${response.data}';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to submit gold deposit: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class ProductFields {
  TextEditingController productTitleController = TextEditingController();

  // Dispose of the controllers when not needed
  void dispose() {
    productTitleController.dispose();
  }
}
