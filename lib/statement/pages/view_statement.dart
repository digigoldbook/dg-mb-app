import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../shop_screen/features/cash_deposit/model/cash_deposit_model.dart';
import '../helper/fetch_cash_deposit.dart';

class ViewStatement extends StatefulWidget {
  const ViewStatement({super.key});

  @override
  ViewStatementState createState() => ViewStatementState();
}

class ViewStatementState extends State<ViewStatement> {
  late Future<CashDepositModel> futureCashDeposits;

  @override
  void initState() {
    super.initState();

    // Force landscape mode and hide status/navigation bar for fullscreen mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    futureCashDeposits = fetchCashDeposits();
  }

  @override
  void dispose() {
    // Reset to allow all orientations when leaving the screen
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statement'),
      ),
      body: FutureBuilder<CashDepositModel>(
        future: futureCashDeposits,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.items == null) {
            return const Center(child: Text('No data found'));
          }

          final cashDeposits = snapshot.data!.items;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Amount')),
                DataColumn(label: Text('Rate')),
                DataColumn(label: Text('Time')),
                DataColumn(label: Text('Time Unit')),
                DataColumn(label: Text('Customer Name')),
                DataColumn(label: Text('Customer Contact')),
              ],
              rows: cashDeposits!.map((deposit) {
                return DataRow(cells: [
                  DataCell(Text(deposit.id.toString())),
                  DataCell(Text(deposit.amount.toString())),
                  DataCell(Text(deposit.rate.toString())),
                  DataCell(Text(deposit.time.toString())),
                  DataCell(Text(deposit.timeUnit.toString())),
                  DataCell(Text(deposit.customerName.toString())),
                  DataCell(Text(deposit.customerContact.toString())),
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
