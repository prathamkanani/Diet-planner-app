import 'package:flutter/material.dart';

class NavIndicator extends StatelessWidget {
  final int count;
  final int currentPage;

  const NavIndicator({
    super.key,
    required this.count,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 30,
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
  }
}
