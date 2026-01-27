import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants/app_colors.dart';
import '../../../../language/language_controller.dart';

/// Image picker UI widget for uploading food images
class ImagePickerUI extends StatelessWidget {
  final Widget? preview;
  final VoidCallback onUpload;

  const ImagePickerUI({
    super.key,
    this.preview,
    required this.onUpload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: AppColors.uploadPlaceholder,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.colors.borderDefault,
          width: 1,
        ),
      ),
      child: preview != null
          ? preview
          : InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onUpload,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.camera_alt,
                    color: context.colors.secondaryText,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    Get.find<LanguageController>().tr('tap_to_upload_image'),
                    style: TextStyle(
                      color: context.colors.secondaryText,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}