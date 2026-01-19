import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/bloc/app_config_bloc.dart';
import 'package:baby_look/features/feature_user/presentation/modal/languages_modal.dart';
import 'package:baby_look/shared/custom_listile.dart';
import 'package:baby_look/shared/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wiredash/wiredash.dart';

class PreferrencesSettingWidget extends StatelessWidget {
  const PreferrencesSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Preferences', style: theme.textTheme.titleMedium),
        BlocBuilder<AppConfigBloc, AppConfigBlocState>(
          builder: (context, state) => CustomListile(
            onTap: () => context.read<AppConfigBloc>().add(
              AppConfigBlocEvent_toogleNotificationEnabilityValue(),
            ),
            title: 'Notifications',
            icon: AppIcon.notificationIcon,
            tralingWidget: state is AppConfigBlocState_loaded
                ? CustomSwitch(value: state.notificationEnability)
                : SizedBox(),
          ),
        ),
        CustomListile(
          title: 'Language',
          icon: AppIcon.languageIcon,
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return LanguagesModal();
              },
            );
          },
        ),
        CustomListile(
          title: 'Help and FAQ',
          icon: AppIcon.helpIcon,
          onTap: () {
            context.push('/user/faq');
          },
        ),
        CustomListile(
          title: 'Send Feedback',
          icon: AppIcon.feedbackIcon,
          onTap: () async {
            Wiredash.of(context).show(inheritMaterialTheme: true);
          },
        ),

        // CustomListile(title: 'Invite Friends',),
      ],
    );
  }
}
