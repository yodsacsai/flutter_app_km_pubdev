import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CamGalUI extends StatefulWidget {
  const CamGalUI({Key? key}) : super(key: key);

  @override
  _CamGalUIState createState() => _CamGalUIState();
}

class _CamGalUIState extends State<CamGalUI> {
  //ตัวแปรเก็บรูปที่ได้จากการเลือก
  File? imageSelected;


  //เมธอดเปิดกล้อง
  Future selectImgFromCamnera()async{
    final imageSelect = await ImagePicker().pickImage(
      source: ImageSource.camera
    );
    //ตรวจสอบ
    if( imageSelect == null){
      return;
    }
    //กรณีเลือกรูป ให้กำหนดให้กับตัวแปรที่สร้างไว้ข้างบน
    final imageSelectPath = File(imageSelect.path);
    setState(() {
      imageSelected = imageSelectPath;
    });
  }
  //เมธอดเปิดแกลอรี่
  Future selectImgFromGallery()async{
    final imageSelect = await ImagePicker().pickImage(
      source: ImageSource.gallery
    );
    //ตรวจสอบ
    if( imageSelect == null){
      return;
    }
    //กรณีเลือกรูป ให้กำหนดให้กับตัวแปรที่สร้างไว้ข้างบน
    final imageSelectPath = File(imageSelect.path);
    setState(() {
      imageSelected = imageSelectPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text(
          'CamGal KM',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.red,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    90,
                  ),
                  child:
                  imageSelected == null
                  ?
                  Image.asset(
                    'assets/images/logo.png',
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  )
                  :
                  Image.file(
                    File(imageSelected!.path),
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: (){
                      selectImgFromCamnera();
                    },
                    icon: Icon(
                      Icons.camera_alt_outlined,
                    ),
                    label: Text(
                      'Camera',
                    ),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  ElevatedButton.icon(
                    onPressed: (){
                      selectImgFromGallery();
                    },
                    icon: Icon(
                      Icons.picture_in_picture_alt_sharp,
                    ),
                    label: Text(
                      'Gallery',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
