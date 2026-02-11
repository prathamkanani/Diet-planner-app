import 'package:flutter/material.dart';

class PageNavigationAnimation<T> extends PageRouteBuilder<T> {
  final Duration duration;

  PageNavigationAnimation({
    required Widget page,
    this.duration = const Duration(milliseconds: 800),
  }) : super(
         pageBuilder: (_, _, _) => page,
         transitionDuration: duration,
         reverseTransitionDuration: duration,
         transitionsBuilder: (context, animation, _, child) {
           final curved = CurvedAnimation(
             parent: animation,
             curve: Curves.decelerate,
           );

           return SlideTransition(
             position: Tween<Offset>(
               begin: const Offset(1.0, 0),
               end: Offset.zero,
             ).animate(curved),
             child: child,
           );
         },
       );
}
