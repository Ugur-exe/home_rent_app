import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:home_rent/utils/color.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:toastification/toastification.dart';

class ProfileViewer extends StatefulWidget {
  const ProfileViewer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileViewerState createState() => _ProfileViewerState();
}

class _ProfileViewerState extends State<ProfileViewer> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String _firstName = "";
  String _lastName = "";
  String _profileImageUrl = "";

  Future<void> _fetchProfileData() async {
    CollectionReference profiles =
        FirebaseFirestore.instance.collection('users');
    String userId = FirebaseAuth.instance.currentUser!.uid;
    try {
      DocumentSnapshot userDocument =
          await profiles.doc(userId).get();
      Map<String, dynamic> documentData =
          userDocument.data() as Map<String, dynamic>;
      setState(() {
        _firstName = documentData['name'] ?? "";
        _lastName = documentData['last_name'] ?? "";
        _profileImageUrl = documentData['image'] ?? "";
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _uploadProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      Reference storageReference =
          FirebaseStorage.instance.ref().child(pickedFile.path.split('/').last);
      storageReference.putFile(File(pickedFile.path));
      String imageUrl = await storageReference.getDownloadURL();
      setState(() {
        _profileImageUrl = imageUrl;
      });
    }
  }

  Future<void> _saveProfileData() async {
    _fetchProfileData();
    CollectionReference profiles =
        FirebaseFirestore.instance.collection('users');
    String userId = FirebaseAuth.instance.currentUser!.uid;
    await profiles
        .doc(userId)
        .update({
      'name': _firstNameController.text,
      'lastName': _lastNameController.text,
      'image': _profileImageUrl,
    });
    toastification.show(
      context: context,
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 3),
      icon: const Icon(Icons.check),
      title: const Text('Success'),
      description: const Text.rich(
        TextSpan(
          text: 'You changed your profile',
        ),
      ),
    );
  }

  _ProfileViewerState() {
    _fetchProfileData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          Positioned(
            top: 0.0,
            child: Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: AppColors.primaryColor,
                          )),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    const Text(
                      'Edit Your Profile',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 130,
            right: 30,
            left: 30,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 150,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: Image.network(_profileImageUrl).image ?? Image.asset('assets/user.png').image,
                        ),
                        borderRadius: BorderRadius.circular(15)),
                    child: InkWell(
                      onTap: _uploadProfileImage,
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Name: $_firstName',
                          style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Surname: $_lastName',
                          style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: 15,
            right: 15,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(labelText: 'Lastname'),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _saveProfileData,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
