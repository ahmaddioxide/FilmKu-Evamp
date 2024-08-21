import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmku/config/theme/theme.dart';
import 'package:filmku/core/helpers/custom_cache_manager.dart';
import 'package:filmku/core/models/movie_model.dart';
import 'package:filmku/core/utilities/custom_snackbar.dart';
import 'package:filmku/core/utilities/process_image_link.dart';
import 'package:filmku/core/utilities/size_utils.dart';
import 'package:filmku/features/movie_details/controller/movies_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              child: CircularProgressIndicator(),
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
                  expandedHeight: 200,
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
                        height: DeviceUtils.getHeight(context),
                        width: DeviceUtils.getWidth(context),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                        ),

                        child: Column(
                          children: [

                          ],
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

class MovieTrailer extends StatefulWidget {
  final String movieID;
  final Movie movie;

  const MovieTrailer({super.key, required this.movieID, required this.movie});

  @override
  State<MovieTrailer> createState() => _MovieTrailerState();
}

class _MovieTrailerState extends State<MovieTrailer> {
  late YoutubePlayerController _controller;
  final controller = Get.find<MovieDetailsController>();

  @override
  initState() {
    _controller = YoutubePlayerController(
      initialVideoId: controller.trailerYouTubeID.value,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height * 0.5,
      child: GestureDetector(
        onTap: () async {
          if (controller.trailerYouTubeID.value == '') {
            customSnackBar(message: 'No trailer available');
          } else {
            showMovieTrailerDialog(context);
          }
        },
        child: Center(
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: CachedNetworkImage(
                  imageUrl: ProcessImage.processPosterLink(
                    widget.movie.backdropPath ?? widget.movie.posterPath,
                  ),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
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

  void showMovieTrailerDialog(BuildContext context) {
    _controller = YoutubePlayerController(
      initialVideoId: controller.trailerYouTubeID.value,
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
            controller: _controller,
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
              // FullScreenButton(),
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

  @override
  void dispose() {
    super.dispose();
    controller.onClose();
    _controller.dispose();
  }
}
