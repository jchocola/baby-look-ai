import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:baby_look/shared/custom_button_with_icon.dart';
import 'package:baby_look/shared/custom_rounded_icon.dart';
import 'package:flutter/material.dart';

class UploadParentPhotoCard extends StatelessWidget {
  const UploadParentPhotoCard({
    super.key,
    this.onGalleryTapped,
    this.onTapCameraTapped,
    this.title = 'title',
    this.subtitle = 'subtitle',
    this.icon = Icons.person,
    this.pickedImage
  });

  final String title;
  final String subtitle;
  final IconData icon;

  final Widget? pickedImage;

  final void Function()? onGalleryTapped;
  final void Function()? onTapCameraTapped;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(AppConstant.borderRadius),
      child: Container(
        width: double.infinity,
        height: size.height * 0.3,
        color: AppColor.blueColor3,
        child: pickedImage ?? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppConstant.appPadding,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomRoundedIcon(icon: icon),
            Text(title),
            Text(subtitle),
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButtonWithIcon(
                  icon: AppIcon.imageIcon,
                  title: 'Gallery',
                  onTap: onGalleryTapped,
                ),
                CustomButtonWithIcon(
                  icon: AppIcon.cameratIcon,
                  title: 'Camera',
                  onTap: onTapCameraTapped,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
