import 'package:filmku/core/models/trending_movies.dart';
import 'package:filmku/services/API_client.dart';

abstract class TrendingMoviesRepo {
  Future<TrendingMoviesResponse> getTrendingMoviesResponse([int page = 1]);
}

class HttpTrendingMoviesRepo implements TrendingMoviesRepo {
  @override
  Future<TrendingMoviesResponse> getTrendingMoviesResponse(
      [int page = 1]) async {
    TrendingMoviesResponse trendingMoviesResponse;
    final String uri =
        '/trending/movie/day?language=en-US&page=${page.toString()}';
    final Map<String, dynamic> response = await CacheableBaseClient().get(uri);
    trendingMoviesResponse = TrendingMoviesResponse.fromJson(response);
    return trendingMoviesResponse;
  }
}
