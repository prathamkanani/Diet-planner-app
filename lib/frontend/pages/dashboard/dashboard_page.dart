import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/logic/dashboard/meal_load/meal_cubit.dart';
import '../../../application/logic/dashboard/meal_log/meal_log_cubit.dart';
import '../../../application/service/app_data_service.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../config/app_spacing.dart';
import 'widgets/dashboard_date.dart';
import 'widgets/dashboard_view.dart';
import 'widgets/log_meal_button.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  final AppDataService appDataService = locator.get<AppDataService>();
  late final ScrollController scrollController;
  late final MealLoadingCubit mealLoadingCubit;
  late final MealLogCubit mealLogCubit;

  @override
  void initState() {
    super.initState();
    mealLoadingCubit = locator.get();
    mealLogCubit = locator.get();
    scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final isNewUser = appDataService.isNewUser;
      if (isNewUser != null && isNewUser) {
        await mealLoadingCubit.saveGeneratedMealPlan(appDataService.jsonList);
        await mealLoadingCubit.fetchExistingMealPlan(
          appDataService.mealPlanId!,
          DateTime.now(),
        );
        return;
      }
      mealLoadingCubit.fetchExistingMealPlan(
        appDataService.mealPlanId!,
        DateTime.now(),
      );
    });
  }

  @override
  void dispose() {
    mealLoadingCubit.close();
    mealLogCubit.close();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: mealLoadingCubit),
        BlocProvider.value(value: mealLogCubit),
      ],
      child: Scaffold(
        backgroundColor: cs.secondaryContainer,
        body: const CustomScrollView(
          slivers: [
            SliverPadding(
              padding: .all(16),
              sliver: SliverToBoxAdapter(child: DashboardDate()),
            ),
            SliverPadding(
              padding: .symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(child: AppSpacing.h16),
            ),
            DashboardView(),
          ],
        ),
        floatingActionButtonLocation: .centerFloat,
        floatingActionButton: const LogMealButton(),
      ),
    );
  }
}
