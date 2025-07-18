import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AlbumPreviewWidget extends StatelessWidget {
  final Map<String, dynamic> album;
  final VoidCallback onClose;

  const AlbumPreviewWidget({
    Key? key,
    required this.album,
    required this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final previewImages = (album['previewImages'] as List<dynamic>?) ?? [];

    return Container(
      height: 80.h,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 10.w,
            height: 0.5.h,
            margin: EdgeInsets.symmetric(vertical: 1.h),
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        album['title'] ?? '',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'photo',
                            size: 4.w,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            '${album['photoCount'] ?? 0} fotos',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          ),
                          SizedBox(width: 4.w),
                          CustomIconWidget(
                            iconName: 'update',
                            size: 4.w,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            album['lastUpdated'] ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
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
                IconButton(
                  onPressed: onClose,
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: Theme.of(context).colorScheme.onSurface,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          Divider(
            height: 1,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),

          // Preview grid
          Expanded(
            child: previewImages.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.all(2.w),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        childAspectRatio: 1,
                      ),
                      itemCount:
                          previewImages.length > 9 ? 9 : previewImages.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CustomImageWidget(
                            imageUrl: previewImages[index],
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'photo_library',
                          size: 15.w,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'No hay imágenes de vista previa',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
