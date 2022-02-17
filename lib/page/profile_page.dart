import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petch/model/user.dart';
import 'package:petch/utils/user_preferences.dart';
import 'package:petch/widget/appbar_widget.dart';
import 'package:petch/widget/button_widget.dart';
import 'package:petch/widget/numbers_widget.dart';
import 'package:petch/widget/profile_widget.dart';
import 'package:petch/page/profile_page_editable.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePageEditable()),
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 48),
          buildInterest(user),
          const SizedBox(height: 24),
          buildGender(user)
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To PRO',
        onClicked: () {},
      );

  Widget buildInterest(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Interests',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildGender(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gender',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.gender,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
