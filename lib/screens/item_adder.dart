import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/item_data.dart';

class ItemAdder extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            minLines: 1,
            maxLines: 3,
            controller: textController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Add Item',
              hintText: 'Enter your task here...',
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              final String title = textController.text.trim();
              if (title.isNotEmpty) {
                Provider.of<ItemData>(context, listen: false).addItem(title);
                Navigator.pop(context);
              }
            },
            child: Text('ADD'),
          ),
        ],
      ),
    );
  }
}