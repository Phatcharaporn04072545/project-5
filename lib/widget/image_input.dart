import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';



class ImageInput extends StatefulWidget {
  final Function imagesaveat;
  ImageInput(this.imagesaveat);
  

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;

  
Future<void> _takePicture() async {
    final picker=ImagePicker();
    final imageFile=await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });

    final appDir = await getApplicationDocumentsDirectory();
    final fileName=path.basename(imageFile.path);
    final saveImagePath=await _imageFile!.copy('${appDir.path}/$fileName');

    widget.imagesaveat(saveImagePath);
  }

  

  Future<void> _galleryPicture() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 600,
    );
    if (imageFile == null) {
      return;
    }
    setState(() {
      _imageFile = File(imageFile.path);
    });

    final appDir = await getApplicationDocumentsDirectory();
    final fileName=path.basename(imageFile.path);
    final saveImagePath=await _imageFile!.copy('${appDir.path}/$fileName');

    widget.imagesaveat(saveImagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.black12),
            ),
            child: _imageFile != null
                ? Image.file(
                    _imageFile!,
                    fit: BoxFit.cover,
                  )
                : Center(child: Text("No Image")),
          ),
          TextButton.icon(
            onPressed: _galleryPicture,
            icon: Icon(Icons.image),
            label: Text('เพิ่มรูปภาพ'),
          ),
          TextButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera),
            label: Text('เพิ่มภาพถ่าย'),
          ),
        ],
      ),
    );
  }
}
