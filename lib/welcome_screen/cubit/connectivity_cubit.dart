// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class ConnectivityCubit extends Cubit<String> {
//   final Connectivity _connectivity = Connectivity();

//   ConnectivityCubit() : super("Unknown") {
//     checkConnection();
//     _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
//       _mapResultToState(result);
//     } as void Function(List<ConnectivityResult> event)?);
//   }

//   Future<void> checkConnection() async {
//     ConnectivityResult result =
//         (await _connectivity.checkConnectivity()) as ConnectivityResult;
//     _mapResultToState(result);
//   }

//   void _mapResultToState(ConnectivityResult result) {
//     if (result == ConnectivityResult.mobile) {
//       emit("Connected to Mobile Network");
//     } else if (result == ConnectivityResult.wifi) {
//       emit("Connected to Wi-Fi");
//     } else {
//       emit("No Internet Connection");
//     }
//   }
// }
