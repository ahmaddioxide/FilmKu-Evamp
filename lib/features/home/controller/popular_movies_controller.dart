import 'package:filmku/core/models/trending_movies.dart';
import 'package:filmku/core/repositories/popular_movies_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularMoviesController extends GetxController {
  final HttpTrendingMoviesRepo httpTrendingMoviesRepo;

  PopularMoviesController(this.httpTrendingMoviesRepo);

  var isLoading = true.obs;
  var trendingMoviesList = Rxn<Future<TrendingMoviesResponse>>();

  @override
  void onInit() {
    super.onInit();

    fetchTrendingMovies(1);
  }

  Future<void> fetchTrendingMovies(int start) async {
    try {
      isLoading(true);
      trendingMoviesList.value =
          httpTrendingMoviesRepo.getTrendingMoviesResponse(start);
    } catch (e) {
      debugPrint('Error fetching movies: $e');
    } finally {
      isLoading(false);
    }
  }
}
