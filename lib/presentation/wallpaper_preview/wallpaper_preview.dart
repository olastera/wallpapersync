import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/image_metadata_widget.dart';
import './widgets/wallpaper_control_panel_widget.dart';
import './widgets/wallpaper_options_bottom_sheet_widget.dart';

class WallpaperPreview extends StatefulWidget {
  const WallpaperPreview({Key? key}) : super(key: key);

  @override
  State<WallpaperPreview> createState() => _WallpaperPreviewState();
}

class _WallpaperPreviewState extends State<WallpaperPreview>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _controlsAnimationController;
  late AnimationController _metadataAnimationController;
  late Animation<double> _controlsAnimation;
  late Animation<Offset> _metadataAnimation;

  int _currentIndex = 0;
  bool _showControls = true;
  bool _showMetadata = false;
  bool _isLoading = true;
  String? _errorMessage;

  // Mock album data
  final List<Map<String, dynamic>> _albumImages = [
    {
      "id": "1",
      "url":
          "https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "filename": "mountain_sunset.jpg",
      "dateTaken": "2025-07-10 18:30:00",
      "resolution": "1920x1080",
      "size": "2.4 MB",
      "isFavorite": false,
      "isLocal": false,
    },
    {
      "id": "2",
      "url":
          "https://images.pixabay.com/photo-2016/11/29/05/45/astronomy-1867616_1280.jpg",
      "filename": "starry_night.jpg",
      "dateTaken": "2025-07-12 22:15:00",
      "resolution": "1280x853",
      "size": "1.8 MB",
      "isFavorite": true,
      "isLocal": false,
    },
    {
      "id": "3",
      "url":
          "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80",
      "filename": "ocean_waves.jpg",
      "dateTaken": "2025-07-14 14:20:00",
      "resolution": "1000x667",
      "size": "1.2 MB",
      "isFavorite": false,
      "isLocal": true,
    },
    {
      "id": "4",
      "url":
          "https://images.pexels.com/photos/1323550/pexels-photo-1323550.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "filename": "forest_path.jpg",
      "dateTaken": "2025-07-13 09:45:00",
      "resolution": "1260x750",
      "size": "3.1 MB",
      "isFavorite": true,
      "isLocal": false,
    },
    {
      "id": "5",
      "url":
          "https://images.pixabay.com/photo-2017/02/08/17/24/fantasy-2049567_1280.jpg",
      "filename": "fantasy_landscape.jpg",
      "dateTaken": "2025-07-11 16:10:00",
      "resolution": "1280x720",
      "size": "2.7 MB",
      "isFavorite": false,
      "isLocal": false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    _controlsAnimationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    _metadataAnimationController = AnimationController(
        duration: const Duration(milliseconds: 400), vsync: this);

    _controlsAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controlsAnimationController, curve: Curves.easeInOut));

    _metadataAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
            CurvedAnimation(
                parent: _metadataAnimationController,
                curve: Curves.easeOutCubic));

    _controlsAnimationController.forward();
    _simulateImageLoading();
  }

  void _simulateImageLoading() {
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _controlsAnimationController.dispose();
    _metadataAnimationController.dispose();
    super.dispose();
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });

    _showControls
        ? _controlsAnimationController.forward()
        : _controlsAnimationController.reverse();
  }

  void _toggleMetadata() {
    setState(() {
      _showMetadata = !_showMetadata;
    });

    _showMetadata
        ? _metadataAnimationController.forward()
        : _metadataAnimationController.reverse();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
    HapticFeedback.selectionClick();
  }

  void _toggleFavorite() {
    setState(() {
      _albumImages[_currentIndex]["isFavorite"] =
          !(_albumImages[_currentIndex]["isFavorite"] as bool);
    });
    HapticFeedback.lightImpact();
  }

  void _shareImage() {
    HapticFeedback.selectionClick();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Compartiendo imagen...'),
        duration: const Duration(seconds: 2)));
  }

  void _deleteImage() {
    final isLocal = _albumImages[_currentIndex]["isLocal"] as bool;
    if (!isLocal) return;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
                title: Text('Eliminar imagen'),
                content:
                    Text('¿Estás seguro de que quieres eliminar esta imagen?'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancelar')),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _albumImages.removeAt(_currentIndex);
                          if (_currentIndex >= _albumImages.length &&
                              _albumImages.isNotEmpty) {
                            _currentIndex = _albumImages.length - 1;
                            _pageController.animateToPage(_currentIndex,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          }
                        });
                        Navigator.pop(context);
                        HapticFeedback.mediumImpact();
                      },
                      child: Text('Eliminar')),
                ]));
  }

  void _showWallpaperOptions() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) =>
            WallpaperOptionsBottomSheetWidget(onOptionSelected: _setWallpaper));
  }

  void _setWallpaper(String option) {
    HapticFeedback.mediumImpact();
    Navigator.pop(context);

    String message;
    switch (option) {
      case 'home':
        message = 'Fondo de pantalla de inicio establecido';
        break;
      case 'lock':
        message = 'Fondo de pantalla de bloqueo establecido';
        break;
      case 'both':
        message = 'Fondo de pantalla establecido para ambos';
        break;
      default:
        message = 'Fondo de pantalla establecido';
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(label: 'Deshacer', onPressed: () {})));
  }

  void _navigateToImage(int direction) {
    final newIndex = _currentIndex + direction;
    if (newIndex >= 0 && newIndex < _albumImages.length) {
      _pageController.animateToPage(newIndex,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_albumImages.isEmpty) {
      return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                  icon: CustomIconWidget(
                      iconName: 'arrow_back', color: Colors.white, size: 24),
                  onPressed: () => Navigator.pop(context))),
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                CustomIconWidget(
                    iconName: 'image_not_supported',
                    color: Colors.white54,
                    size: 64),
                SizedBox(height: 16),
                Text('No hay imágenes disponibles',
                    style: AppTheme.lightTheme.textTheme.titleMedium
                        ?.copyWith(color: Colors.white)),
              ])));
    }

    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        body: Stack(children: [
          // Main image gallery
          GestureDetector(
              onTap: _toggleControls,
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity != null &&
                    details.primaryVelocity! < -500) {
                  _toggleMetadata();
                }
              },
              child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (context, index) {
                    final image = _albumImages[index];
                    return PhotoViewGalleryPageOptions(
                        imageProvider: NetworkImage(image["url"] as String),
                        initialScale: PhotoViewComputedScale.contained,
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2.0,
                        heroAttributes:
                            PhotoViewHeroAttributes(tag: image["id"] as String),
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                              color: Colors.grey[900],
                              child: Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                    CustomIconWidget(
                                        iconName: 'broken_image',
                                        color: Colors.white54,
                                        size: 48),
                                    SizedBox(height: 16),
                                    Text('Error al cargar imagen',
                                        style: AppTheme
                                            .lightTheme.textTheme.bodyMedium
                                            ?.copyWith(color: Colors.white54)),
                                  ])));
                        });
                  },
                  itemCount: _albumImages.length,
                  loadingBuilder: (context, event) => Center(
                      child: CircularProgressIndicator(
                          value: event?.expectedTotalBytes != null
                              ? (event?.cumulativeBytesLoaded ?? 0) /
                                  (event?.expectedTotalBytes ?? 1)
                              : null,
                          color: AppTheme.lightTheme.primaryColor)),
                  backgroundDecoration:
                      const BoxDecoration(color: Colors.black),
                  pageController: _pageController,
                  onPageChanged: _onPageChanged)),

          // Navigation arrows for accessibility
          if (_showControls) ...[
            // Left arrow
            if (_currentIndex > 0)
              Positioned(
                  left: 16,
                  top: 50.h,
                  child: FadeTransition(
                      opacity: _controlsAnimation,
                      child: GestureDetector(
                          onTap: () => _navigateToImage(-1),
                          child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  shape: BoxShape.circle),
                              child: CustomIconWidget(
                                  iconName: 'chevron_left',
                                  color: Colors.white,
                                  size: 24))))),

            // Right arrow
            if (_currentIndex < _albumImages.length - 1)
              Positioned(
                  right: 16,
                  top: 50.h,
                  child: FadeTransition(
                      opacity: _controlsAnimation,
                      child: GestureDetector(
                          onTap: () => _navigateToImage(1),
                          child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.5),
                                  shape: BoxShape.circle),
                              child: CustomIconWidget(
                                  iconName: 'chevron_right',
                                  color: Colors.white,
                                  size: 24))))),
          ],

          // Top navigation bar
          if (_showControls)
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: FadeTransition(
                    opacity: _controlsAnimation,
                    child: Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top,
                            left: 16,
                            right: 16,
                            bottom: 16),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.black.withValues(alpha: 0.7),
                              Colors.transparent,
                            ])),
                        child: Row(children: [
                          GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.black.withValues(alpha: 0.3),
                                      shape: BoxShape.circle),
                                  child: CustomIconWidget(
                                      iconName: 'arrow_back',
                                      color: Colors.white,
                                      size: 24))),
                          Expanded(
                              child: Center(
                                  child: Text(
                                      '${_currentIndex + 1} de ${_albumImages.length}',
                                      style: AppTheme
                                          .lightTheme.textTheme.titleMedium
                                          ?.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)))),
                          GestureDetector(
                              onTap: _shareImage,
                              child: Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.black.withValues(alpha: 0.3),
                                      shape: BoxShape.circle),
                                  child: CustomIconWidget(
                                      iconName: 'share',
                                      color: Colors.white,
                                      size: 24))),
                        ])))),

          // Bottom control panel
          if (_showControls)
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: FadeTransition(
                    opacity: _controlsAnimation,
                    child: WallpaperControlPanelWidget(
                        currentImage: _albumImages[_currentIndex],
                        onSetWallpaper: _showWallpaperOptions,
                        onToggleFavorite: _toggleFavorite,
                        onShare: _shareImage,
                        onDelete: _deleteImage))),

          // Image metadata overlay
          if (_showMetadata)
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SlideTransition(
                    position: _metadataAnimation,
                    child: ImageMetadataWidget(
                        imageData: _albumImages[_currentIndex],
                        onClose: _toggleMetadata))),
        ]));
  }
}
