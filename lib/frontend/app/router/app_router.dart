import 'package:flutter/material.dart';
import '../../pages/bootstrap/bootstrap_page.dart';
import '../../pages/chat/chat_page.dart';
import '../../pages/dashboard/dashboard_page.dart';
import '../../pages/home/home_page.dart';
import '../../pages/login/login_page.dart';
import '../../pages/onboarding/onboarding_page.dart';
import '../../pages/overview/overview_page.dart';
import '../../pages/report/report_page.dart';
import '../../pages/setup/setup_page.dart';
import '../../pages/user_detail/user_detail_page.dart';
import 'route_paths.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

class AppRouter {
  static GoRouter goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.bootstrap,
    routes: [
      GoRoute(
        path: RoutePaths.bootstrap,
        builder: (_, _) => const BootstrapPage(),
      ),
      GoRoute(
        path: RoutePaths.overview,
        builder: (_, _) => const OverviewPage(),
      ),
      GoRoute(path: RoutePaths.login, builder: (_, _) => const LoginPage()),
      GoRoute(
        path: RoutePaths.onboarding,
        builder: (_, _) => const OnboardingPage(),
      ),
      GoRoute(path: RoutePaths.setup, builder: (_, _) => const SetupPage()),
      GoRoute(path: RoutePaths.home, redirect: (_, _) => RoutePaths.dashboard),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (_, _, child) {
          return HomePage(child: child);
        },
        routes: [
          GoRoute(
            path: RoutePaths.dashboard,
            builder: (_, _) => const DashboardPage(),
          ),
          GoRoute(
            path: RoutePaths.report,
            builder: (_, _) => const ReportPage(),
          ),
          GoRoute(
            path: RoutePaths.profile,
            builder: (_, _) => const UserDetailPage(),
          ),
        ],
      ),
      GoRoute(path: RoutePaths.chat, builder: (_, _) => const ChatPage()),
    ],
  );
}
