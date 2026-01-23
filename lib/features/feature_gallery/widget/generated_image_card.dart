import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GeneratedImageCard extends StatelessWidget {
  const GeneratedImageCard({super.key, this.imageUrl, this.onTap});
  final String? imageUrl;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(AppConstant.borderRadius),
        child: Container(
          color: theme.colorScheme.onPrimary,
          width: size.width * 0.8,
          height: size.width * 0.8,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imageUrl ?? AppConstant.defaultAvatarUrl,
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
