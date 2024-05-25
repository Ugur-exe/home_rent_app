import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:home_rent/utils/color.dart';
import 'package:home_rent/view/places_explain.dart';
import 'package:home_rent/viewmodel/home_model.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  Map<String, dynamic> savedHouses = {};
  List<String> saved = [];
  @override
  void initState() {
    super.initState();
    loadSavedHouses();
  }

  void loadSavedHouses() async {
    final Map<String, dynamic> favs = {};
    DocumentReference collections = await FirebaseFirestore.instance
        .collection('user_fav')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    collections.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        favs.addAll(documentSnapshot.data() as Map<String, dynamic>);
        print(favs);
        favs.forEach((key, value) {
          savedHouses[key] = value;
        });
        setState(() {
          saved = savedHouses.keys.toList();
        });
      }
    });

    // setState(() {
    //   savedHomes.forEach((element) {
    //     savedHouses[element.id] = element.data() as Map<String, dynamic>;
    //     // print(savedHouses[element.id]);
    //   });
    //   saved = savedHouses.keys.toList();
    //   print(saved);
    // });
  }

  @override
  Widget build(BuildContext context) {
    double top = MediaQuery.of(context).padding.top;
    double bottom = MediaQuery.of(context).padding.bottom;

    return Column(
      //destination text
      children: [
        // container for pictures
        SizedBox(
          height: MediaQuery.of(context).size.height - top - bottom - 39,
          //color: Colors.blue,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: savedHouses.length,
            itemBuilder: (BuildContext context, int id) {
              Popular populars = destinations[id];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DestinationScreen(Popular: populars),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(right: 15),
                  width: 230.0,
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
                                populars.city,
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
                                populars.description,
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
                                    populars.rating,
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
                          tag: populars.imageUrl,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image(
                                  height: 160.0,
                                  width: 180.0,
                                  image: AssetImage(populars.imageUrl),
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
        ),
      ],
    );
  }
}
