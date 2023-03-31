import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class courseService extends ChangeNotifier{
  static late FirebaseAuth? _auth;
  static late FirebaseFirestore? _firestore;
  static late CollectionReference coursesRef;
  static Map<String,dynamic> infoTeacher = {'name' : 'Dr Merghemi Lazhar' , 'urlPhoto' : 'https://yt3.googleusercontent.com/kXlzq8us1bcqW1sOyuFyN8XQ_iSOhpWhC0DSJnrn8807EGi_05Tq-rdj5zm8W_cxvlTwvDlHRg=s176-c-k-c0x00ffffff-no-rj'};
  static bool init = false;
  static List<Map<String,dynamic>> allCourseList = [];


  courseService(){
    if (!init) {
      _auth = FirebaseAuth.instance;
      _firestore = FirebaseFirestore.instance;
      coursesRef = FirebaseFirestore.instance.collection('courses');
      init = true;
    }
  }

  Future<List<Map<String,dynamic>>> getAllCourse() async{
    infoTeacher = await getTeacherInfo();
    List<Map<String,dynamic>> courseList = [];
    await coursesRef.get().then(
            (value){
          value.docs.forEach((element) {
            Map<String, dynamic> data = element.data() as Map<String, dynamic>;
            courseList.add(data);
          });
        }
    );
    courseService.allCourseList = courseList;
    notifyListeners();
    return courseList;
  }


  
  Future<Map<String,dynamic>> getTeacherInfo() async{
    Map<String,dynamic> data = {};
    final response = await http.get(Uri.parse('https://medcourse.s3.ir-thr-at1.arvanstorage.ir/info.json'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
    } else {
    }
    return data;
  }

  Future<List<String>> getHowPayMethode1() async{
   List< dynamic> data =[];
   List<String> urlPhotos = [];
    final response = await http.get(Uri.parse('https://medcourse.s3.ir-thr-at1.arvanstorage.ir/method.json'));
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      urlPhotos = data.map((map) => map['urlPhoto'] as String).toList();
    } else {
    }
    return urlPhotos;
  }

}