import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../components/config/app_icons.dart';
import '../cubit/bottom_nav_cubit.dart';
import '../utils/bottom_nav_items.dart';
import '../widgets/bottom_nav_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late BottomNavCubit bottomNavCubit;

  @override
  void initState() {
    bottomNavCubit = BottomNavCubit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bottomNavCubit,
      child: BlocBuilder<BottomNavCubit, BottomNavState>(
        builder: (context, state) {
          final int index = (state as BottomNavInitial).index;
          return Scaffold(
            body: bottomNavItems[index]['screen'],
            bottomNavigationBar: const BottomNavWidget(),
            floatingActionButton: FloatingActionButton(
              onPressed: () => context.pushNamed("shop"),
              child: Icon(AppIcons.instance.store),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    bottomNavCubit.close();
    super.dispose();
  }
}
