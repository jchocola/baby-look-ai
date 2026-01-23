import 'package:baby_look/core/app_constant/app_constant.dart';
import 'package:baby_look/core/app_exception/app_exception.dart';
import 'package:baby_look/core/app_icon/app_icon.dart';
import 'package:baby_look/core/app_text/app_text.dart';
import 'package:baby_look/core/app_theme/app_color.dart';
import 'package:baby_look/core/toastification/show_error_custom_toastification.dart';
import 'package:baby_look/core/toastification/show_success_custom_toastification.dart';
import 'package:baby_look/features/feature_auth/presentation/bloc/auth_bloc.dart';
import 'package:baby_look/features/feature_auth/widget/animated_greetings_widget.dart';
import 'package:baby_look/features/feature_auth/widget/login_via_other_methods.dart';
import 'package:baby_look/features/feature_auth/widget/login_widget.dart';
import 'package:baby_look/features/feature_auth/widget/register_widget.dart';
import 'package:baby_look/features/feature_auth/widget/video_gif.dart';
import 'package:baby_look/shared/app_logo.dart';
import 'package:baby_look/shared/note_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _topExpanded = true;

  int _slidingIndex = 0;

  void changeSlidingIndex(int? value) {
    setState(() {
      _slidingIndex = value!;
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    // Начинаем с активного верха
    _controller.value = 1.0;
  }

  void _toggleAnimation(bool toTop) {
    if (toTop) {
      _controller.forward();
      _topExpanded = true;
    } else {
      _controller.reverse();
      _topExpanded = false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocListener<AuthBloc, AuthBlocState>(
        listener: (context, state) {
          if (state is AuthBlocState_error) {
            showErrorCustomToastification(
              title: AppExceptionConverter(context, exception: state.exception),
            );
          }

          if (state is AuthBlocState_authenticated) {
            context.go('/home');
          }
        },
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          body: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              // Интерполируем значения между 3 и 7
              final topFlex = (3 + (_controller.value * 4)).toInt();
              final bottomFlex = (7 - (_controller.value * 4)).toInt();

              // Интерполируем прозрачность между 0.6 и 1
              final topOpacity = 0.6 + (_controller.value * 0.4);
              final bottomOpacity = 1.0 - (_controller.value * 0.4);

              return Column(
                children: [
                  /// TOP PART
                  Expanded(
                    flex: topFlex,
                    child: GestureDetector(
                      onTap: () {
                        if (!_topExpanded) {
                          _toggleAnimation(true);
                        }
                      },
                      child: Container(
                        color: AppColor.whitColor,
                        child: Opacity(
                          opacity: topOpacity,
                          child: Padding(
                            padding: EdgeInsets.all(AppConstant.appPadding),
                            child: SingleChildScrollView(
                              child: Column(
                                spacing: AppConstant.appPadding,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SafeArea(
                                    child: Text(
                                      'BabyLook AI',
                                      style: theme.textTheme.headlineLarge,
                                    ),
                                  ),
                                  AnimatedGreetingsWidget(),
                                  Visibility(
                                    visible: _topExpanded,
                                    child: VideoGif(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  /// BOTTOM PART
                  Expanded(
                    flex: bottomFlex,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (_topExpanded) {
                          _toggleAnimation(false);
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.only(
                          topLeft: Radius.circular(
                            AppConstant.borderRadius * 4,
                          ),
                          topRight: Radius.circular(
                            AppConstant.borderRadius * 4,
                          ),
                        ),
                        child: Container(
                          color: _slidingIndex == 0
                              ? theme.colorScheme.onTertiary
                              : theme.colorScheme.onPrimary,
                          child: Opacity(
                            opacity: bottomOpacity,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(AppConstant.appPadding),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: AppConstant.appPadding,
                                    children: [
                                      Visibility(
                                        visible: _topExpanded,
                                        child:
                                            NoteWidget(
                                                  color: _slidingIndex == 0
                                                      ? theme
                                                            .colorScheme
                                                            .tertiary
                                                      : theme
                                                            .colorScheme
                                                            .primary,
                                                  icon: AppIcon.infoIcon,
                                                  note:
                                                      'Первые 500 регистраций этой недели получат 10 БЕСПЛАТНЫХ генераций!',
                                                )
                                                .animate(
                                                  onPlay: (controller) =>
                                                      controller.repeat(
                                                        reverse: true,
                                                      ),
                                                )
                                                .shimmer(
                                                  color: theme
                                                      .colorScheme
                                                      .onPrimary,
                                                  duration: 1500.ms,
                                                  delay: 500.ms,
                                                )
                                                .scaleXY(end: 1.1),
                                        //  Text(
                                        //   'Первые 500 регистраций этой недели получат 10 БЕСПЛАТНЫХ генераций!',
                                        //   style: theme.textTheme.titleLarge,
                                        //   textAlign: TextAlign.center,
                                        // ).animate(onPlay: (controller) => controller.repeat(reverse: true),).shimmer(color: theme.colorScheme.onPrimary, duration: 1500.ms , delay: 500.ms).scaleXY(end: 1.1),
                                      ),

                                      Visibility(
                                        visible: !_topExpanded,
                                        child: AppLogo()
                                            .animate(
                                              onPlay: (controller) {
                                                controller.repeat(
                                                  reverse: true,
                                                );
                                              },
                                            )
                                            .fadeIn()
                                            .shimmer(duration: 500.ms)
                                            .shake(duration: 1.seconds, hz: 2)
                                            .scaleXY(end: 1.1)
                                            .then(delay: 500.ms)
                                            .scaleXY(end: 1 / 1.1),
                                      ),

                                      Visibility(
                                        visible: !_topExpanded,
                                        child: Column(
                                          spacing: AppConstant.appPadding,
                                          children: [
                                            CupertinoSlidingSegmentedControl(
                                              groupValue: _slidingIndex,
                                              children: {
                                                0: Text(context.tr(AppText.login)),
                                                1: Text(context.tr(AppText.register)),
                                              },
                                              onValueChanged:
                                                  changeSlidingIndex,
                                            ),
                                            SizedBox.fromSize(
                                              size: Size.fromHeight(
                                                size.height * 0.35,
                                              ),
                                              child: _slidingIndex == 0
                                                  ? LoginWidget()
                                                  : RegisterWidget(),
                                            ),
                                            LoginViaOtherMethods(
                                              phoneAuthColor: _slidingIndex == 0
                                                  ? theme.colorScheme.tertiary
                                                  : theme.colorScheme.primary,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
