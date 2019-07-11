import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

 showChooseImgModalSheet(BuildContext context, ValueChanged<File> valueChanged ) async {
  showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.photo_camera),
                title: new Text("相机"),
                onTap: () async {
                  Navigator.of(context).pop();
                  File file = await ImagePicker.pickImage(source: ImageSource.camera);
                  valueChanged(file);
                },
              ),
              Divider(),
              ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text("相册"),
                onTap: () async {
                  Navigator.of(context).pop();
                  File file = await ImagePicker.pickImage(source: ImageSource.gallery);
                  valueChanged(file);
                },
              ),
              Divider(),
              ListTile(
                leading: new Icon(Icons.cancel),
                title: new Text("取消"),
                onTap: () async {
                  Navigator.of(context).pop();
                  valueChanged(null);
                },
              ),
              Divider(),
            ],
          );
        });
} 