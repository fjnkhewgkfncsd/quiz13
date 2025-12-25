import 'package:flutter/material.dart';
import '../../data/mock_grocery_repository.dart';
import '../../models/grocery.dart';
import 'grocery_form.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {

  void onCreate() async {
    // Navigate to the form screen using the Navigator push
    Grocery? newGrocery = await Navigator.push<Grocery>(
      context,
      MaterialPageRoute(builder: (context) => const GroceryForm()),
    );
    if (newGrocery != null) {
      setState(() {
        dummyGroceryItems.add(newGrocery);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('No items added yet.'));

    if (dummyGroceryItems.isNotEmpty) {
      //  Display groceries with an Item builder and  LIst Tile
      content = TabBarView(
        children: [
          ListView.builder(
            itemCount: dummyGroceryItems.length,
            itemBuilder: (context, index) =>
                GroceryTile(grocery: dummyGroceryItems[index]),
          ),
          ListView.builder(
            itemCount: dummyGroceryItems.where((item) => item.name.contains('b')).toList().length,
            itemBuilder: (context, index) {
              var filteredItems = dummyGroceryItems.where((item) => item.name.contains('b')).toList();
              return GroceryTile(grocery: filteredItems[index]);
            },
            )
        ],
      );
    }

    return DefaultTabController(length: 2,
      child: Scaffold(
        appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: onCreate, icon: const Icon(Icons.add))],
      ),
      body: content,
      bottomNavigationBar: const TabBar(
        tabs: [
          Tab(icon: Icon(Icons.local_grocery_store), text: 'Groceries'),
          Tab(icon: Icon(Icons.search), text: 'Search'),
        ],
      ),
      )
  );
  }
}

class GroceryTile extends StatelessWidget {
  const GroceryTile({super.key, required this.grocery});

  final Grocery grocery;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(width: 15, height: 15, color: grocery.category.color),
      title: Text(grocery.name),
      trailing: Text(grocery.quantity.toString()),
    );
  }
}
