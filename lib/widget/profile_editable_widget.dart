import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petch/firebase.dart';
import 'package:provider/provider.dart';

class ProfileEditableWidget extends StatefulWidget {
  ProfileEditableWidget({Key? key}) : super(key: key);

  @override
  State<ProfileEditableWidget> createState() => _ProfileEditableWidgetState();
}

class _ProfileEditableWidgetState extends State<ProfileEditableWidget> {
  File? image;

  Future pickImage(ApplicationState provider) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    provider.image = File(image.path);
    setState(() {
      this.image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final provider = Provider.of<ApplicationState>(context);

    return Center(
      child: GestureDetector(
        onTap: () => pickImage(provider),
        child: Stack(
          children: [
            buildImage(),
            Positioned(
              bottom: 0,
              right: 4,
              child: buildEditIcon(color),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildImage() {
    return Material(
        color: Colors.transparent,
        child: image != null
            ? SizedBox(
                child: Image.file(image!),
                width: 125,
                height: 125,
              )
            : const SizedBox(
                width: 125,
                height: 125,
              ));
  }

  Widget buildEditIcon(Color color) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            image != null ? Icons.edit : Icons.camera_alt,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
