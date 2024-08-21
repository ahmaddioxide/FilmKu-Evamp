import 'package:flutter_dotenv/flutter_dotenv.dart';

class Keys {
  static String apiKey = dotenv.env['TMDB_KEY']!;
}
