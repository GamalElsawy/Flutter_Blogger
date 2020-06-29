import 'package:blogger/screens/CreateBlog.dart';
import 'package:blogger/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods cm = new CrudMethods();
  QuerySnapshot blogsSnapShot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cm.getData().then((result) {
      setState(() {
        blogsSnapShot = result;
      });
    });
  }

  Widget blogsList() {
    return blogsSnapShot != null
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: blogsSnapShot.documents.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return BlogTile(
                  imageURL: blogsSnapShot.documents[index].data['imageURL'],
                  title: blogsSnapShot.documents[index].data['title'],
                  desc: blogsSnapShot.documents[index].data['desc']);
            })
        : Container(
            child: CircularProgressIndicator(),
            alignment: Alignment.center,
          );
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
          )),
      body: blogsList(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => createBlog()));
            },
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String imageURL, title, desc;
  BlogTile(
      {@required this.imageURL, @required this.title, @required this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Card(
        color: Colors.transparent,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Center(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        imageURL,
                      ))),
            ),
            Center(
              child: Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Container(
                padding: EdgeInsets.all(8),
                child: Text(desc,
                    style:
                        TextStyle(fontSize: 20, fontStyle: FontStyle.italic))),
          ],
        ),
      ),
    );
  }
}
