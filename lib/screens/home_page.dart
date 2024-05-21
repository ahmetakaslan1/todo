import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/item_data.dart';
import 'package:todo/screens/item_adder.dart';
import 'package:todo/screens/settings.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: buildAppBar(context),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '${Provider.of<ItemData>(context).items.length} Items',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Consumer<ItemData>(
                    builder: (context, itemData, child) {
                      return ListView.builder(
                        itemCount: itemData.items.length,
                        itemBuilder: (context, index) {
                          final item = itemData.items[index];
                          return Container(
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(width: 2)
                            ),
                            //Burada sağ vey sola doğru silme
                            child: Dismissible(
                              key: UniqueKey(),
                              onDismissed: (_) {
                                itemData.deleteItem(index);
                              },
                              child: ListTile(
                                title: Text(
                                  item.title,
                                  style: TextStyle(
                                    decoration: item.isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                                trailing: Checkbox(
                                  value: item.isDone,
                                  onChanged: (_) {
                                    itemData.toggleStatus(index);
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: ItemAdder(),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(
              Icons.settings,
              size: 25,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        )
      ],
      title: Text('Get It Done'),
    );
  }
}