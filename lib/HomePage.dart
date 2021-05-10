import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_detection/LiveCamera.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;
  File _image;
  final imagePicker = ImagePicker();
  List _predictions = [];

  Future loadImageGallery() async {
    final image = await imagePicker.getImage(source: ImageSource.gallery);
    detectImage(image);
  }

  Future loadImageCamera() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    detectImage(image);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel();
  }

  loadModel() async{
    Tflite.close();
    await Tflite.loadModel(model: 'assets/model_unquant.tflite', labels: 'assets/labels.txt');
  }

 Future detectImage(image) async {
    var prediction = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      if (image != null) {
        _image = File(image.path);
        _predictions = prediction;
      } else {
        print('No image selected.');
      }
    });
    // setState(() {
    //   _loading = false;
    //   _predictions = prediction;
    // });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mask Detection',
        style: GoogleFonts.robotoCondensed(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _loading == false ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 280,
                      width: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.file(_image)),
                    ),
                    SizedBox(height: 10),

                    Text(_predictions[0]['label'].toString().substring(2),
                      style: GoogleFonts.robotoCondensed(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    // Text('Safer: '+"${(_predictions[0]['confidence']*100).toString()}%"),
                  ],
                ),
              ),
            ):Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 300,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey,
                ),
                child: Center(child: Text('Image Appears here')),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LiveCamera()));
                  },
                  child: Text('Live Camera'),
                  color: Color(0xff01AEBC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                    onPressed: (){
                      loadImageCamera();
                    },
                child: Text('Capture Image'),
                  color: Color(0xff01AEBC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  onPressed: (){
                    loadImageGallery();
                  },
                  child: Text('Pick Image from Gallery'),
                  color: Color(0xff01AEBC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
