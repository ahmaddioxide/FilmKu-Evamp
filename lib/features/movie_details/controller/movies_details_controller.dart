import 'package:filmku/core/models/movie_credits_response_model.dart';
import 'package:filmku/core/models/movie_model.dart';
import 'package:filmku/core/repositories/movie_details_repo.dart';
import 'package:get/get.dart';



class MovieDetailsController extends GetxController {
  RxInt categoryIndex = 0.obs;
  RxString category = "About Movie".obs;
  List movieTrailer = [];
  RxString trailerYouTubeID = ''.obs;
  MovieCreditsResponse? movieCreditsResponse;

  void changeCategory(int index) {
    categoryIndex.value = index;
  }

  void reset() {
    categoryIndex.value = 0;
  }

  final MovieDetailsRepo _movieDetailsRepo = HttpMovieDetails();

  Future<Movie> fetchMovieDetails(int id) async {
    try {
      String trailer = await _movieDetailsRepo.getMovieTrailer(id);
      trailerYouTubeID.value = trailer;
      movieCreditsResponse= await _movieDetailsRepo.getMovieCredits(id);
      return await _movieDetailsRepo.getMovieDetails(id);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void onClose() {
    super.onClose();
    trailerYouTubeID.value = '';
    movieTrailer.clear();
  }
}
