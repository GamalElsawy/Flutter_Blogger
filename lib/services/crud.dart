import 'package:cloud_firestore/cloud_firestore.dart';

class CrudMethods{

  Future<void> addData(newBlog)async{
    Firestore.instance.collection("blogs").add(newBlog).catchError((err){
      print(err);

    });

  }
}