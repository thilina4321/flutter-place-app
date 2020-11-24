import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gtplace/provider/place_provider.dart';
import 'package:gtplace/widget/image_icon.dart';
import 'package:provider/provider.dart';

class AddPlaceScreen extends StatefulWidget {
  static String routeName = '/add-place';
  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final titleController = TextEditingController();
  File _pickedImage;
  getImage(pickedImage) {
    _pickedImage = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place'),
      ),
      body: Column(
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                  ),
                ),
                CustomImg(getImage),
              ],
            ),
          )),
          Container(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                Provider.of<PlaceProvider>(context, listen: false)
                    .addPlace(titleController.text, _pickedImage);
                Navigator.of(context).pop();
              },
              color: Colors.lightBlue,
              child: Text(
                'Add Place',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
