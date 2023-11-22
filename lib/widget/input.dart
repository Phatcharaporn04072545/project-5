import 'dart:io';
import 'package:crud1/models/classes.dart';
import 'package:crud1/widget/image_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InputScreen extends StatefulWidget {
  static const routeName="";

  @override
  State<InputScreen> createState() => _InputState();
}

class _InputState extends State<InputScreen> {
  final _titleController=TextEditingController();

  File? savedImage;



 void savedImages(File image) {
  if (image != null) {
    savedImage = image;
  }
}

  void onsave(){
    if (_titleController.text.isEmpty|| savedImage==null){
      return;
   } else {
      Provider.of<ImageFile>(context, listen: false).addImagePlace(
  _titleController.text, savedImage!,
);
      Navigator.pop(context);    
     
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("สร้างข้อมูล"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "ข้อความ"
                ),
              ),
              SizedBox(height: 50),
              ImageInput(savedImages),
              SizedBox(height: 30),
             ElevatedButton( 
                onPressed: onsave,
                child: Text('บันทึก'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}