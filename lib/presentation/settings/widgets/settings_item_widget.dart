import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SettingsItemWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String leadingIcon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? textColor;

  const SettingsItemWidget({
    Key? key,
    required this.title,
    this.subtitle,
    required this.leadingIcon,
    this.trailing,
    this.onTap,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 10.w,
        height: 10.w,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(2.w),
        ),
        child: Center(
          child: CustomIconWidget(
            iconName: leadingIcon,
            color: textColor ?? AppTheme.lightTheme.colorScheme.primary,
            size: 20,
          ),
        ),
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
          color: textColor ?? AppTheme.lightTheme.colorScheme.onSurface,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            )
          : null,
      trailing: trailing ??
          (onTap != null
              ? CustomIconWidget(
                  iconName: 'chevron_right',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 20,
                )
              : null),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
    );
  }
}
