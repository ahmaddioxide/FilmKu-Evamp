import 'package:filmku/config/theme/theme.dart';
import 'package:filmku/core/helpers/custom_cache_manager.dart';
import 'package:filmku/core/models/movie_model.dart';
import 'package:filmku/core/utilities/process_image_link.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 143,
      height: 290,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                cacheManager: CustomCacheManager(),
                imageUrl: ProcessImage.processPosterLink(movie.posterPath),
                width: 143,
                height: 204,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
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
          const SizedBox(
            height: 4,
          ),
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
        ],
      ),
    );
  }
}
