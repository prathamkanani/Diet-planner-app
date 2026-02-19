import 'package:flutter/material.dart';

class PageviewIndicator extends StatefulWidget {
  final int count;
  final PageController controller;

  const PageviewIndicator({
    super.key,
    required this.count,
    required this.controller,
  });

  @override
  State<PageviewIndicator> createState() => _PageviewIndicatorState();
}

class _PageviewIndicatorState extends State<PageviewIndicator> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        widget.controller.page ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // For spacing them dynamically
        const double spacing = 4;
        final double totalSpacing = spacing * widget.count;
        final double itemWidth =
            (constraints.maxWidth - totalSpacing) / widget.count;

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(widget.count, (index) {
            // For animation of opacity changing smoothly
            final opacity = ((widget.controller.page ?? 0) - index).abs();
            final clampedOpacity = opacity.clamp(0, 1);
            final selected = (1 - clampedOpacity).toDouble();

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsetsGeometry.symmetric(horizontal: 2),
              width: itemWidth,
              height: 8,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(
                  alpha: 0.5 + (0.5 * selected),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        );
      },
    );
  }
}
