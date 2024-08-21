import 'package:filmku/config/theme/theme.dart';
import 'package:flutter/material.dart';

class BookmarkingScreen extends StatelessWidget {
  const BookmarkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark),
            Text('Bookmarking Screen'),
            SizedBox(
              width: double.infinity,
              height: 50,
            ),
            //under development
            Text('Under Development',
                style: TextStyle(
                  color: AppColors.darkPurple,
                  fontSize: 20,
                )),
          ],
        ),
      ),
    );
  }
}
