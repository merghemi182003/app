import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class boardService extends ChangeNotifier{
  static late FirebaseAuth auth;
  static late FirebaseFirestore _firestore;
  static late CollectionReference boardRef;
  static firebase_storage.Reference? ref;
  static bool init = false;
  static List<Map<String,dynamic>> borads = [];
  boardService(){
    if (!init) {
      auth = FirebaseAuth.instance;
      _firestore = FirebaseFirestore.instance;
      boardRef = FirebaseFirestore.instance.collection('board');
      init = true;
    }
  }

  Future<List<Map<String,dynamic>>> getBoards()async{
    List<Map<String,dynamic>> boardList = [];
    await boardRef.orderBy('time',descending: true).get().then(
            (value){
          for (var element in value.docs) {
            Map<String, dynamic> data = element.data()as Map<String, dynamic>;
            boardList.add(data);
          }
        }
    );
    boardService.borads = boardList;
    notifyListeners();
    return boardList;
  }
}

class BoardInfo{
  String? text;
  List<String>? images;
  List<String>?  links;
  BoardInfo({required this.images,required this.links,required this.text});
}