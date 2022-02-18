import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // new
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'firebase_options.dart'; // new
import 'src/authentication.dart'; // new
import 'src/widgets.dart'; // new

class Profile {
  Profile({
    required this.name,
    required this.intrests,
    required this.gender,
    required this.userId,
  });
  late String name;
  late String userId;
  late String intrests;
  late String profilePicId;
  late String gender;

  Profile.fromJson(Map json) {
    this.name = json['name'];
    this.userId = json['userId'];
    this.intrests = json['intrests'];
    this.gender = json["gender"];
  }
}

class ApplicationState extends ChangeNotifier {
  StreamSubscription<QuerySnapshot>? _userProfileSubscription;
  Profile? profile;
  String? _profilePicURL;
  String? get profilePicURL => _profilePicURL;
  File? image;
  List<Profile> _allProfiles = [];
  List<Profile> get allProfiles => _allProfiles;

  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance.userChanges().listen((user) async {
      if (user != null) {
        await loadProfile();
        /*
          for (final document in snapshot.docs) {
            
              Profile(
                name: document.data()['name'] as String,
                intrests: document.data()['intrests'] as String,
                profilePicId: document.data()['profilePicId'] as String,
                gender: document.data()['gender'] as String,
                userId: document.data()['userId'] as String,
              ),
            );
          }
          print("#################");
          print(_users[0].name);
          print("#################");
          */
        notifyListeners();
      } else {
        _loginState = ApplicationLoginState.emailAddress;
        profile = null;
        _userProfileSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.emailAddress;
  ApplicationLoginState get loginState => _loginState;

  String? _email;
  String? get email => _email;

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> loadProfile() async {
    _loginState = ApplicationLoginState.loggedIn;
    final CollectionReference profileConnection =
        FirebaseFirestore.instance.collection('User');
    //.orderBy('timestamp', descending: true)

    profileConnection.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        try {
          _allProfiles.add(Profile(
              name: doc["name"],
              intrests: doc["intrests"],
              gender: doc["gender"],
              userId: doc["userId"]));
        } catch (e) {
          print("NO USERID");
        }
      });
      print(_allProfiles.length);
    });

    Query profileQuery = profileConnection.where("userId",
        isEqualTo: FirebaseAuth.instance.currentUser!.uid);
    QuerySnapshot snapshot = await profileQuery.get();
    if (snapshot.docs.length >= 1) {
      var data = snapshot.docs[0];
      profile = Profile(
          name: data.get("name"),
          intrests: data.get("intrests"),
          gender: data.get("gender"),
          userId: data.get("userId"));
      _profilePicURL = await downloadProfilePicURL();
    } else {
      _loginState = ApplicationLoginState.createProfile;
      profile = Profile(name: "", intrests: "", gender: "Männlich", userId: "");
    }
    notifyListeners();
  }

  Future<void> verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> registerAccount(
      String email,
      String displayName,
      String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> addUser() async {
    if (_loginState != ApplicationLoginState.createProfile) {
      throw Exception('Must be logged in');
    }
    if (profile == null) {
      return;
    }

    _loginState = ApplicationLoginState.loggedIn;
    if (image != null) {
      await uploadImageToFirebase(image!);
    }

    FirebaseFirestore.instance.collection('User').add(<String, dynamic>{
      'name': profile!.name,
      'intrests': profile!.intrests,
      'gender': profile!.gender,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
    loadProfile();
  }

  Future uploadImageToFirebase(File _imageFile) async {
    String fileName = FirebaseAuth.instance.currentUser!.uid;

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('profilePics/$fileName.png')
          .putFile(_imageFile);
    } catch (e) {
      // e.g, e.code == 'canceled'
    }
  }

  Future<String> downloadProfilePicURL() async {
    String fileName = FirebaseAuth.instance.currentUser!.uid;
    String downloadURL = "";
    try {
      downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref('profilePics/$fileName.png')
          .getDownloadURL();
    } catch (e) {
      print("NO PROFILE PIC");
    }
    return downloadURL;
    // Within your widgets:
    // Image.network(downloadURL);
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
