import 'package:flutter/material.dart';
import '../../../../infrastructure/extension/context_extension.dart';

class MealTabBarHeader extends SliverPersistentHeaderDelegate {
  final TabController controller;

  const MealTabBarHeader({required this.controller});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final cs = context.cs;
    return Container(
      decoration: BoxDecoration(color: cs.secondaryContainer),
      child: TabBar(
        controller: controller,
        tabs: const <Widget>[
          Tab(icon: Text('☕', style: TextStyle(fontSize: 32))),
          Tab(icon: Text('🥗', style: TextStyle(fontSize: 32))),
          Tab(icon: Text('🍝', style: TextStyle(fontSize: 32))),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
