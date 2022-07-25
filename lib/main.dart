import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_of_the_day/models/models.dart';

import 'fooder_theme.dart';
import 'home.dart';

void main() {
  runApp(const Fooder());
}

class Fooder extends StatelessWidget {
  const Fooder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = FooderTheme.dark();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'Fooder',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => TabManager()),
          ChangeNotifierProvider(create: (context) => GroceryManager()),
          // TODO 10: Add GroceryManager Provider
        ],
        child: const Home(),
      ),
    );
  }
}
