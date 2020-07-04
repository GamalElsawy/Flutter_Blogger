import 'package:blogger/screens/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:blogger/services/crud.dart';
import 'dart:io';
import 'package:blogger/screens/HomePage.dart';
import 'package:random_string/random_string.dart';

class createBlog extends StatefulWidget {
  @override
  _createBlogState createState() => _createBlogState();
}

class _createBlogState extends State<createBlog> {
  String _title = "", _description = "";
  File _image;
  final picker = ImagePicker();
  CrudMethods cm = new CrudMethods();
  bool _isLoading = false;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  uploadBlog() async {
    if (_image != null) {
      setState(() {
        _isLoading = true;
      });
      StorageReference fsr = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");
      final StorageUploadTask task = fsr.putFile(_image);
      var downloadURL = await (await task.onComplete).ref.getDownloadURL();
      print("Image URL is $downloadURL");
      Map<String, String> blogMap = {
        "imageURL": downloadURL,
        "title": _title,
        "desc": _description
      };
      cm.addData(blogMap).then((value) {
        BlogTile template = new BlogTile(
            imageURL: downloadURL, title: _title, desc: _description);
        Navigator.pop(context, template);
      });
    } else {
      // To Allow Posting Without Image .. Soon
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        //centerTitle:  true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Blog", style: TextStyle(fontSize: 22)),
            Text("ger", style: TextStyle(fontSize: 22, color: Colors.blue)),
          ],
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.file_upload)),
          )
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: _image != null
                        ? Container(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                )),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 4,
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 4,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.black54,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: TextField(
                      decoration: InputDecoration(hintText: "Title"),
                      onChanged: (input) {
                        _title = input;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: TextField(
                      maxLines: 6,
                      decoration: InputDecoration(hintText: "Description"),
                      onChanged: (input) {
                        _description = input;
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
