import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:gif_view/gif_view.dart';

class VideoGif extends StatelessWidget {
  VideoGif({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.7;
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(AppConstant.borderRadius),
      child: GifView.asset(
        'assets/video.gif',
        height: size,
        width: size,
        frameRate: 10,
      ),
    );
  }
}
