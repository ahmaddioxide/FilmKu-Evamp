import 'dart:core';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'keys.dart';

class TMDbApi{
  // static String baseUrl = dotenv.env['BASEURL']!;
  static String baseUrl = 'https://api.themoviedb.org/3';
  // static String apiKey = Keys.apiKey;
  static String apiKey = '27f1955b614aba1bb6610eb4fd435202';
}