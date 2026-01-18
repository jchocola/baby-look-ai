import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';
import 'package:baby_look/features/feature_user/bloc/user_bloc.dart';
import 'package:baby_look/shared/custom_circle_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GeneratedCardWidget extends StatelessWidget {
  const GeneratedCardWidget({super.key, this.onCardTap, this.prediction});
  final void Function()? onCardTap;
  final PredictionEntity? prediction;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onCardTap,
      child: Card(
        // decoration: BoxDecoration(
        //   color: AppColor.pinkColor2,

        // ),
        child: Column(
          // spacing: AppConstant.appPadding,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadiusGeometry.only(
                      topLeft: Radius.circular(AppConstant.borderRadius),
                      topRight: Radius.circular(AppConstant.borderRadius),
                    ),
                    child: Image.network(
                      prediction?.photoUrl ?? AppConstant.defaultAvatarUrl,
                      //'https://raisingchildren.net.au/__data/assets/image/0026/47816/newborn-behaviour-nutshellnarrow.jpg',
                      fit: BoxFit.cover,
                      height: double.maxFinite,
                    ),
                  ),

                  Positioned(
                    right: AppConstant.appPadding / 4,
                    top: AppConstant.appPadding / 4,
                    child: BlocBuilder<UserBloc, UserBlocState>(
                      builder: (context, state) => CustomCircleIcon(
                        onPressed: () {
                          context.read<UserBloc>().add(
                            UserBlocEvent_likeOrUnlikePrediction(
                              prediction: prediction!,
                            ),
                          );
                        },
                        icon:
                            state is UserBlocState_loaded &&
                                state.userEntity.favourites.contains(
                                  prediction?.id,
                                )
                            ? AppIcon.favouriteSolidIcon
                            : AppIcon.favouriteRoundedIcon,
                        iconColor: state is UserBlocState_loaded &&
                                state.userEntity.favourites.contains(
                                  prediction?.id,
                                ) ? theme.colorScheme.primary : theme.colorScheme.secondary,
                      ),
                    ),
                  ),

                  Positioned(
                    left: AppConstant.appPadding / 4,
                    top: AppConstant.appPadding / 4,
                    child: PopupMenuButton(
                      icon: Icon(AppIcon.verticalMoreIcon, color: theme.colorScheme.secondary,),
                     
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            onTap: () {
                              context.go(
                                '/gallery/prediction_detail',
                                extra: prediction,
                              );
                            },
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
                            onTap: () {
                              context.go(
                                '/gallery/fullscreen_view',
                                extra: prediction,
                              );
                            },
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
                children: [
                  Text(
                    '${prediction?.gender ?? ''} / Gest. week (${prediction?.gestationWeek ?? 0})',
                    style: theme.textTheme.titleSmall,
                  ),
                  Text(
                    prediction?.created.toLocal().toString() ?? '',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
