import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnvUtils {
  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  static Future<void> initDotEnv() async {
    await dotenv.load(fileName: 'myAPIKey.env');
  }
}
