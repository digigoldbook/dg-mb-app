import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
  final TextEditingController _postTitle = TextEditingController();
  List<ProductFields> productList = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Title for the record
            TextFieldWidget(
              controller: _postTitle,
              inputType: TextInputType.text,
              hintText: "Record Title",
              prefixIcon: Icons.abc,
            ),
            const Gap(16),

            // List of product sections
            ...List.generate(productList.length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product heading (Product 1, Product 2, etc.)
                  Text(
                    'Product ${index + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Gap(8),
                  // Product title field
                  TextFieldWidget(
                    controller: productList[index].productTitleController,
                    inputType: TextInputType.text,
                    hintText: "Product Title",
                    prefixIcon: Icons.abc,
                  ),
                  const Gap(16),

                  // Product amount field
                  TextFieldWidget(
                    controller: productList[index].productAmtController,
                    inputType: TextInputType.number,
                    hintText: "Amount",
                    prefixIcon: Icons.currency_rupee_sharp,
                  ),
                  const Gap(16),

                  // Row for period and period unit
                  Row(
                    children: [
                      // Period field
                      Expanded(
                        child: TextFieldWidget(
                          controller: productList[index].periodController,
                          inputType: TextInputType.number,
                          hintText: "Period",
                          prefixIcon: Icons.watch_later_outlined,
                        ),
                      ),
                      const Gap(16),
                      // Dropdown for period unit
                      Expanded(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: productList[index].periodUnit,
                          onChanged: (String? newValue) {
                            setState(() {
                              productList[index].periodUnit = newValue!;
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

                  // Product rate field
                  TextFieldWidget(
                    controller: productList[index].rateController,
                    inputType: TextInputType.number,
                    hintText: "Rate",
                    prefixIcon: Icons.percent,
                  ),
                  const Gap(16),

                  // Delete button for each product
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          productList.removeAt(index);
                        });
                      },
                    ),
                  ),
                  const Divider(),
                ],
              );
            }),

            // Add Another Product button
            BtnWidget(
              btnText: "Add Another Product",
              onTap: () {
                setState(() {
                  productList.add(ProductFields());
                });
              },
            ),
            const Gap(16),

            // Main submit button for the entire form
            BtnWidget(
              btnText: "Submit",
              onTap: () {
                _submitForm();
              },
            ),
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
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
        'product_title': product.productTitleController.text,
        'product_amt':
            double.tryParse(product.productAmtController.text) ?? 0.0,
        'period': int.tryParse(product.periodController.text) ?? 0,
        'period_unit': product.periodUnit, // Use the selected period unit
        'rate': double.tryParse(product.rateController.text) ?? 0.0,
      };
    }).toList();

    final requestBody = {
      'userId': 3,
      'post_title': postTitle,
      'items': items,
    };

    final goldDepositService = Golddepositservice();
    try {
      await goldDepositService.submitGoldDeposit(requestBody);
      showToast("New Record has been added to the book");
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

// A helper class to maintain product-related controllers
class ProductFields {
  TextEditingController productTitleController = TextEditingController();
  TextEditingController productAmtController = TextEditingController();
  TextEditingController periodController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  String periodUnit = 'month'; // Default value
}
