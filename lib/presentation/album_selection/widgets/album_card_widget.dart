import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AlbumCardWidget extends StatelessWidget {
  final Map<String, dynamic> album;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const AlbumCardWidget({
    Key? key,
    required this.album,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        elevation: isSelected ? 4 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: isSelected
              ? BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                )
              : BorderSide.none,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected
                ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(12)),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12)),
                        child: CustomImageWidget(
                          imageUrl: album['coverImage'] ?? '',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 2.w,
                      right: 2.w,
                      child: Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context)
                                  .colorScheme
                                  .surface
                                  .withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.outline,
                            width: 1.5,
                          ),
                        ),
                        child: isSelected
                            ? CustomIconWidget(
                                iconName: 'check',
                                color: Theme.of(context).colorScheme.onPrimary,
                                size: 4.w,
                              )
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(2.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        album['title'] ?? '',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'photo',
                            size: 3.w,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            '${album['photoCount'] ?? 0} fotos',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                          ),
                        ],
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
}
