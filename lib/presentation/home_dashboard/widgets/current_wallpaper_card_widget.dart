import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class CurrentWallpaperCardWidget extends StatelessWidget {
  final Map<String, dynamic> wallpaper;
  final VoidCallback? onLongPress;

  const CurrentWallpaperCardWidget({
    Key? key,
    required this.wallpaper,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          height: 25.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              // Background Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomImageWidget(
                  imageUrl: wallpaper["imageUrl"] as String,
                  width: double.infinity,
                  height: 25.h,
                  fit: BoxFit.cover,
                ),
              ),

              // Blur Overlay
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: double.infinity,
                  height: 25.h,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                  ),
                ),
              ),

              // Content
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'wallpaper',
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Fondo Actual',
                            style: AppTheme.lightTheme.textTheme.labelMedium
                                ?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        wallpaper["title"] as String,
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'photo_library',
                            color: Colors.white.withValues(alpha: 0.8),
                            size: 16,
                          ),
                          SizedBox(width: 1.w),
                          Expanded(
                            child: Text(
                              wallpaper["album"] as String,
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            _formatTimestamp(
                                wallpaper["timestamp"] as DateTime),
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Long press hint
              Positioned(
                top: 2.h,
                right: 3.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomIconWidget(
                        iconName: 'touch_app',
                        color: Colors.white.withValues(alpha: 0.8),
                        size: 14,
                      ),
                      SizedBox(width: 1.w),
                      Text(
                        'Mantener presionado',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return 'hace ${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return 'hace ${difference.inHours}h';
    } else {
      return 'hace ${difference.inDays}d';
    }
  }
}
