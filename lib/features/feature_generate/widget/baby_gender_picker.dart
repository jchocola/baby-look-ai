import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/shared/gender_card_picker.dart';
import 'package:flutter/material.dart';

class BabyGenderPicker extends StatelessWidget {
  const BabyGenderPicker({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstant.appPadding,
      children: [
        Text('Baby Gender' , style: theme.textTheme.titleMedium,),
        Text("Choose the baby's gender or select if you don't know yet",style: theme.textTheme.bodySmall,),

        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: AppConstant.appPadding
          ),
          itemCount: 3,
          
          itemBuilder: (context, index) {
            return GenderCardPicker();
          },
        ),

        Text('Selected: Dont know'),
      ],
    );
  }
}
