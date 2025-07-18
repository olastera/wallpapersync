import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class QuickActionsWidget extends StatelessWidget {
  final VoidCallback onPreviewTap;
  final VoidCallback onShuffleTap;
  final VoidCallback onAlbumSwitchTap;

  const QuickActionsWidget({
    Key? key,
    required this.onPreviewTap,
    required this.onShuffleTap,
    required this.onAlbumSwitchTap,
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
                  iconName: 'flash_on',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Acciones Rápidas',
                  style: AppTheme.lightTheme.textTheme.titleMedium,
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: 'preview',
                    label: 'Vista Previa',
                    subtitle: 'Explorar álbum',
                    onTap: onPreviewTap,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildActionButton(
                    icon: 'shuffle',
                    label: 'Aleatorio',
                    subtitle: 'Modo shuffle',
                    onTap: onShuffleTap,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: _buildActionButton(
                    icon: 'swap_horiz',
                    label: 'Cambiar',
                    subtitle: 'Otro álbum',
                    onTap: onAlbumSwitchTap,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String icon,
    required String label,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: icon,
                color: AppTheme.lightTheme.colorScheme.onPrimaryContainer,
                size: 24,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 0.5.h),
            Text(
              subtitle,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
