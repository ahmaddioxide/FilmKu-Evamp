import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmku/components/genre_chip.dart';
import 'package:filmku/config/theme/theme.dart';
import 'package:filmku/constants/assets.dart';
import 'package:filmku/core/helpers/custom_cache_manager.dart';
import 'package:filmku/core/models/movie_model.dart';
import 'package:filmku/core/utilities/custom_snackbar.dart';
import 'package:filmku/core/utilities/movie_runtime.dart';
import 'package:filmku/core/utilities/process_image_link.dart';
import 'package:filmku/core/utilities/size_utils.dart';
import 'package:filmku/features/home/components/see_more_button.dart';
import 'package:filmku/features/movie_details/components/cast_widget.dart';
import 'package:filmku/features/movie_details/controller/movies_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int id;

  const MovieDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MovieDetailsController());

    return Scaffold(
      body: FutureBuilder(
        future: controller.fetchMovieDetails(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkPurple),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error),
                  Text('Error'),
                ],
              ),
            );
          } else {
            final movieDetails = snapshot.data;

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  actions: [
                    IconButton(onPressed: () {}, icon: Image.asset(kUnionIcon))
                  ],
                  expandedHeight: 260,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: MovieTrailer(
                      movieID: id.toString(),
                      movie: movieDetails!,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        height: DeviceUtils.getHeight(context) * 0.8,
                        width: DeviceUtils.getWidth(context),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: SizedBox(
                                      width:
                                          DeviceUtils.getWidth(context) * 0.7,
                                      child: Text(
                                        movieDetails.title,
                                        style: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      customSnackBar(
                                          message: 'Feature not available yet');
                                    },
                                    icon: const Icon(
                                      Icons.bookmark_border_rounded,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: AppColors.orange,
                                    size: 20,
                                  ),
                                  Text(
                                    '${movieDetails.voteAverage.toStringAsFixed(1)}/10 IMDb',
                                    style: const TextStyle(
                                      color: AppColors.lightGrey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 12,
                              ),
                              //GenreCars
                              SizedBox(
                                height: 28,
                                width: DeviceUtils.getWidth(context),
                                child: ListView.builder(
                                  itemCount: movieDetails.genres?.length ?? 0,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GenreChip(
                                      genre:
                                          '${movieDetails.genres?[index].name}',
                                    );
                                  },
                                ),
                              ),

                              const SizedBox(
                                height: 12,
                              ),

                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Length',
                                        style: TextStyle(
                                          color: AppColors.lightGrey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        MovieRuntime.displayMovieRuntime(
                                            movieDetails.runtime),
                                        style: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Language',
                                        style: TextStyle(
                                          color: AppColors.lightGrey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        'English',
                                        style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Rating',
                                        style: TextStyle(
                                          color: AppColors.lightGrey,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        movieDetails.adult ? '18+' : 'PG-13',
                                        style: const TextStyle(
                                          color: AppColors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                'Description',
                                style: GoogleFonts.merriweather(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                movieDetails.overview,
                                style: const TextStyle(
                                  color: AppColors.lightGrey,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Cast',
                                    style: GoogleFonts.merriweather(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SeeMoreButton(onPressed: () {})
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              SizedBox(
                                height: 200,
                                width: DeviceUtils.getWidth(context),
                                child: ListView.builder(
                                  itemCount: controller
                                          .movieCreditsResponse?.cast.length ??
                                      0,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: CastWidget(
                                          cast: controller.movieCreditsResponse!
                                              .cast[index],
                                        ));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}

class MovieTrailer extends StatelessWidget {
  final String movieID;
  final Movie movie;

  const MovieTrailer({super.key, required this.movieID, required this.movie});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MovieDetailsController>();
    final YoutubePlayerController ytController = YoutubePlayerController(
      initialVideoId: controller.trailerYouTubeID.value,
    );

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: GestureDetector(
        onTap: () async {
          if (controller.trailerYouTubeID.value == '') {
            customSnackBar(message: 'No trailer available');
          } else {
            showMovieTrailerDialog(context, ytController);
          }
        },
        child: Center(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: CachedNetworkImage(
                  imageUrl: ProcessImage.processPosterLink(
                    movie.backdropPath ?? movie.posterPath,
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.darkPurple),
                    ),
                  ),
                  height: 300,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  key: UniqueKey(),
                  cacheManager: CustomCacheManager(),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.play_circle_fill_outlined,
                      color: Colors.white,
                      size: 60,
                    ),
                    Text(
                      'Play Trailer',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showMovieTrailerDialog(
      BuildContext context, YoutubePlayerController ytController) {
    ytController = YoutubePlayerController(
      initialVideoId: ytController.initialVideoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.all(10),
          backgroundColor: Colors.transparent,
          content: YoutubePlayer(
            controller: ytController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: AppColors.darkPurple,
            progressColors: const ProgressBarColors(
              playedColor: AppColors.darkPurple,
              handleColor: AppColors.darkPurple,
              bufferedColor: AppColors.lightGrey,
              backgroundColor: AppColors.lightGrey,
            ),
            onReady: () => debugPrint('Ready'),
            bottomActions: const [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: ProgressBarColors(
                  playedColor: AppColors.darkPurple,
                  handleColor: AppColors.darkPurple,
                  bufferedColor: AppColors.lightGrey,
                  backgroundColor: AppColors.lightGrey,
                ),
              ),
              PlaybackSpeedButton(),
            ],
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.darkPurple,
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
