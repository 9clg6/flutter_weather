import 'package:flutter/material.dart';
import 'package:flutter_weather/presentation/view/current_weather_page.dart';
import 'package:flutter_weather/presentation/view/other_weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController();
  int _selectedIndex = 0;
  final _children = [
    const CurrentWeatherPage(),
    const OtherWeatherPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        backgroundColor: Colors.red,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
            controller.animateToPage(
              _selectedIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          });
        },
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Learn',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(Icons.search_outlined),
            label: 'Relearn',
          ),
        ],
      ),
      body: SafeArea(
        child: PageView(
          controller: controller,
          children: _children,
          onPageChanged: (value) {
            setState(() => _selectedIndex = value);
          },
        ),
      ),
    );
  }
}
