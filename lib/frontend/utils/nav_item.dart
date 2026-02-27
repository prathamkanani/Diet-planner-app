import 'package:flutter/material.dart';

class NavItem {
  final Widget page;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;

  const NavItem({
    required this.page,
    required this.icon,
    required this.activeIcon,
    required this.label,
    this.isActive = false
  });
}
