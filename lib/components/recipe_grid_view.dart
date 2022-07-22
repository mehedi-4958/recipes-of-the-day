import 'package:flutter/material.dart';
import 'package:recipes_of_the_day/components/components.dart';
import 'package:recipes_of_the_day/models/models.dart';

class RecipeGridView extends StatelessWidget {
  const RecipeGridView({
    Key? key,
    required this.recipes,
  }) : super(key: key);

  final List<SimpleRecipe> recipes;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
      ),
      child: GridView.builder(
        itemCount: recipes.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          final simpleRecipe = recipes[index];
          return RecipeThumbnail(recipe: simpleRecipe);
        },
      ),
    );
  }
}
