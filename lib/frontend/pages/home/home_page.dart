import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../application/logic/meal_load/meal_cubit.dart';
import '../../../application/logic/meal_log/meal_log_cubit.dart';
import '../../../application/logic/report/report_cubit.dart';
import '../../../application/service/app_data_service.dart';
import '../../utils/nav_item.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../app/router/route_paths.dart';
import '../dashboard/dashboard_page.dart';
import '../report/report_page.dart';
import '../user_detail/user_detail_page.dart';

class HomePage extends StatefulWidget {
  final Widget child;

  const HomePage({super.key, required this.child});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppDataService appDataService = locator.get<AppDataService>();
  late final MealLoadingCubit mealLoadingCubit;
  late final MealLogCubit mealLogCubit;
  late final ReportCubit reportCubit;
  final DateTime todayDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    mealLoadingCubit = locator.get()
      ..checkForNewPlan(appDataService.planStartDate!, todayDate);
    mealLogCubit = locator.get();
    reportCubit = locator.get();
  }

  @override
  void dispose() {
    mealLoadingCubit.close();
    mealLogCubit.close();
    reportCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    final currentIndex = _locationToIndex(
      GoRouterState.of(context).uri.toString(),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: mealLogCubit),
        BlocProvider.value(value: mealLoadingCubit),
        BlocProvider.value(value: reportCubit),
      ],
      child: Listener(
        behavior: .translucent,
        onPointerDown: (_) {
          FocusScope.of(context).unfocus();
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        child: Scaffold(
          backgroundColor: cs.secondaryContainer,
          body: widget.child,
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: cs.shadow.withValues(alpha: 0.1),
                  spreadRadius: 5,
                  blurRadius: 2,
                ),
              ],
            ),
            child: BottomNavigationBar(
              elevation: 3,
              selectedItemColor: cs.primary,
              items: navItems.map((n) {
                return BottomNavigationBarItem(
                  icon: Icon(n.icon),
                  activeIcon: Icon(n.activeIcon),
                  label: n.label,
                );
              }).toList(),
              currentIndex: currentIndex,
              onTap: (i) => _onItemTapped(context, i),
            ),
          ),
          floatingActionButton: currentIndex == 0
              ? IconButton.filled(
                  onPressed: () => context.push(RoutePaths.chat),
                  icon: const Icon(Icons.chat),
                )
              : null,
        ),
      ),
    );
  }

  // region Custom Methods
  int _locationToIndex(String location) {
    switch (location) {
      case RoutePaths.report:
        return 1;
      case RoutePaths.profile:
        return 2;
      default:
        return 0;
    }
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RoutePaths.dashboard);
      case 1:
        context.go(RoutePaths.report);
      case 2:
        context.go(RoutePaths.profile);
    }
  }

  late final List<NavItem> navItems = [
    NavItem(
      page: const DashboardPage(),
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: S.of(context).home,
    ),
    NavItem(
      page: const ReportPage(),
      icon: Icons.insights_outlined,
      activeIcon: Icons.insights,
      label: S.of(context).report,
    ),
    NavItem(
      page: const UserDetailPage(),
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: S.of(context).account,
    ),
  ];

  //endregion
}
