import 'package:filmku/core/repositories/popular_movies_repo.dart';
import 'package:filmku/features/home/controller/popular_movies_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:filmku/config/theme/theme.dart';
import 'package:filmku/constants/strings.dart';
import 'package:filmku/core/repositories/upcoming_movies_repo.dart';
import 'package:filmku/features/bottom_navigation/navigation_screen.dart';
import 'features/bottom_navigation/controller/navigation_controller.dart';
import 'features/home/controller/upcoming_movies_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    debugPrint('Error loading .env file: $e');
  }

  // Initialize Hive storage
  await Hive.initFlutter();
  await Hive.openBox('apiResponses');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      theme: customThemeData,
      initialBinding: BindingsBuilder(() {
        Get.put<NavigationController>(NavigationController());
        Get.lazyPut(() => UpcomingMoviesController(HttpUpcomingMoviesRepo()),
            fenix: true);
        Get.lazyPut(() => PopularMoviesController(HttpTrendingMoviesRepo()),
            fenix: true);
      }),
      home: const NavigationScreen(),
    );
  }
}
