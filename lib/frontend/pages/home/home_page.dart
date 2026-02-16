import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../dashboard/dashboard_page.dart';
import '../user_detail/user_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = const [
    DashboardPage(),
    // ReportPage(),
    UserDetailPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);

    return Scaffold(
      backgroundColor: colorScheme.secondaryContainer,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: 0.1),
              spreadRadius: 5,
              blurRadius: 2,
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 3,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home),
              label: S.of(context).home,
            ),
            // const BottomNavigationBarItem(
            //   icon: Icon(Icons.insights),
            //   label: 'Report',
            // ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: S.of(context).account,
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
