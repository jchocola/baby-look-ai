import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:baby_look/shared/custom_circle_icon.dart';
import 'package:flutter/material.dart';

class GeneratedCardWidget extends StatelessWidget {
  const GeneratedCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(AppConstant.borderRadius),
      child: Container(
        decoration: BoxDecoration(color: AppColor.pinkColor2),
        child: Column(
          // spacing: AppConstant.appPadding,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.network(
                    'https://raisingchildren.net.au/__data/assets/image/0026/47816/newborn-behaviour-nutshellnarrow.jpg',
                    fit: BoxFit.cover,
                    height: double.maxFinite,
                  ),

                  Positioned(
                    right: AppConstant.appPadding/2,
                    top: AppConstant.appPadding,
                    child: CustomCircleIcon(),
                  ),

                  Positioned(
                    left: AppConstant.appPadding/2,
                    top: AppConstant.appPadding,
                    child: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            child: Row(
                              spacing: AppConstant.appPadding,
                              children: [
                                Icon(AppIcon.eyeIcon),
                                Text('View detail'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            child: Row(
                              spacing: AppConstant.appPadding,
                              children: [
                                Icon(AppIcon.shareIcon),
                                Text('Share'),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            child: Row(
                              spacing: AppConstant.appPadding,
                              children: [
                                Icon(AppIcon.fullScreenIcon),
                                Text('Fullscreen'),
                              ],
                            ),
                          ),
                        ];
                      },
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(AppConstant.appPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Favorite Little Girl'), Text('Jan 13, 2026')],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
