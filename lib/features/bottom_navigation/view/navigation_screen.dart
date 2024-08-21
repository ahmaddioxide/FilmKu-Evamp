import 'package:filmku/core/utilities/size_utils.dart';
import 'package:filmku/features/booking/view/booking_screen.dart';
import 'package:filmku/features/bookmarking/view/bookmarking_screen.dart';
import 'package:filmku/features/bottom_navigation/components/bottom_bar.dart';
import 'package:filmku/features/home/view/home_screen.dart';
import 'package:filmku/features/bottom_navigation/controller/navigation_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({super.key});





  @override
  Widget build(BuildContext context) {
    final List<Widget> pageList = [
      const HomeScreen(),
      const BookingScreen(),
      const BookmarkingScreen(),

    ];
    final NavigationController navigationController =
    Get.find<NavigationController>();
    return Scaffold(
      body: Obx(
        (){
          return
          SizedBox(
          height: DeviceUtils.getHeight(context),
          child: pageList[navigationController.selectedIndex.value],
          );
        }
      ),
      bottomNavigationBar: const NavigationBottomBar(),
      extendBody: true,
    );
  }
}
