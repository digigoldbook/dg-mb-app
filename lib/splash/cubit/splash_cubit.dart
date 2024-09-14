import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashState { spalshInitial, splashLoaded }

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState.spalshInitial);

  Future<void> splashState() async {
    Future.delayed(const Duration(seconds: 3)).then(
      (_) => emit(SplashState.splashLoaded),
    );
  }
}
