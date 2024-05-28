
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_rent/utils/button.dart';
import 'package:home_rent/utils/color.dart';

class DestinationScreen extends StatefulWidget {
  final Homes;
  //method
  const DestinationScreen({super.key, required this.Homes});
  @override
  State<DestinationScreen> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 330,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ],
                  ),
                  child: Hero(
                    tag: widget.Homes.imageUrl,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      child: Image(
                        image: AssetImage(widget.Homes.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                //adding back arrow button
                Padding(
                    padding:
                        const EdgeInsets.only(top: 40, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.iconbg,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.primaryColor,
                              ),
                              color: Colors.black,
                              iconSize: 20.0,
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.iconbg,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: IconButton(
                                onPressed: () async {
                                  final Map<String, dynamic> variables = {
                                    'id': widget.Popular.id,
                                    'imageUrl': widget.Popular.imageUrl,
                                    'city': widget.Popular.city,
                                    'country': widget.Popular.country,
                                    'description': widget.Popular.description,
                                    'rating': widget.Popular.rating,
                                    'prices': widget.Popular.prices,
                                  };
                                  try{
                                    DocumentReference collections =
                                      FirebaseFirestore.instance
                                          .collection('homes')
                                          .doc(widget.Popular.id.toString());
                                  collections.set(variables);
                                  } on FirebaseException catch (e) {
                                    print(e);
                                  }
                                },
                                icon: const FaIcon(
                                  FontAwesomeIcons.star,
                                  size: 18.0,
                                  color: AppColors.primaryColor,
                                )),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //adding and Rating function
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.Popular.prices!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 20.0,
                            color: Colors.yellow,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            widget.Popular.rating,
                            style: const TextStyle(
                              fontSize: 15.0,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // ABOUT ANS DESCRIPTION
                  Text(
                    widget.Popular.city,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    widget.Popular.description,
                    style:
                        const TextStyle(fontSize: 13.0, color: Colors.black45),
                  ),

                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'specification',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24)),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.bed,
                                size: 18.0,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('3 Beds')
                            ],
                          ),
                          Divider(
                            thickness: 2,
                            indent: 3,
                            color: AppColors.primaryColor,
                          ),
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.bath,
                                size: 18.0,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('3 Bath')
                            ],
                          ),
                          Divider(
                            color: AppColors.primaryColor,
                          ),
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.kitchenSet,
                                size: 18.0,
                                color: AppColors.primaryColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('Kitchen')
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'Listed By',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    height: 75,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white24)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: AppColors.iconbg,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Image.asset(
                              'assets/nain.jpeg',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text('Ali Hasnain'),
                          const SizedBox(
                            width: 100,
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.iconbg,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Center(
                              child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const FaIcon(
                                    FontAwesomeIcons.phone,
                                    size: 18.0,
                                    color: AppColors.primaryColor,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.iconbg,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Center(
                              child: IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const FaIcon(
                                    FontAwesomeIcons.message,
                                    size: 18.0,
                                    color: AppColors.primaryColor,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  RoundButton(title: "Book Now", onTap: () {})
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
