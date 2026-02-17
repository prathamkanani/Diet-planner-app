import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/logic/meal_load/meal_cubit.dart';
import '../../../application/logic/meal_log/meal_log_cubit.dart';
import '../../../application/service/app_data_service.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/app_injector.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../config/app_color_palette.dart';
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
    mealLoadingCubit = locator.get()..fetchExistingMealPlan(DateTime.now());
    mealLogCubit = locator.get();
    scrollController = ScrollController();
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
        BlocProvider.value(value: mealLogCubit),
        BlocProvider.value(value: mealLoadingCubit),
      ],
      child: Scaffold(
        backgroundColor: cs.secondaryContainer,
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              title: Text(S.of(context).dashboard),
              centerTitle: true,
              surfaceTintColor: AppColorPalette.transparent,
            ),
            // Todo: How to get state data here?
            PinnedHeaderSliver(
              child: DashboardDate(scrollController: scrollController),
            ),
            const SliverToBoxAdapter(child: AppSpacing.h16),
            const DashboardView(),
          ],
        ),
        floatingActionButtonLocation: .centerFloat,
        floatingActionButton: const LogMealButton(),
      ),
    );
  }
}
