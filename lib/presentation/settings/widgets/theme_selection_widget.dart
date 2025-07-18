import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ThemeSelectionWidget extends StatelessWidget {
  final String currentTheme;
  final Function(String) onThemeChanged;

  const ThemeSelectionWidget({
    Key? key,
    required this.currentTheme,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themes = [
      {
        'value': 'light',
        'title': 'Tema Claro',
        'subtitle': 'Siempre usar tema claro',
        'icon': 'light_mode'
      },
      {
        'value': 'dark',
        'title': 'Tema Oscuro',
        'subtitle': 'Siempre usar tema oscuro',
        'icon': 'dark_mode'
      },
      {
        'value': 'system',
        'title': 'Seguir Sistema',
        'subtitle': 'Usar configuración del sistema',
        'icon': 'settings_system_daydream'
      },
    ];

    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: 'palette',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              SizedBox(width: 3.w),
              Text(
                'Seleccionar Tema',
                style: AppTheme.lightTheme.textTheme.titleLarge,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          ...themes.map((theme) => Container(
                margin: EdgeInsets.only(bottom: 1.h),
                child: ListTile(
                  leading: Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: currentTheme == theme['value']
                          ? AppTheme.lightTheme.colorScheme.primaryContainer
                          : AppTheme
                              .lightTheme.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(3.w),
                    ),
                    child: Center(
                      child: CustomIconWidget(
                        iconName: theme['icon'] as String,
                        color: currentTheme == theme['value']
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        size: 20,
                      ),
                    ),
                  ),
                  title: Text(
                    theme['title'] as String,
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    theme['subtitle'] as String,
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                  trailing: currentTheme == theme['value']
                      ? CustomIconWidget(
                          iconName: 'check_circle',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 24,
                        )
                      : CustomIconWidget(
                          iconName: 'radio_button_unchecked',
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                          size: 24,
                        ),
                  onTap: () {
                    onThemeChanged(theme['value'] as String);
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                ),
              )),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
