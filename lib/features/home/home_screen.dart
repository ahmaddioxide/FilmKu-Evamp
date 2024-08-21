import 'package:filmku/config/theme/theme.dart';
import 'package:filmku/constants/assets.dart';
import 'package:filmku/constants/strings.dart';
import 'package:filmku/core/utilities/custom_snackbar.dart';
import 'package:filmku/components/movie_card.dart';
import 'package:filmku/components/movie_tile.dart';
import 'package:filmku/features/home/components/see_more_button.dart';
import 'package:filmku/features/home/controller/popular_movies_controller.dart';
import 'package:filmku/features/home/controller/upcoming_movies_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final upcomingController = Get.find<UpcomingMoviesController>();
    final popularController = Get.find<PopularMoviesController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          appName,
          style: GoogleFonts.merriweather(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            customSnackBar(message: 'Feature not available yet');
          },
          child: Image.asset(
            kMenuIcon,
            height: 30,
            width: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: () {
                customSnackBar(message: 'Feature not available yet');
              },
              child: Image.asset(
                kNotificationIcon,
                height: 30,
                width: 30,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Text(
                    'Now Showing',
                    style: GoogleFonts.merriweather(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  SeeMoreButton(
                    onPressed: () {
                      customSnackBar(message: 'Feature not available yet');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 300,
              child: FutureBuilder(
                future: upcomingController.upcomingMoviesList.value,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    Get.log(
                        'Error in FutureBuilder of Now Showing movies: ${snapshot.error}');
                    return const Center(
                      child: Text(
                        'Something went wrong',
                        style: TextStyle(
                          color: AppColors.darkPurple,
                        ),
                      ),
                    );
                  } else {
                    final movies = snapshot.data!.results;
                    return ListView.builder(
                        itemCount: movies.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MovieCard(
                              movie: movies[index],
                            ),
                          );
                        });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Text(
                    'Popular',
                    style: GoogleFonts.merriweather(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                  SeeMoreButton(
                    onPressed: () {
                      customSnackBar(message: 'Feature not available yet');
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            FutureBuilder(
              future: popularController.trendingMoviesList.value,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  Get.log(
                      'Error in FutureBuilder of Popular movies: ${snapshot.error}');
                  return const Center(
                    child: Text(
                      'Something went wrong',
                      style: TextStyle(
                        color: AppColors.darkPurple,
                      ),
                    ),
                  );
                } else {
                  final movies = snapshot.data!.results;
                  return ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MovieTile(
                            movie: movies[index],
                          ),
                        );
                      });
                }
              },
            ),

            // MovieTile()
          ],
        ),
      ),
    );
  }
}
