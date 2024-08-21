import 'package:filmku/config/theme/theme.dart';
import 'package:flutter/material.dart';

class SeeMoreButton extends StatelessWidget {
  const SeeMoreButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        alignment: Alignment.centerRight,
        //grey border and rounded corner
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightGrey),
          borderRadius: BorderRadius.circular(13),
        ),
        child: const Text(
          'See More',
          style: TextStyle(color: AppColors.lightGrey, fontSize: 12),
        ),
      ),
    );
  }
}
