import 'package:go_router/go_router.dart';

import '../../auth/auth_page.dart';
import '../../auth/reset_password/pages/reset_password_page.dart';
import '../../auth/sign_in/pages/sign_in_page.dart';
import '../../auth/sign_up/pages/sign_up_page.dart';
import '../../feedback/pages/feedback_page.dart';
import '../../main_screen/pages/main_page.dart';
import '../../services/estimation/pages/time_estimation_cal.dart';
import '../../services/pages/percentage_convert.dart';
import '../../services/pages/unit_converter.dart';
import '../../shop_screen/features/cash_deposit/pages/cash_deposit.dart';
import '../../shop_screen/features/gold_deposit/pages/gold_deposit.dart';
import '../../shop_screen/features/gold_deposit/widgets/gold_fab.dart';
import '../../shop_screen/pages/shop_details_page.dart';
import '../../shop_screen/pages/shop_page.dart';
import '../../splash/pages/splash_page.dart';
import '../../statement/pages/view_statement.dart';

final GoRouter appRoutes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: "initial",
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/auth-screen',
      name: "auth-screen",
      builder: (context, state) => const AuthScreen(),
    ),
    GoRoute(
      path: '/main',
      name: "main",
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: '/sign-in',
      name: "sign-in",
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/sign-up',
      name: "sign-up",
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/reset-password',
      name: "reset-password",
      builder: (context, state) => const ResetPasswordPage(),
    ),
    GoRoute(
      path: '/percentage-converter',
      name: "percentage-converter",
      builder: (context, state) => const PercentageConvert(),
    ),
    GoRoute(
      path: '/unit-converter',
      name: "unit-converter",
      builder: (context, state) => const UnitConverter(),
    ),
    GoRoute(
      path: '/time-estimation-cal',
      name: "time-estimation-cal",
      builder: (context, state) => const TimeEstimationCal(),
    ),
    GoRoute(
      path: '/shop',
      name: "shop",
      builder: (context, state) => const ShopPage(),
    ),
    GoRoute(
      path: '/shop-details',
      name: "shop-details",
      builder: (context, state) => const ShopDetailsPage(),
    ),
    GoRoute(
      path: '/gold-deposit',
      name: "gold-deposit",
      builder: (context, state) => const GoldDeposit(),
    ),
    GoRoute(
      path: '/cash-deposit',
      name: "cash-deposit",
      builder: (context, state) => const CashDeposit(),
    ),
    GoRoute(
      path: '/add-gold-deposit-record',
      name: "add-gold-deposit-record",
      builder: (context, state) => const GoldFAB(),
    ),
    GoRoute(
      path: '/view-statement',
      name: "view-statement",
      builder: (context, state) => const ViewStatement(),
    ),
    GoRoute(
      path: '/feedback',
      name: "feedback",
      builder: (context, state) => const FeedbackPage(),
    ),
  ],
);
