import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../components/animation/fade_animation.dart';
import '../../components/config/app_icons.dart';
import '../../components/widget/txt_widget.dart';
import '../utils/services_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late FadeAnimation fadeAnimation;
  @override
  void initState() {
    fadeAnimation = FadeAnimation(this);
    fadeAnimation.start();
    super.initState();
  }

  @override
  void dispose() {
    fadeAnimation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(8 * 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TxtWidget(
                      strText: "Hi Abishek",
                      style: TxtStyle.rg,
                    ),
                    Gap(16),
                    TxtWidget(
                      strText: "Rs. 1,51,122.03",
                      style: TxtStyle.xl,
                    ),
                    TxtWidget(
                      strText: 'Gold',
                      style: TxtStyle.rg,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    AppIcons.instance.notificationOutlined,
                    size: 40,
                  ),
                ),
              ],
            ),
            const Gap(8 * 2),
            const TxtWidget(
              strText: "Here are somethings you can do",
              style: TxtStyle.sm,
              color: Colors.black45,
            ),
            const Gap(16),
            SizedBox(
              height: 400,
              child: GridView.builder(
                padding: const EdgeInsets.all(0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3.6 / 4,
                ),
                itemCount: servicesUtils.length,
                itemBuilder: (context, index) {
                  final Map<String, dynamic> item = servicesUtils[index];
                  return FadeTransition(
                    opacity: fadeAnimation.animation,
                    child: InkWell(
                      onTap: () => context.pushNamed(item['path']),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: item['color'],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              item['image'],
                              width: 50,
                            ),
                            const Gap(8),
                            TxtWidget(
                              strText: item['title'],
                              style: TxtStyle.md,
                            ),
                            const Gap(16),
                            const Text(
                                "This is the something I would like to refresh"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
