import 'package:flutter/material.dart';

class PageviewIndicator extends StatelessWidget {
  final int count;
  final int currentPage;

  const PageviewIndicator({
    super.key,
    required this.count,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        const double spacing = 4;
        final double totalSpacing = spacing * count;
        final double itemWidth =
            (constraints.maxWidth - totalSpacing) / count;

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(count, (index) {
            final isActive = currentPage == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsetsGeometry.symmetric(horizontal: 2),
              width: itemWidth,
              height: 8,
              decoration: BoxDecoration(
                color: isActive
                    ? colorScheme.primary
                    : colorScheme.primary.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        );
      },
    );
  }
}
