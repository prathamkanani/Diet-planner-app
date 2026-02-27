import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
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
  late final ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;

    return Scaffold(
      backgroundColor: cs.secondaryContainer,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            title: Text(S.of(context).dashboard),
            centerTitle: true,
            surfaceTintColor: AppColorPalette.transparent,
          ),
          PinnedHeaderSliver(
            child: DashboardDate(scrollController: scrollController),
          ),
          const SliverToBoxAdapter(child: AppSpacing.h16),
          const DashboardView(),
        ],
      ),
      floatingActionButtonLocation: .centerFloat,
      floatingActionButton: const LogMealButton(),
    );
  }
}
