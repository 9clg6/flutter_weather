import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weather/presentation/view/current_weather_page.dart';
import 'package:flutter_weather/presentation/view/custom_search_page.dart';
import 'package:flutter_weather/presentation/view_model/forecast_viewmodel.dart';
import 'package:flutter_weather/presentation/view_model/weather_viewmodel.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomePage extends StatefulWidget implements AutoRouteWrapper {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
        ChangeNotifierProvider(create: (_) => ForecastViewModel()),
      ],
      child: this,
    );
  }
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController();
  int _selectedIndex = 0;
  final _children = [
    const CurrentWeatherPage(),
    const SearchPage(),
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
            physics: const NeverScrollableScrollPhysics(),
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
