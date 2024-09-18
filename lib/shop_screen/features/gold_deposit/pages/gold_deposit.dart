import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../components/widget/app_bar.dart';
import '../../../../components/widget/btn_widget.dart';
import '../../../../components/widget/text_field_widget.dart';

final Dio dio = Dio();

class GoldDeposit extends StatefulWidget {
  const GoldDeposit({super.key});

  @override
  State<GoldDeposit> createState() => _GoldDepositState();
}

class _GoldDepositState extends State<GoldDeposit> {
  final TextEditingController _productTitle = TextEditingController();
  final TextEditingController _productAmt = TextEditingController();
  final TextEditingController _period = TextEditingController();
  final TextEditingController _rate = TextEditingController();

  Future getItems() async {
    final response = await dio.get(
        "http://192.168.1.87:3000/api/v1/gold-deposit?page=1&perPage=10&sort=desc");
    if (response.statusCode == 200) {
      return response.data;
    }
  }

  @override
  void initState() {
    getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: FutureBuilder(
        future: getItems(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data['data'].length,
                itemBuilder: (context, index) {
                  final List<dynamic> items =
                      snapshot.data['data'][index]['items'];
                  return Column(
                    children: items
                        .map((value) => Column(
                              children: [
                                Text("${value['product_title']}"),
                                Text("Amount: ${value['product_amt']}"),
                                Text("Amount: ${value['rate']}"),
                                Text("Amount: ${value['period']}"),
                                const Divider(),
                              ],
                            ))
                        .toList(),
                  );
                });
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return ListView(
                    children: [
                      TextFieldWidget(
                        controller: _productTitle,
                        inputType: TextInputType.text,
                        hintText: "Rani Haar",
                        prefixIcon: Icons.abc,
                      ),
                      const Gap(16),
                      TextFieldWidget(
                        controller: _productAmt,
                        inputType: TextInputType.number,
                        hintText: "Rs. ****",
                        prefixIcon: Icons.numbers,
                      ),
                      const Gap(16),
                      TextFieldWidget(
                        controller: _period,
                        inputType: TextInputType.number,
                        hintText: "12",
                        prefixIcon: Icons.watch_later_outlined,
                      ),
                      const Gap(16),
                      TextFieldWidget(
                        controller: _rate,
                        inputType: TextInputType.number,
                        hintText: "12",
                        prefixIcon: Icons.percent,
                      ),
                      const Gap(16),
                      BtnWidget(
                        btnText: "Add",
                        onTap: () {},
                      ),
                    ],
                  );
                });
          }),
    );
  }
}
