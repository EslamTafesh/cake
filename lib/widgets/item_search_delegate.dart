import 'package:cake/data/items.dart';
import 'package:cake/models/item.dart';
import 'package:cake/Screens/show_item.dart';
import 'package:flutter/material.dart';

class ItemSearchDelegate extends SearchDelegate<Item?> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [ 
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = dummyItems
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: Image.asset(item.imagePath, width: 50, height: 50, fit: BoxFit.cover),
          title: Text(item.name),
          onTap: () {
            close(context, item);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ShowItem(item: item),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = dummyItems
        .where((item) => item.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        return ListTile(
          title: Text(item.name),
          onTap: () {
            query = item.name;
            showResults(context);
          },
        );
      },
    );
  }
}
