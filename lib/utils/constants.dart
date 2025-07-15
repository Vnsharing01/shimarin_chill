import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

final prefs = getIt<SharedPreferences>();

const String darkMode = 'isDark';
const String baseUrl =
    'https://raw.githubusercontent.com/Vnsharing01/shimarin_chill/main/';
