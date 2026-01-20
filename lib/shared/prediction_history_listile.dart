import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_enum/baby_gender.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PredictionHistoryListile extends StatelessWidget {
  const PredictionHistoryListile({
    super.key,
    required this.prediction,
    this.onTap,
  });
  final PredictionEntity prediction;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(AppConstant.borderRadius),
          child: Image.network(
            fit: BoxFit.cover,
            prediction.photoUrl,
            width: AppConstant.preferredSizeHeight,
            height: AppConstant.preferredSizeHeight,
          ),
        ),
        title: Text(
          context.tr(AppText.week_n,args:  [prediction.gestationWeek.toString()]),
          style: theme.textTheme.titleMedium,
        ),
        subtitle: Text(
          prediction.created.toLocal().toString(),
          style: theme.textTheme.bodySmall,
        ),
        trailing: Icon(
          genderToIcon(gender: prediction.gender),
          color: genderFromStr(gender: prediction.gender) == BABY_GENDER.BOY
              ? theme.colorScheme.tertiary
              : theme.colorScheme.primary,
        ),
      ),
    );
  }
}
