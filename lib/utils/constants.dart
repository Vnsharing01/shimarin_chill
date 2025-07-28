import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

final prefs = getIt<SharedPreferences>();

const String darkMode = 'isDark';
const String adUnitTestId = 'ca-app-pub-3940256099942544/6300978111';
const String adUnitId = 'ca-app-pub-8875895136331561/1732031797';
const String baseUrl =
    'https://raw.githubusercontent.com/Vnsharing01/shimarin_chill/main/lib/';
