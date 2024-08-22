

import 'package:filmku/core/models/upcoming_movies.dart';
import 'package:filmku/services/api_client.dart';

abstract class UpcomingMoviesRepo {
  Future<UpcomingMoviesResponse> getUpcomingMoviesResponse([int page = 1]);
}

class HttpUpcomingMoviesRepo implements UpcomingMoviesRepo {
  @override
  Future<UpcomingMoviesResponse> getUpcomingMoviesResponse(
      [int page = 1]) async {
    UpcomingMoviesResponse upcomingMoviesResponse;
    final String uri =
        '/movie/upcoming?language=en-US&page=${page.toString()}';
    final Map<String, dynamic> response = await CacheableBaseClient().get(uri);
    // debugPrint(response.toString());
    upcomingMoviesResponse = UpcomingMoviesResponse.fromJson(response);
    return upcomingMoviesResponse;
  }
}
