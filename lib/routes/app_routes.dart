import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/google_sign_in/google_sign_in.dart';
import '../presentation/home_dashboard/home_dashboard.dart';
import '../presentation/wallpaper_preview/wallpaper_preview.dart';
import '../presentation/album_selection/album_selection.dart';
import '../presentation/settings/settings.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String splashScreen = '/splash-screen';
  static const String googleSignIn = '/google-sign-in';
  static const String homeDashboard = '/home-dashboard';
  static const String wallpaperPreview = '/wallpaper-preview';
  static const String albumSelection = '/album-selection';
  static const String settings = '/settings';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    splashScreen: (context) => const SplashScreen(),
    googleSignIn: (context) => const GoogleSignIn(),
    homeDashboard: (context) => const HomeDashboard(),
    wallpaperPreview: (context) => const WallpaperPreview(),
    albumSelection: (context) => const AlbumSelection(),
    settings: (context) => const Settings(),
    // TODO: Add your other routes here
  };
}
