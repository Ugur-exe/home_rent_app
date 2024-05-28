import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:home_rent/utils/color.dart';
import 'package:home_rent/view/places_explain.dart';
import 'package:home_rent/viewmodel/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  List<Map<String, dynamic>> savedHouses = [];

  void _loadFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('variables_list');
    setState(() {
      if (jsonString != null) {
        final list = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
        savedHouses = list;
      }
    });
  }

  List<String> saved = [];
  @override
  void initState() {
    super.initState();
    _loadFromSharedPreferences();
  }

  void loadSavedHouses() async {
    // DocumentReference collections = FirebaseFirestore.instance
    //     .collection('user_fav')
    //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //     .collection("favourites")
    //     .doc();
    // savedHouses =
    //     collections.collection("favourites").get() as Map<String, dynamic>;
    // print(collections.collection("favourites").get());
    // setState(() {
    //   savedHouses = savedHouses.cast();
    //   print("saved: $saved");
    // });
  }

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    double bottom = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0.0,
        title: const Text(
          'Saved',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: savedHouses.length,
        itemBuilder: (BuildContext context, int index) {
          Popular populars = destinations[index];
          var savedHouse = savedHouses[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DestinationScreen(
                  Popular: populars,
                ),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              width: 230,
              //color: Colors.red,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  ///  want to add text below image then use it
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, right: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 210,
                          ),
                          Text(
                            savedHouse['city']?.toString() ??
                                '3BHK Villa, 1400 Sqft',
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            savedHouse['discription']?.toString() ??
                                'Villa with pool ideal for large families.\n3 bedrooms, 3 bathrooms, 3 living room',
                            style: const TextStyle(
                              color: Colors.black45,
                              fontSize: 8.0,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                size: 15.0,
                                color: Colors.yellow,
                              ),
                              const SizedBox(width: 5.0),
                              Text(
                                savedHouse['rating']?.toString() ?? '4.5',
                                style: const TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  //want to add text below image then use it
                  Container(
                    width: 230,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Hero(
                      // for animation of image to next screen
                      tag: savedHouse['id']?.toString() ?? '1',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                              height: 160.0,
                              width: 180.0,
                              image: AssetImage(savedHouse['imageUrl'] ??
                                  'assets/property1.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
