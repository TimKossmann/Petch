import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petch/firebase.dart';
import 'package:petch/model/user.dart';
import 'package:petch/utils/user_preferences.dart';
import 'package:petch/widget/appbar_widget.dart';
import 'package:petch/widget/button_widget.dart';
import 'package:petch/widget/numbers_widget.dart';
import 'package:petch/widget/profile_widget.dart';
import 'package:petch/page/profile_page_editable.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApplicationState>(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: provider.profilePicURL!,
            onClicked: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePageEditable()),
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(provider.profile!),
          const SizedBox(height: 48),
          buildInterest(provider.profile!),
          const SizedBox(height: 24),
          buildGender(provider.profile!)
        ],
      ),
    );
  }

  Widget buildName(Profile user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.gender,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildInterest(Profile user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interessen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.intrests,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildGender(Profile user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Geschlecht',
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
