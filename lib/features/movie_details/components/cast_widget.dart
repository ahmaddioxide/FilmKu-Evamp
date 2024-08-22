import 'package:cached_network_image/cached_network_image.dart';
import 'package:filmku/core/helpers/custom_cache_manager.dart';
import 'package:filmku/core/models/cast_model.dart';
import 'package:filmku/core/utilities/process_image_link.dart';
import 'package:flutter/material.dart';

class CastWidget extends StatelessWidget {
  final Cast cast;

  const CastWidget({
    super.key,
    required this.cast,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: CachedNetworkImage(
            cacheManager: CustomCacheManager(),
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            ),
            imageUrl: ProcessImage.processImageLink(cast.profilePath),
            height: 120.0,
            width: 120.0,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 120,
          child: Text(
            maxLines: 2,
            textAlign: TextAlign.left,
            cast.name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
