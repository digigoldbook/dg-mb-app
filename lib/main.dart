import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'auth/reset_password/bloc/reset_password_bloc.dart';
import 'auth/sign_in/bloc/sign_in_bloc.dart';
import 'auth/sign_up/bloc/sign_up_bloc.dart';
import 'components/config/app_localization.dart';
import 'components/config/app_routes.dart';
import 'components/config/l10n.dart';
import 'main_screen/cubit/bottom_nav_cubit.dart';
import 'services/estimation/cubit/estimation_step_cubit.dart';
import 'services/pages/percentage_conversion/cubit/percentage_conversion_cubit.dart';
import 'shop_screen/domain/fetch_bloc/shop_bloc.dart';
import 'splash/cubit/splash_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SplashCubit(),
        ),
        BlocProvider(
          create: (_) => BottomNavCubit(),
        ),
        BlocProvider(
          create: (_) => PercentageConversionCubit(),
        ),
        BlocProvider(
          create: (_) => SignInBloc(),
        ),
        BlocProvider(
          create: (_) => SignUpBloc(),
        ),
        BlocProvider(
          create: (_) => ResetPasswordBloc(),
        ),
        BlocProvider(
          create: (_) => ShopBloc(),
        ),
        BlocProvider(
          create: (_) => EstimationStepCubit(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRoutes,
      theme: ThemeData(
        useMaterial3: true,
      ),
      supportedLocales: L10n.all,
      locale: const Locale('ne', 'NP'),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
