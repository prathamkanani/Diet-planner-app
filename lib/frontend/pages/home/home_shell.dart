// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../../../application/logic/meal_load/meal_cubit.dart';
// import '../../../application/logic/meal_log/meal_log_cubit.dart';
// import '../../../application/logic/report/report_cubit.dart';
// import '../../../application/service/app_data_service.dart';
// import '../../../domain/entity/nav_item.dart';
// import '../../../generated/l10n.dart';
// import '../../../infrastructure/app_injector.dart';
// import '../../../infrastructure/utils/helpers.dart';
// import '../dashboard/dashboard_page.dart';
// import '../report/report_page.dart';
// import '../user_detail/user_detail_page.dart';
//
// class HomeShell extends StatefulWidget {
//   const HomeShell({super.key});
//
//   @override
//   State<HomeShell> createState() => _HomeShellState();
// }
//
// class _HomeShellState extends State<HomeShell> {
//   final AppDataService appDataService = locator.get<AppDataService>();
//   late final MealLoadingCubit mealLoadingCubit;
//   late final MealLogCubit mealLogCubit;
//   late final ReportCubit reportCubit;
//   final DateTime todayDate = dateOnly(DateTime.now());
//
//   @override
//   void initState() {
//     super.initState();
//     mealLoadingCubit = locator.get()
//       ..checkForNewPlan(appDataService.planStartDate!, todayDate);
//     mealLogCubit = locator.get();
//     reportCubit = locator.get()
//       ..getMealLogCount(
//         startOfTheWeek(todayDate),
//         endOfTheWeek(todayDate),
//       );
//   }
//
//   @override
//   void dispose() {
//     mealLoadingCubit.close();
//     mealLogCubit.close();
//     reportCubit.close();
//     super.dispose();
//   }
//
//   int _selectedIndex = 0;
//   late final List<NavItem> navItems = [
//     NavItem(
//       page: const DashboardPage(),
//       icon: Icons.home_outlined,
//       activeIcon: Icons.home,
//       label: S.of(context).home,
//     ),
//     NavItem(
//       page: const ReportPage(),
//       icon: Icons.insights_outlined,
//       activeIcon: Icons.insights,
//       label: S.of(context).report,
//     ),
//     NavItem(
//       page: const UserDetailPage(),
//       icon: Icons.person_outline,
//       activeIcon: Icons.person,
//       label: S.of(context).account,
//     ),
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final ColorScheme colorScheme = ColorScheme.of(context);
//
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider.value(value: mealLogCubit),
//         BlocProvider.value(value: mealLoadingCubit),
//         BlocProvider.value(value: reportCubit),
//       ],
//       child: Scaffold(
//         backgroundColor: colorScheme.secondaryContainer,
//         body: IndexedStack(
//           index: _selectedIndex,
//           children: navItems.map((n) => n.page).toList(),
//         ),
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             boxShadow: [
//               BoxShadow(
//                 color: colorScheme.shadow.withValues(alpha: 0.1),
//                 spreadRadius: 5,
//                 blurRadius: 2,
//               ),
//             ],
//           ),
//           child: BottomNavigationBar(
//             elevation: 3,
//             items: navItems
//                 .map(
//                   (n) => BottomNavigationBarItem(
//                 icon: Icon(n.icon),
//                 activeIcon: Icon(n.activeIcon),
//                 label: n.label,
//               ),
//             )
//                 .toList(),
//             currentIndex: _selectedIndex,
//             onTap: _onItemTapped,
//           ),
//         ),
//       ),
//     );
//   }
// }
