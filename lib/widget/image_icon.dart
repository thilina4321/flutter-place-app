import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sys;

class CustomImg extends StatefulWidget {
  final Function pickedImage;
  CustomImg(this.pickedImage);

  @override
  _CustomImgState createState() => _CustomImgState();
}

class _CustomImgState extends State<CustomImg> {
  File _storeImage;
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 1000,
    );

    if (pickFile == null) {
      return;
    }

    final appDir = await sys.getApplicationDocumentsDirectory();
    final filename = path.basename(pickFile.path);
    final saveImage =
        await File(pickFile.path).copy('${appDir.path}/$filename');

    setState(() {
      _storeImage = saveImage;
    });
    print('kalin' + pickFile.path);
    // print('den' + saveImage.path);

    widget.pickedImage(_storeImage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              height: 100,
              width: double.infinity,
              child: _storeImage != null
                  ? Container(
                      width: double.infinity,
                      child: Image.file(
                        _storeImage,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Text(
                      'Add a image',
                      textAlign: TextAlign.center,
                    ),
              decoration: BoxDecoration(border: Border.all(width: 2)),
            ),
          ),
          Expanded(
            child: FlatButton.icon(
              onPressed: getImage,
              icon: Icon(Icons.camera),
              label: FittedBox(
                child: Container(width: 100, child: Text('Take Pictures')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
