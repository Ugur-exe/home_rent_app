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
  List<String> savedHousesID = [];
  List<String> savedHousesCity = [];
  List<String> savedHousesCountry = [];
  List<String> savedHousesDescription = [];
  List<String> savedHousesRating = [];
  List<String> savedHousesPrices = [];
  List<String> savedHousesImageUrl = [];
  @override
  void initState() {
    super.initState();
    loadSavedHouses();
  }

  void loadSavedHouses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      savedHousesID = prefs.getStringList('savedHouses') ?? [];
      savedHousesCity = prefs.getStringList('savedHousesCity') ?? [];
      savedHousesCountry = prefs.getStringList('savedHousesCountry') ?? [];
      savedHousesDescription = prefs.getStringList('savedHousesDescription') ?? [];
      savedHousesRating = prefs.getStringList('savedHousesRating') ?? [];
      savedHousesPrices = prefs.getStringList('savedHousesPrices') ?? [];
      savedHousesImageUrl = prefs.getStringList('savedHousesImage') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //destination text
      children: [
        // container for pictures
        SizedBox(
          height: 300.0,
          //color: Colors.blue,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: savedHousesCity.length,
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
                                savedHousesCity[id],
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
                                savedHousesDescription[id],
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
                                    savedHousesRating[id],
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
                          tag: savedHousesImageUrl[id],
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
