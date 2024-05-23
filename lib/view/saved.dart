import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  List<String> savedHouses = [];
  @override
  void initState() {
    super.initState();
    loadSavedHouses();
  }

  void loadSavedHouses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedHouses = prefs.getStringList('savedHouses') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: savedHouses.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(savedHouses[index]),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Remove from saved'),
                  content: Text('Do you want to remove ${savedHouses[index]} from saved?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        savedHouses.removeAt(index);
                        prefs.setStringList('savedHouses', savedHouses);
                        loadSavedHouses();
                        Navigator.pop(context);
                      },
                      child: const Text('Remove'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }
}
