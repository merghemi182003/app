import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AppSettings extends ChangeNotifier{
  static bool dark = true;
  static bool passwordVisible = true;
  static int sec = 30;
  static int index = 0;
  int selectAwesomeCourse = 0;
  List<Map<String,dynamic>> wishList = [];

  void setTime(){
    sec--;
    notifyListeners();
  }

  void setDark() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dark = !dark;
    prefs.setBool('dark', dark);
    notifyListeners();
  }

  void setPaaswordVisibelity(){
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void setIndex(int i){
    index = i;
    notifyListeners();
  }

  void setSelectButtonHome(int s){
    selectAwesomeCourse = s;
    notifyListeners();
  }

  void setWishList(Map<String,dynamic> course){
    wishList.add(course);
    notifyListeners();
  }


  bool getDark() => dark;

  int getSelectButtonHome() => selectAwesomeCourse;

  bool getPaaswordVisibelity() => passwordVisible;

  int getIndex() => index;

  int getTime() => sec;

}