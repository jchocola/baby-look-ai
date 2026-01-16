import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:gif_view/gif_view.dart';

class VideoGif extends StatelessWidget {
  VideoGif({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(AppConstant.borderRadius),
      child: GifView.asset(
        'assets/video.gif',
        height: 200,
        width: 200,
        frameRate: 10,
      ),
    );
  }
}
