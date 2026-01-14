import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/shared/custom_circle_avatar.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppConstant.appPadding,
      children: [
        CustomCircleAvatar(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text('Expecting Parent'), Text('#13424353')],
          ),
        ),

   
      ],
    );
  }
}
