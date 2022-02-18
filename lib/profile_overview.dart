import 'package:flutter/material.dart';
import 'package:petch/firebase.dart';
import 'package:petch/widget/profile_widget.dart';
import 'package:provider/provider.dart';

class ProfileList extends StatefulWidget {
  ProfileList({Key? key}) : super(key: key);

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ApplicationState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profilübersicht"),
      ),
      body: ListView(
        children: [
          for (var profile in provider.allProfiles)
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              height: 125,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    child: Row(
                      children: [
                        ClipOval(
                          child: Material(
                            color: Colors.transparent,
                            child: Ink.image(
                              image: NetworkImage(provider.profilePicURL!),
                              fit: BoxFit.cover,
                              width: 75,
                              height: 75,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  profile.name,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  profile.gender,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Spacer(),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Expanded(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "Interessiert an:",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  profile.intrests,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
