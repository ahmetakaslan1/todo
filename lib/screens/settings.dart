import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/color_theme_data.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Tema Seçimi Yapınız')),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SwitchCard());
  }
}


class SwitchCard extends StatefulWidget {
  @override
  _SwitchCardState createState() => _SwitchCardState();
}

class _SwitchCardState extends State<SwitchCard> {
  int _selectedThemeIndex = 0;
  List<ThemeData> _colorThemes = [];

  @override
  void initState() {
    super.initState();
    _loadSelectedThemeIndex();
  }

  Future<void> _loadSelectedThemeIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedThemeIndex = prefs.getInt('selectedThemeIndex') ?? 0;
      _colorThemes = Provider.of<ColorThemeData>(context, listen: false).colorThemes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(
            'Select Theme Color',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _colorThemes.length,
            itemBuilder: (context, index) {
              return RadioListTile<int>(
                title: Text('Theme ${index + 1}'),
                value: index,
                groupValue: _selectedThemeIndex,
                onChanged: (value) async {
                  setState(() {
                    _selectedThemeIndex = value!;
                  });
                  await Provider.of<ColorThemeData>(context, listen: false)
                      .switchTheme(value!);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
