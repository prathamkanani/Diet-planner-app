import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';
import '../dashboard/dashboard_page.dart';
import '../report/report_page.dart';
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
    ReportPage(),
    UserDetailPage(),
  ];

  String pageToTitle(int index) {
    switch (index) {
      case 1:
        return S.of(context).report;
      case 2:
        return S.of(context).userDetails;
      default:
        return S.of(context).dashboard;
    }
  }

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
      appBar: AppBar(
        title: Text(pageToTitle(_selectedIndex)),
      ),
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
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.insights),
              label: 'Report',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
