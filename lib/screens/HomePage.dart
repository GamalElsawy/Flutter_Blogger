import 'package:blogger/screens/CreateBlog.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Container(),
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
