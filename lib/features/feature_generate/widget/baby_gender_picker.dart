import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_enum/baby_gender.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/features/feature_generate/bloc/prepare_data_bloc.dart';
import 'package:baby_look/shared/gender_card_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BabyGenderPicker extends StatelessWidget {
  const BabyGenderPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final _genderOption = [
      {"title": context.tr(AppText.boy), "gender": BABY_GENDER.BOY, "icon": AppIcon.boyIcon},
      {"title": context.tr(AppText.girl), "gender": BABY_GENDER.GIRL, "icon": AppIcon.girlIcon},
      {
        "title": context.tr(AppText.dont_know),
        "gender": BABY_GENDER.DONT_KNOW,
        "icon": AppIcon.dontKnowIcon,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //spacing: AppConstant.appPadding,
      children: [
        Text(context.tr(AppText.baby_gender), style: theme.textTheme.titleMedium),
        Text(
          context.tr(AppText.choose_the_baby_gender),
          style: theme.textTheme.bodySmall,
        ),
        SizedBox(height: AppConstant.appPadding,),

        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: AppConstant.appPadding,
          ),
          itemCount: _genderOption.length,

          itemBuilder: (context, index) {
            final option = _genderOption[index];
            return BlocBuilder<PrepareDataBloc,PrepareDataBlocState>(
              builder:(context,state)=> GenderCardPicker(
                onTap: () => context.read<PrepareDataBloc>().add(PrepareDataBlocEvent_setGender(value:option["gender"] as BABY_GENDER )),
                title: option["title"] as String,
                icon: option["icon"] as IconData,
                isSelected: state is PrepareDataBlocState_loaded && state.babyGender == option["gender"],
              ),
            );
          },
        ),

       // Text('Selected: Dont know'),
      ],
    );
  }
}
