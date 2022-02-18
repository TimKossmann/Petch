import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petch/firebase.dart';
import 'package:petch/model/user.dart';
import 'package:petch/utils/user_preferences.dart';
import 'package:petch/widget/appbar_widget.dart';
import 'package:petch/widget/button_widget.dart';
import 'package:petch/widget/numbers_widget.dart';
import 'package:petch/widget/profile_widget.dart';
import 'package:petch/widget/profile_editable_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePageEditable extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageEditable> {
  String dropdownValue = 'Männlich';

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    final provider = Provider.of<ApplicationState>(context);

    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileEditableWidget(),
          const SizedBox(height: 24),
          buildEditName(provider.profile!),
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
                if (newValue != null) {
                  provider.profile!.gender = newValue;
                }
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>['Männlich', 'Weiblich']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ]),
          const SizedBox(height: 24),
          buildEditInterest(provider.profile!),
          ElevatedButton(
            onPressed: () async {
              print("#################");
              print(provider.profile!.toString());
              await provider.addUser();
              await provider.loadProfile();
            },
            child: const Text('Profil Anlegen'),
          ),
        ],
      ),
    );
  }

  Widget buildEditName(Profile user) => Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                labelText: 'Namen eingeben',
              ),
              onChanged: (value) {
                user.name = value;
              },
              initialValue: user.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      );

  Widget buildEditInterest(Profile user) => Column(
        children: [
          TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.donut_large),
                labelText: 'Beschreibe deine Interessen',
              ),
              onChanged: (value) {
                user.intrests = value;
              },
              initialValue: user.intrests,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      );
}
