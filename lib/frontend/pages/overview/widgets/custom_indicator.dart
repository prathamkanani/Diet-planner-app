import 'package:flutter/material.dart';
import '../../../../infrastructure/extension/context_extension.dart';

class CustomSmoothIndicator extends StatefulWidget {
  final PageController controller;
  final int count;

  const CustomSmoothIndicator({
    super.key,
    required this.controller,
    required this.count,
  });

  @override
  State<CustomSmoothIndicator> createState() => _CustomSmoothIndicatorState();
}

class _CustomSmoothIndicatorState extends State<CustomSmoothIndicator> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        widget.controller.page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = context.cs;
    print(widget.controller.page);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.count, (index) {
        final distance = ((widget.controller.page ?? 0) - index).abs();
        final clamped = distance.clamp(0, 1);
        final selected = (1 - clamped).toDouble();

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const .symmetric(horizontal: 2),
          width: 8 + (16 * selected),
          height: 8,
          decoration: BoxDecoration(
            color: cs.primary.withValues(alpha: 0.5 + (0.5 * (selected))),
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }
}
