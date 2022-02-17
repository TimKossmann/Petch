import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petch/model/user.dart';
import 'package:petch/utils/user_preferences.dart';
import 'package:petch/widget/appbar_widget.dart';
import 'package:petch/widget/button_widget.dart';
import 'package:petch/widget/numbers_widget.dart';
import 'package:petch/widget/profile_widget.dart';
import 'package:petch/widget/profile_editable_widget.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePageEditable extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageEditable> {
  String dropdownValue = 'male';
  File? image;

  Future pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemporary = File(image.path);
    this.image = imageTemporary;
  }

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileEditableWidget(
            imagePath: user.imagePath,
            onClicked: () => pickImage(),
          ),
          const SizedBox(height: 24),
          buildEditName(user),
          const SizedBox(height: 24),
          Row(children: [
            Container(
                child: const Icon(Icons.arrow_downward),
                padding: EdgeInsets.only(right: 18)),
            DropdownButton<String>(
              value: dropdownValue,
              elevation: 16,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
              underline: Container(
                height: 1,
                color: Colors.grey,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['male', 'female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ]),
          const SizedBox(height: 24),
          buildEditInterest(user),
        ],
      ),
    );
  }

  Widget buildEditName(User user) => Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Edit Name',
              ),
              initialValue: user.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      );

  Widget buildEditInterest(User user) => Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.donut_large),
                labelText: 'Edit Interests',
              ),
              initialValue: user.about,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      );
}
