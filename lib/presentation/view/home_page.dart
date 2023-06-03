import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          "Bonjour,",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: NavigationBar(
        height: 65,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        selectedIndex: _selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        indicatorColor: Theme.of(context).colorScheme.background,
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
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: Theme.of(context).colorScheme.background,
            ),
            label: 'Accueil',
            tooltip: "Accueil",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.background,
            ),
            selectedIcon: Icon(
              Icons.search_outlined,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            label: 'Rechercher',
            tooltip: "Rechercher la météo d'une ville",
          ),
        ],
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: PageView(
            controller: controller,
            children: _children,
            onPageChanged: (value) {
              setState(() => _selectedIndex = value);
            },
          ),
        ),
      ),
    );
  }
}
