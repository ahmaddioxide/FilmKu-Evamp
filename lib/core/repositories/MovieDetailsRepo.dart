import 'package:filmku/core/models/movie_credits_response_model.dart';
import 'package:filmku/core/models/movie_model.dart';
import 'package:filmku/services/API_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class MovieDetailsRepo {
  Future<Movie> getMovieDetails(int id);

  Future<String> getMovieTrailer(int id);

  Future<MovieCreditsResponse> getMovieCredits(int movieId);
}

class HttpMovieDetails implements MovieDetailsRepo {
  @override
  Future<Movie> getMovieDetails(int id) async {
    Movie movie;
    final String uri = '/movie/${id.toString()}?language=en-US';
    final Map<String, dynamic> response = await CacheableBaseClient().get(uri);
    debugPrint(response.toString());
    movie = Movie.fromJson(response);
    return movie;
  }

  @override
  Future<String> getMovieTrailer(int id) async {
    final String uri = '/movie/${id.toString()}/videos?language=en-US';
    final Map<String, dynamic> response = await CacheableBaseClient().get(uri);
    Get.log('!!!! fetch' + response.toString());

    // Extract the trailer link from the response
    final List<dynamic> results = response['results'];
    for (var result in results) {
      if (result['type'] == 'Trailer' && result['site'] == 'YouTube') {
        String link = result['key'];
        return link;
      }
    }
    return '';
  }

  @override
  Future<MovieCreditsResponse> getMovieCredits(int movieId) async {
    MovieCreditsResponse movieCreditsResponse;
    final String uri = '/movie/${movieId.toString()}/credits?language=en-US';
    final Map<String, dynamic> response = await CacheableBaseClient().get(uri);
    movieCreditsResponse = MovieCreditsResponse.fromJson(response);
    return movieCreditsResponse;
  }
}
