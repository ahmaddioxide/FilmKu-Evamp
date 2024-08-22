import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmku/components/genre_chip.dart';
import 'package:filmku/config/theme/theme.dart';
import 'package:filmku/core/models/movie_model.dart';
import 'package:filmku/core/utilities/movie_runtime.dart';
import 'package:filmku/core/utilities/process_genre_list.dart';
import 'package:filmku/core/utilities/process_image_link.dart';
import 'package:filmku/core/utilities/size_utils.dart';
import 'package:flutter/material.dart';

import '../core/models/genre_model.dart';
import '../core/utilities/process_genre_code.dart';

class MovieTile extends StatelessWidget {
  final Movie movie;

  const MovieTile({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getWidth(context),
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: ProcessImage.processPosterLink(movie.posterPath),
                width: 120,
                height: 180,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: DeviceUtils.getWidth(context) - 200,
                child:  Text(
                  textAlign: TextAlign.left,
                  maxLines: 2,
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 10),
               Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: AppColors.orange,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    '${movie.voteAverage.toStringAsFixed(1)}/10 IMDb',
                    style: const TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 26,
                width: DeviceUtils.getWidth(context) - 180,
                child: ListView.builder(
                  itemCount: movie.genreIds?.length ?? 0,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    List<String> genres = ProcessGenreCode.processGenreCodes(movie.genreIds);
                    return  GenreChip(
                      genre: genres[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
               Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: AppColors.black,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    MovieRuntime.displayMovieRuntime(movie.runtime),
                    style: const TextStyle(
                      color: AppColors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
