import 'package:filmku/config/theme/theme.dart';
import 'package:filmku/constants/assets.dart';
import 'package:filmku/core/utilities/size_utils.dart';
import 'package:flutter/material.dart';
import 'navigation_item.dart';

class NavigationBottomBar extends StatelessWidget {
  const NavigationBottomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: DeviceUtils.getDynamicHeight(context, 0.09),
      padding: const EdgeInsets.only(bottom: 10.0, left: 40, right: 40),
      decoration: const BoxDecoration(
        color: AppColors.white,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavigationItem(index: 0, icon: kHomeIcon),
          NavigationItem(index: 1, icon: kTicketIcon),
          NavigationItem(index: 2, icon: kBookmarkIcon),
        ],
      ),
    );
  }
}
