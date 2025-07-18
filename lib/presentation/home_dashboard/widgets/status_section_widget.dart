import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class StatusSectionWidget extends StatelessWidget {
  final bool isAutomationEnabled;
  final String selectedAlbum;
  final int nextUpdateMinutes;
  final ValueChanged<bool> onAutomationToggle;
  final VoidCallback onAlbumTap;

  const StatusSectionWidget({
    Key? key,
    required this.isAutomationEnabled,
    required this.selectedAlbum,
    required this.nextUpdateMinutes,
    required this.onAutomationToggle,
    required this.onAlbumTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Header
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'info',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Estado del Sistema',
                  style: AppTheme.lightTheme.textTheme.titleMedium,
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Automation Toggle
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cambio Automático',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        isAutomationEnabled
                            ? 'Activado - Cambios programados'
                            : 'Desactivado - Solo manual',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: isAutomationEnabled,
                  onChanged: onAutomationToggle,
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Next Update Timer
            if (isAutomationEnabled) ...[
              Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'schedule',
                      color: AppTheme.lightTheme.colorScheme.onPrimaryContainer,
                      size: 20,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Próximo Cambio',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onPrimaryContainer,
                            ),
                          ),
                          Text(
                            '$nextUpdateMinutes minutos',
                            style: AppTheme.lightTheme.textTheme.titleMedium
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _formatCountdown(nextUpdateMinutes),
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2.h),
            ],

            // Selected Album
            GestureDetector(
              onTap: onAlbumTap,
              child: Container(
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.outline,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'photo_library',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 20,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Álbum Seleccionado',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme
                                  .lightTheme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          Text(
                            selectedAlbum,
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    CustomIconWidget(
                      iconName: 'arrow_forward_ios',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatCountdown(int minutes) {
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      final remainingMinutes = minutes % 60;
      return remainingMinutes > 0
          ? '${hours}h ${remainingMinutes}m'
          : '${hours}h';
    }
    return '${minutes}m';
  }
}
