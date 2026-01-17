import 'package:flutter/material.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({super.key, this.url = ''});
  final String url;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      foregroundImage: NetworkImage(url),
    );
  }
}
