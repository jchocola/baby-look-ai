import 'dart:typed_data';

import 'package:baby_look/features/feature_auth/presentation/auth_gate.dart';
import 'package:baby_look/features/feature_auth/presentation/auth_page.dart';
import 'package:baby_look/features/feature_dashboard/presentation/home_page/home_page.dart';
import 'package:baby_look/features/feature_gallery/presentation/full_screen_view_page.dart';
import 'package:baby_look/features/feature_gallery/presentation/gallery_page.dart';
import 'package:baby_look/features/feature_gallery/presentation/prediction_detail_page.dart';
import 'package:baby_look/features/feature_generate/domain/prediction_entity.dart';
import 'package:baby_look/features/feature_generate/presentation/generate_page.dart';
import 'package:baby_look/features/feature_generate/presentation/image_viewer_after_generating.dart';
import 'package:baby_look/features/feature_user/presentation/pages/about_app/about_app_page.dart';
import 'package:baby_look/features/feature_user/presentation/pages/help_faq/help_faq_page.dart';
import 'package:baby_look/features/feature_user/presentation/pages/prediction_history/prediction_history_page.dart';
import 'package:baby_look/features/feature_user/presentation/user_page.dart';
import 'package:baby_look/main.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/auth_gate',
  routes: [
    GoRoute(path: '/auth_gate', builder: (context, state) => AuthGate(),),

    GoRoute(path: '/auth', builder: (context, state) => AuthPage(),
    routes: [
      GoRoute(path: '/faq', builder: (context,state)=> HelpFaqPage())
    ]
    ),
    

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainPage(navigationShell: navigationShell,);
      },
      branches: [
        ///
        /// BRANCH HOME
        ///
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/home', builder: (context, state) => HomePage()),
          ],
        ),

        ///
        /// BRANCH CREATE
        ///
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/generate',
              builder: (context, state) => GeneratePage(),
           
            ),
          ],
        ),

        ///
        /// BRANCH GALLERY
        ///
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/gallery',
              builder: (context, state) => GalleryPage(),
              routes: [
                GoRoute(path: '/image_viewer_after_generating', builder: (context, state) => ImageViewerAfterGenerating(imageBytes: state.extra as Uint8List),),
                GoRoute(path: '/prediction_detail', builder: (context, state) => PredictionDetailPage(prediction: state.extra as PredictionEntity?,),),
                GoRoute(path: '/fullscreen_view', builder: (context, state) => FullScreenViewPage(prediction: state.extra as PredictionEntity?,),)
              ]
            ),
          ],
        ),

        ///
        /// BRANCH USER
        ///
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/user', builder: (context, state) => UserPage(),
            routes: [
              GoRoute(path: '/faq', builder: (context,state)=> HelpFaqPage()),
               GoRoute(path: '/history', builder: (context,state)=> PredictionHistoryPage()),
               GoRoute(path: '/about', builder: (context,state)=> AboutAppPage())
            ]
            ),
          ],
        ),
      ],
    ),
  ],
);
