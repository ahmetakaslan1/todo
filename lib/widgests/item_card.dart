// item_card.dart

import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String title;
  final bool isDone;
  final Function toggleStatus;
  final Function deleteItem;

  ItemCard({
    required this.title,
    required this.isDone,
    required this.toggleStatus,
    required this.deleteItem,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: isDone,
              onChanged: (value) {
                toggleStatus();
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteItem();
              },
            ),
          ],
        ),
      ),
    );
  }
}
