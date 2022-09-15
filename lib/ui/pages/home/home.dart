import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:mgtv/ui/route/app_route.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsScaffold(
      routes: const <PageRouteInfo<dynamic>>[Feed(), Magazine()],
      bottomNavigationBuilder: (BuildContext context, TabsRouter tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          showSelectedLabels: false,
          enableFeedback: true,
          showUnselectedLabels: false,
          selectedItemColor: ColorName.primaryColor,
          onTap: tabsRouter.setActiveIndex,
          iconSize: 20,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.feed_outlined),
              label: '',
            ),
          ],
        );
      },
    );
  }
}
