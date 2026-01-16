import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:flutter/material.dart';

class GeneratedImageCard extends StatelessWidget {
  const GeneratedImageCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(AppConstant.borderRadius),
      child: Container(
        color: Colors.blueAccent,
        width: size.width * 0.8,
        height: size.width * 0.8,
        child: Image.network(
           'https://raisingchildren.net.au/__data/assets/image/0026/47816/newborn-behaviour-nutshellnarrow.jpg',
           fit: BoxFit.cover,
        ),
      ),
    );
  }
}
