import 'package:flutter/material.dart';
import 'package:recipes_of_the_day/models/models.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({
    Key? key,
    required this.groceryManager,
  }) : super(key: key);

  final GroceryManager groceryManager;

  @override
  Widget build(BuildContext context) {
    final groceryItems = groceryManager.groceryItems;
    return Container();
  }
}
