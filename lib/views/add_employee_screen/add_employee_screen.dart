import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final cUid = FirebaseAuth.instance.currentUser?.uid;
  File? imageFile;
  String imageUrl = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('employees').add({
            "name": "e4",
            "des": "iuytrfghjk",
            "ph": "8765435678",
            "img": imageUrl,
          });
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            InkWell(
              onTap: () async {
                // write the logic to pick and img and upload it to firebase

                final picker = ImagePicker();
                final pickedImage = await picker.pickImage(
                  source: ImageSource.camera,
                );

                if (pickedImage != null) {
                  imageFile = File(pickedImage.path);
                  setState(() {});

                  Reference ref = FirebaseStorage.instance
                      .ref()
                      .child('Employee')
                      .child('/$cUid.jpg');

                  await ref.putFile(imageFile!);
                  imageUrl = await ref.getDownloadURL();
                }
              },
              child: CircleAvatar(
                radius: 80,

                backgroundImage:
                    imageFile != null ? FileImage(imageFile!) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
