import 'package:baby_look/features/feature_auth/presentation/auth_page.dart';
import 'package:baby_look/features/feature_dashboard/presentation/home_page/home_page.dart';
import 'package:baby_look/features/feature_gallery/presentation/gallery_page.dart';
import 'package:baby_look/features/feature_generate/presentation/generate_page.dart';
import 'package:baby_look/features/feature_user/presentation/user_page.dart';
import 'package:baby_look/main.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/auth',
  routes: [
    GoRoute(path: '/auth', builder: (context, state) => AuthPage(),),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainPage(navigationShell: navigationShell);
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
            ),
          ],
        ),

        ///
        /// BRANCH USER
        ///
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/user', builder: (context, state) => UserPage()),
          ],
        ),
      ],
    ),
  ],
);
