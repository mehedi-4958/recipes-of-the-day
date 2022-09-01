import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_of_the_day/models/models.dart';

import 'fooder_theme.dart';
import 'screens/screens.dart';

void main() {
  runApp(
    const Fooder(),
  );
}

class Fooder extends StatefulWidget {
  const Fooder({Key? key}) : super(key: key);

  @override
  State<Fooder> createState() => _FooderState();
}

class _FooderState extends State<Fooder> {
  final _groceryManager = GroceryManager();
  final _profileManager = ProfileManager();
  // TODO: Create AppStateManager
  // TODO: Define AppRouter

  // TODO: Initialize AppRouter

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => _groceryManager,
        ),
        ChangeNotifierProvider(
          create: (context) => _profileManager,
        ),
      ],
      child: Consumer<ProfileManager>(
        builder: (context, profileManager, child) {
          ThemeData theme;
          if (profileManager.darkMode) {
            theme = FooderTheme.dark();
          } else {
            theme = FooderTheme.light();
          }

          return MaterialApp(
            theme: theme,
            title: 'Fooder',
            // TODO: Replace with Router widget
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
