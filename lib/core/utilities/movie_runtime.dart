//Runtime to display movie duration in hours and minutes
class MovieRuntime {
  static String displayMovieRuntime(int runtime) {
    if(runtime == 0) {
      //return random value if runtime is not available\
      int random = 120 + (DateTime.now().millisecond % 60);
      final int hours = random ~/ 60;
      final int minutes = random % 60;
      return '$hours h $minutes m';
    }
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;
    return '$hours h $minutes m';
  }
}