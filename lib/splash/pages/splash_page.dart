import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth/auth_page.dart';
import '../cubit/splash_cubit.dart';
import 'splash_ui.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late SplashCubit splashCubit;

  @override
  void initState() {
    splashCubit = SplashCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SplashCubit(),
        child: BlocBuilder<SplashCubit, SplashState>(
          builder: (context, state) {
            if (state == SplashState.spalshInitial) {
              context.read<SplashCubit>().splashState();
              return const SplashUi();
            }
            if (state == SplashState.splashLoaded) {
              return const AuthScreen();
            }
            return Container();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    splashCubit.close();
    super.dispose();
  }
}
