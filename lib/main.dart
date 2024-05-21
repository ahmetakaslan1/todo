import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/models/item_data.dart';
import './models/color_theme_data.dart';
import './screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int themeIndex = prefs.getInt('selectedThemeIndex') ?? 0;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ItemData>(
            create: (BuildContext context) => ItemData()),
        ChangeNotifierProvider<ColorThemeData>(
            create: (context) => ColorThemeData()),
      ],
      child: MyApp(themeIndex: themeIndex),
    ),
  );
}

class MyApp extends StatelessWidget {
  final int themeIndex;

  MyApp({required this.themeIndex});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ColorThemeData>(context, listen: false).switchTheme(themeIndex),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: Provider.of<ColorThemeData>(context).selectedThemeData,
            home: HomePage(),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
