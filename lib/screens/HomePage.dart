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
  BlogTile blog;
  List<BlogTile> listOfBlogs = new List<BlogTile>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cm.getData().then((result) {
      setState(() {
        blogsSnapShot = result;
        if (blogsSnapShot != null) {
          for (int i = 0; i < blogsSnapShot.documents.length; i++) {
            blog = new BlogTile(
                imageURL: blogsSnapShot.documents[i].data['imageURL'],
                title: blogsSnapShot.documents[i].data['title'],
                desc: blogsSnapShot.documents[i].data['desc']);

            listOfBlogs.add(blog);
          }
        }
      });
    });
  }

  Widget blogsList() {
    return listOfBlogs != null
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: listOfBlogs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return listOfBlogs[index];
            })
        : listOfBlogs.length == 0
            ? Center(
                child: Expanded(
                    child: Text(
                  "Feed is Empty",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              )
            : Container(
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              );
  }

  @override
  Widget build(BuildContext context) {
    _navigateAndDisplaySelection(BuildContext context) async {
      final newBlog = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => createBlog()));
      if (newBlog != null) {
        setState(() {
          listOfBlogs.add(newBlog);
        });
      }
    }

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
              _navigateAndDisplaySelection(context);
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
