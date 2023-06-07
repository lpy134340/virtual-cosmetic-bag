import 'package:beauty_habit_tracker/user_related/reset_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_info_update.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

final ref_firebase = FirebaseFirestore.instance;

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String _firstName = '';
  String _lastName = '';
  int _age = 0;
  String _skinType = '';
  String _userImage =
      "https://firebasestorage.googleapis.com/v0/b/beauty-habit-tracker.appspot.com/o/user_images%2Fuser_placeholder.png?alt=media&token=fb81ac01-1511-4198-9e37-0abb82c09738";
  String uid = FirebaseAuth.instance.currentUser!.uid;
  final List<bool> _selectedSkinTypes = <bool>[false, false, false];

  static const List<Widget> skinTypes = <Widget>[
    Text('Dry'),
    Text('Mixed'),
    Text('Oily')
  ];

  @override
  void initState() {
    super.initState();
    getData();
  }

  uploadImage() async {
    try {
      final firebaseStorage = FirebaseStorage.instance;
      final imagePicker = ImagePicker();
      PickedFile? image;
      //Check Permissions
      await Permission.photos.request();

      var permissionStatus = await Permission.photos.status;

      if (permissionStatus.isGranted) {
        //Select Image
        // ignore: deprecated_member_use
        image = await imagePicker.getImage(source: ImageSource.gallery);
        var file = File(image!.path);

        // ignore: unnecessary_null_comparison
        if (image != null) {
          //Upload to Firebase
          var snapshot = await firebaseStorage
              .ref()
              .child('user_images/userImage$_firstName')
              .putFile(file);
          var downloadUrl = await snapshot.ref.getDownloadURL();
          await FirebaseFirestore.instance
              .collection('/users')
              .doc(uid)
              .update({"image": downloadUrl});
          setState(() {
            _userImage = downloadUrl;
          });
        } else {
          print('No Image Path Received');
        }
      } else {
        print('Permission not granted. Try Again with permission access');
      }
    } catch (e) {
      return Error();
    }
  }

  Future getData() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data()! as Map<String, dynamic>;
          setState(() {
            _firstName = data['firstName'];
            _lastName = data['lastName'];
            _age = data['age'];
            _skinType = data['skinType'];
            _userImage = data['image'];
            if (_userImage == "") {
              setState(() {
                _userImage =
                    "https://firebasestorage.googleapis.com/v0/b/beauty-habit-tracker.appspot.com/o/user_images%2Fuser_placeholder.png?alt=media&token=fb81ac01-1511-4198-9e37-0abb82c09738";
              });
            }
            for (int buttonIndex = 0;
                buttonIndex < skinTypes.length;
                buttonIndex++) {
              if (_skinType == 'Dry') {
                _selectedSkinTypes[0] = true;
              } else if (_skinType == 'Mixed') {
                _selectedSkinTypes[1] = true;
              } else {
                _selectedSkinTypes[2] = true;
              }
            }
          });
        } else {
          print('Document does not exist on the database');
        }
      });
    } catch (e) {
      Error();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        semanticsLabel: "First Name",
                        'First name',
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 0.9, color: Colors.grey),
                      ),
                      Text(
                        semanticsLabel: _firstName,
                        _firstName,
                        textAlign: TextAlign.center,
                        style: DefaultTextStyle.of(context).style.apply(
                              fontSizeFactor: 2.0,
                            ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        semanticsLabel: "Last Name",
                        'Last name',
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 0.9, color: Colors.grey),
                      ),
                      Text(
                        semanticsLabel: _lastName,
                        _lastName,
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 2.0),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        semanticsLabel: "Age",
                        'Age',
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 0.9, color: Colors.grey),
                      ),
                      Text(
                        semanticsLabel: _age.toString(),
                        _age.toString(),
                        style: DefaultTextStyle.of(context)
                            .style
                            .apply(fontSizeFactor: 2.0),
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        ElevatedButton(
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ResetPassword()))
                          },
                          child: const Text(
                              semanticsLabel: "Reset Password",
                              "Reset Password"),
                        )
                      ]),
                    ])),
                IconButton(
                  icon: const Icon(Icons.edit),
                  tooltip: 'Edit Details',
                  onPressed: () async {
                    final data = await showDialog<bool>(
                      context: context,
                      builder: (_) {
                        return const AlertDialog(
                          scrollable: true,
                          title: Text(
                              semanticsLabel: 'Press to Update User Profile',
                              'Update User Profile'),
                          content: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: UserInfoUpdateForm()),
                        );
                      },
                    );
                    if (data!) {
                      getData();
                    }
                  },
                ),
                CircleAvatar(
                    radius: 60, backgroundImage: (NetworkImage(_userImage))),
                IconButton(
                    onPressed: () {
                      uploadImage();
                    },
                    icon: const Icon(Icons.upload))
              ]),
          Center(
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.only(top: 35),
                  child: const Text(
                    semanticsLabel: 'Skin Type',
                    'Skin Type',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    textAlign: TextAlign.start,
                    textScaleFactor: 1.0,
                  )),
              Container(
                margin: const EdgeInsets.only(top: 15),
                height: 50,
                width: 200,
                alignment: Alignment.center,
                child: ToggleButtons(
                  onPressed: (int index) {},
                  isSelected: _selectedSkinTypes,
                  children: skinTypes,
                ),
              ),
            ]),
          )
        ]));
  }
}
