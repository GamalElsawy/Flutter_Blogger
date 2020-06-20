import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class createBlog extends StatefulWidget {
  @override
  _createBlogState createState() => _createBlogState();
}

class _createBlogState extends State<createBlog> {
  String _title = "", _description = "";
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
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
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.file_upload))
        ],
      ),
      body: SingleChildScrollView(
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
                      child: Image.file(_image),
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
            /*Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4,
              child: Icon(Icons.add_a_photo,color: Colors.black54,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),

            ),*/
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
