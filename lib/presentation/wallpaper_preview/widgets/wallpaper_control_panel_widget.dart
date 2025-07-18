import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class WallpaperControlPanelWidget extends StatelessWidget {
  final Map<String, dynamic> currentImage;
  final VoidCallback onSetWallpaper;
  final VoidCallback onToggleFavorite;
  final VoidCallback onShare;
  final VoidCallback onDelete;

  const WallpaperControlPanelWidget({
    Key? key,
    required this.currentImage,
    required this.onSetWallpaper,
    required this.onToggleFavorite,
    required this.onShare,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isFavorite = currentImage["isFavorite"] as bool? ?? false;
    final bool isLocal = currentImage["isLocal"] as bool? ?? false;

    return Container(
      padding: EdgeInsets.only(
        left: 4.w,
        right: 4.w,
        top: 2.h,
        bottom: MediaQuery.of(context).padding.bottom + 2.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black.withValues(alpha: 0.8),
            Colors.black.withValues(alpha: 0.4),
            Colors.transparent,
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Primary action button
          Container(
            width: double.infinity,
            height: 6.h,
            child: ElevatedButton(
              onPressed: onSetWallpaper,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.lightTheme.primaryColor,
                foregroundColor: Colors.white,
                elevation: 2,
                shadowColor: Colors.black.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconWidget(
                    iconName: 'wallpaper',
                    color: Colors.white,
                    size: 20,
                  ),
                  SizedBox(width: 2.w),
                  Text(
                    'Establecer como fondo',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 2.h),

          // Secondary action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Favorite button
              _buildActionButton(
                icon: isFavorite ? 'favorite' : 'favorite_border',
                label: isFavorite ? 'Favorito' : 'Favorito',
                onTap: onToggleFavorite,
                color: isFavorite ? Colors.red : Colors.white,
              ),

              // Share button
              _buildActionButton(
                icon: 'share',
                label: 'Compartir',
                onTap: onShare,
                color: Colors.white,
              ),

              // Delete button (only for local images)
              if (isLocal)
                _buildActionButton(
                  icon: 'delete',
                  label: 'Eliminar',
                  onTap: onDelete,
                  color: Colors.red[300] ?? Colors.red,
                ),

              // Info button
              _buildActionButton(
                icon: 'info',
                label: 'Info',
                onTap: () {
                  // This would typically show metadata
                },
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 1.h,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: icon,
              color: color,
              size: 24,
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
