import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../config/app_spacing.dart';
import '../login/login_page.dart';
import 'widgets/navigation_indicator.dart';
import 'widgets/overview_section_one.dart';
import 'widgets/overview_section_three.dart';
import 'widgets/overview_section_two.dart';

class OverviewPage extends StatefulWidget {
  const OverviewPage({super.key});

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  late PageController _pageViewController;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  void _goToNextPage() {
    _pageViewController.nextPage(
      duration: const Duration(milliseconds: 800),
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = ColorScheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageViewController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => currentPage = index);
                },
                children:
                    <Widget>[
                      const OverviewSectionOne(),
                      const OverviewSectionTwo(),
                      const OverviewSectionThree(),
                    ].map((widget) {
                      return Padding(padding: const .all(48), child: widget);
                    }).toList(),
              ),
            ),
            AppSpacing.h16,
            Padding(
              padding: const .symmetric(horizontal: 48),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    currentPage < 2
                        ? _goToNextPage()
                        : context.pushReplacement(const LoginPage());
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: colorScheme.onPrimary,
                  ),
                  child: Text(
                    S.of(context).next,
                    style: textTheme.titleLarge?.copyWith(
                      color: colorScheme.primary,
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
              child: NavIndicator(count: 3, currentPage: currentPage),
            ),
          ],
        ),
      ),
    );
  }
}
