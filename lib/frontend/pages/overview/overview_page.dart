import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../config/app_spacing.dart';
import '../login/login_page.dart';
import 'widgets/overview_section_one.dart';
import 'widgets/overview_section_three.dart';
import 'widgets/overview_section_two.dart';
import 'widgets/custom_indicator.dart';

enum OverviewPageType { section1, section2, section3 }

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 800),
      curve: Curves.decelerate,
    );
  }

  void onTap() {
    (_controller.page?.toInt() ?? 0) < OverviewPageType.values.length - 1
        ? _goToNextPage()
        : context.pushReplacement(const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = ColorScheme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView.builder(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: OverviewPageType.values.length,
                itemBuilder: (_, final int index) {
                  final OverviewPageType type = .values[index];
                  final Widget section = switch (type) {
                    .section1 => const OverviewSectionOne(),
                    .section2 => const OverviewSectionTwo(),
                    .section3 => const OverviewSectionThree(),
                  };

                  return Padding(padding: const .all(48), child: section);
                },
              ),
            ),
            AppSpacing.h16,
            Padding(
              padding: const .symmetric(horizontal: 48),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onTap,
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                  ),
                  child: Text(
                    S.of(context).next,
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
            AppSpacing.h24,
            Padding(
              padding: .only(
                bottom: MediaQuery.viewPaddingOf(context).bottom + 20,
              ),
              child: CustomSmoothIndicator(
                controller: _controller,
                count: OverviewPageType.values.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
