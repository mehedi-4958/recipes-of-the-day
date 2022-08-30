import 'package:flutter/material.dart';
import 'package:recipes_of_the_day/components/grocery_tile.dart';
import 'package:recipes_of_the_day/models/models.dart';
import 'package:recipes_of_the_day/screens/grocery_item_screen.dart';

class GroceryListScreen extends StatelessWidget {
  const GroceryListScreen({
    Key? key,
    required this.groceryManager,
  }) : super(key: key);

  final GroceryManager groceryManager;

  @override
  Widget build(BuildContext context) {
    final groceryItems = groceryManager.groceryItems;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final item = groceryItems[index];
          return Dismissible(
            key: Key(item.id),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(
                Icons.delete_forever,
                color: Colors.white,
                size: 50.0,
              ),
            ),
            onDismissed: (direction) {
              groceryManager.deleteItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${item.name} removed from the list',
                  ),
                ),
              );
            },
            child: InkWell(
              child: GroceryTile(
                item: item,
                key: Key(item.id),
                onComplete: (change) {
                  if (change != null) {
                    groceryManager.completeItem(index, change);
                  }
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroceryItemScreen(
                      originalItem: item,
                      onUpdate: (item) {
                        groceryManager.updateItem(item, index);
                        Navigator.pop(context);
                      },
                      onCreate: (item) {},
                    ),
                  ),
                );
              },
            ),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16,
          );
        },
        itemCount: groceryItems.length,
      ),
    );
  }
}
