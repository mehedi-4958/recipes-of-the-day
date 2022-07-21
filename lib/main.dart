import 'package:flutter/material.dart';

import 'fooder_theme.dart';
import 'home.dart';

void main() {
  runApp(const Fooder());
}

class Fooder extends StatelessWidget {
  const Fooder({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = FooderTheme.light();
    return MaterialApp(
      theme: theme,
      title: 'Fooderlich',
      home: const Home(),
    );
  }
}
