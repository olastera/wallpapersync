import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _loadingAnimationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _loadingAnimation;

  bool _isInitializing = true;
  bool _hasError = false;
  String _errorMessage = '';
  bool _showRetryButton = false;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _initializeApp();
  }

  void _setupAnimations() {
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _loadingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    _logoScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.elasticOut,
    ));

    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
    ));

    _loadingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _loadingAnimationController,
      curve: Curves.easeInOut,
    ));

    _logoAnimationController.forward();
  }

  Future<void> _initializeApp() async {
    try {
      setState(() {
        _isInitializing = true;
        _hasError = false;
        _showRetryButton = false;
      });

      // Simulate initialization delay
      await Future.delayed(const Duration(milliseconds: 500));

      // Check Google authentication status
      final bool isAuthenticated = await _checkAuthenticationStatus();

      // Load user preferences
      await _loadUserPreferences();

      // Fetch cached album data
      await _fetchCachedAlbumData();

      // Prepare wallpaper service
      await _prepareWallpaperService();

      // Wait for minimum splash duration
      await Future.delayed(const Duration(milliseconds: 2000));

      if (mounted) {
        _navigateToNextScreen(isAuthenticated);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _errorMessage = 'Error de inicialización: ${e.toString()}';
          _isInitializing = false;
        });

        // Show retry button after 5 seconds
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) {
            setState(() {
              _showRetryButton = true;
            });
          }
        });
      }
    }
  }

  Future<bool> _checkAuthenticationStatus() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isAuthenticated = prefs.getBool('is_authenticated') ?? false;
      final hasValidToken = prefs.getString('auth_token') != null;
      return isAuthenticated && hasValidToken;
    } catch (e) {
      return false;
    }
  }

  Future<void> _loadUserPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Load theme preference
      final isDarkMode = prefs.getBool('dark_mode') ?? false;
      // Load wallpaper settings
      final autoChangeEnabled = prefs.getBool('auto_change_enabled') ?? true;
      final changeInterval = prefs.getInt('change_interval') ?? 24; // hours
      final wifiOnlyMode = prefs.getBool('wifi_only_mode') ?? true;

      // Apply theme if needed
      if (isDarkMode) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
      } else {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
      }
    } catch (e) {
      // Handle preference loading error
      debugPrint('Error loading preferences: $e');
    }
  }

  Future<void> _fetchCachedAlbumData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedAlbums = prefs.getStringList('cached_albums') ?? [];
      final lastSyncTime = prefs.getInt('last_sync_time') ?? 0;

      // Check if cache is still valid (24 hours)
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final cacheAge = currentTime - lastSyncTime;
      final isCacheValid =
          cacheAge < (24 * 60 * 60 * 1000); // 24 hours in milliseconds

      if (!isCacheValid && cachedAlbums.isNotEmpty) {
        // Cache is stale, mark for refresh
        await prefs.setBool('needs_album_refresh', true);
      }
    } catch (e) {
      debugPrint('Error fetching cached album data: $e');
    }
  }

  Future<void> _prepareWallpaperService() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Initialize wallpaper service settings
      await prefs.setBool('wallpaper_service_ready', true);

      // Check if background service should be enabled
      final autoChangeEnabled = prefs.getBool('auto_change_enabled') ?? true;
      if (autoChangeEnabled) {
        // Prepare background service (would integrate with workmanager)
        await prefs.setBool('background_service_enabled', true);
      }
    } catch (e) {
      debugPrint('Error preparing wallpaper service: $e');
    }
  }

  void _navigateToNextScreen(bool isAuthenticated) {
    if (!isAuthenticated) {
      Navigator.pushReplacementNamed(context, '/google-sign-in');
      return;
    }

    // Check if user has selected albums
    SharedPreferences.getInstance().then((prefs) {
      final hasSelectedAlbums =
          prefs.getStringList('selected_albums')?.isNotEmpty ?? false;

      if (hasSelectedAlbums) {
        Navigator.pushReplacementNamed(context, '/home-dashboard');
      } else {
        Navigator.pushReplacementNamed(context, '/album-selection');
      }
    });
  }

  void _retryInitialization() {
    setState(() {
      _showRetryButton = false;
    });
    _initializeApp();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _loadingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.lightTheme.colorScheme.primary,
              AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.8),
              AppTheme.lightTheme.colorScheme.secondary,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _logoAnimationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoScaleAnimation.value,
                        child: Opacity(
                          opacity: _logoFadeAnimation.value,
                          child: _buildLogo(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isInitializing && !_hasError) ...[
                      _buildLoadingIndicator(),
                      SizedBox(height: 2.h),
                      Text(
                        'Inicializando WallpaperSync...',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    if (_hasError) ...[
                      CustomIconWidget(
                        iconName: 'error_outline',
                        color: Colors.white,
                        size: 6.w,
                      ),
                      SizedBox(height: 2.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: Text(
                          _errorMessage,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      if (_showRetryButton) ...[
                        SizedBox(height: 3.h),
                        ElevatedButton(
                          onPressed: _retryInitialization,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor:
                                AppTheme.lightTheme.colorScheme.primary,
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 1.5.h,
                            ),
                          ),
                          child: Text(
                            'Reintentar',
                            style: AppTheme.lightTheme.textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Text(
                  'WallpaperSync v1.0',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 25.w,
      height: 25.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'wallpaper',
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 8.w,
          ),
          SizedBox(height: 1.h),
          Text(
            'WS',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return AnimatedBuilder(
      animation: _loadingAnimation,
      builder: (context, child) {
        return Container(
          width: 8.w,
          height: 8.w,
          child: CircularProgressIndicator(
            value: null,
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white.withValues(alpha: 0.9),
            ),
          ),
        );
      },
    );
  }
}
