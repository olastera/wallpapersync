import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecentHistoryWidget extends StatelessWidget {
  final List<Map<String, dynamic>> historyItems;
  final Function(Map<String, dynamic>) onRestoreTap;

  const RecentHistoryWidget({
    Key? key,
    required this.historyItems,
    required this.onRestoreTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'history',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Historial Reciente',
                  style: AppTheme.lightTheme.textTheme.titleMedium,
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    // Navigate to full history
                  },
                  child: Text(
                    'Ver Todo',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            SizedBox(
              height: 15.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: historyItems.length,
                separatorBuilder: (context, index) => SizedBox(width: 3.w),
                itemBuilder: (context, index) {
                  final item = historyItems[index];
                  return _buildHistoryCard(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => onRestoreTap(item),
      child: Container(
        width: 25.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CustomImageWidget(
                imageUrl: item["imageUrl"] as String,
                width: 25.w,
                height: 15.h,
                fit: BoxFit.cover,
              ),
            ),

            // Overlay
            Container(
              width: 25.w,
              height: 15.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),

            // Content
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(2.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item["title"] as String,
                      style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      _formatTimestamp(item["timestamp"] as DateTime),
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 8.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Restore Icon
            Positioned(
              top: 1.h,
              right: 1.w,
              child: Container(
                padding: EdgeInsets.all(1.w),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: CustomIconWidget(
                  iconName: 'restore',
                  color: Colors.white,
                  size: 12,
                ),
              ),
            ),
          ],
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
