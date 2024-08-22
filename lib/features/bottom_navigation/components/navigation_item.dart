import 'package:filmku/features/bottom_navigation/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationItem extends StatelessWidget {
  final int index;
  final String icon;

  const NavigationItem({
    super.key,
    required this.index,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final NavigationController navigationController = Get.find<NavigationController>();

    return GestureDetector(
      onTap: () {
        navigationController.selectedIndex.value = index;
      },
      child:
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              height: 40.0,
            ),
            const SizedBox(height: 4.0),
          ],
        ),
    );
  }
}