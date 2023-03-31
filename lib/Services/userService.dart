import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:email_otp/email_otp.dart';
import 'package:medcourse/Services/courseService.dart';
import 'package:medcourse/Widgets/Dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'boardService.dart';
class userService extends ChangeNotifier {
  static late FirebaseAuth auth;
  static late FirebaseFirestore _firestore;
  static late CollectionReference usersRef;
  static late CollectionReference payRef;
  static firebase_storage.Reference? ref;
  static GoogleSignIn googleSignIn = GoogleSignIn();
  static GoogleSignInAccount? googleUser;
  static EmailOTP emailOTP = EmailOTP();
  static bool init = false;
  static userInfo user = userInfo();
  static bool enrolled = false;
  static bool firstOpenApp = false;




  userService() {
    if (!init) {
      auth = FirebaseAuth.instance;
      _firestore = FirebaseFirestore.instance;
      user.uid = auth.currentUser?.uid;
      user.email = auth.currentUser?.email;
      usersRef = FirebaseFirestore.instance.collection('users');
      payRef = FirebaseFirestore.instance.collection('payment');

      init = true;
    }
  }

  Future<bool> signInWithEmailPassword(
      String email, String password, BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      userService.user.uid = auth.currentUser?.uid;
      userService.user.email = auth.currentUser?.email;
      return true;
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        dialog(context, 'User not found');
      } else if (e.code == 'wrong-password') {
        dialog(context, 'Wrong email or password');
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithGoogle(BuildContext context) async {
    try {
      await signOut();
      googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        return false;
      }
      else if( !(await isUser(googleUser?.email))){
        dialog(context, 'User not found');
        return false;
      }
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      user.user = FirebaseAuth.instance.currentUser;
      userService.user.uid = auth.currentUser?.uid;
      userService.user.email = auth.currentUser?.email;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUpWithGoogle(BuildContext context) async {
    try {
      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      user.user = FirebaseAuth.instance.currentUser;
      userService.user.uid = auth.currentUser?.uid;
      userService.user.email = auth.currentUser?.email;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> selectGoogle(BuildContext context) async {
    try {
      await signOut();
      googleUser = await googleSignIn.signIn();
      if(googleUser!=null) {
        if(await isUser(googleUser!.email)){
          dialog(context, 'Le compte existe déjà pour cet e-mail');
          return false;
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }


  Future<bool> signUpWithEmailPassword(
      String email, String password, BuildContext context) async {
    try {
      final credential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userService.user.uid = auth.currentUser?.uid;
      userService.user.email = auth.currentUser?.email;
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        dialog(context, 'Weak password');
      } else if (e.code == 'email-already-in-use') {
        dialog(context, 'Email already in use');
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await auth.signOut();
      googleUser = await googleSignIn.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> forgetPassword(String email, BuildContext context) async {
    try {
      if (await isUser(email)) {
        await
        auth.sendPasswordResetEmail(email: email);
        dialog(context, 'Veulliez consulter votre boite email');
        return true;
      } else {
        dialog(context, "Email érroné");
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> isUser(String? email) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: email!, password: ';;;;;;;;+.;;;');
      await auth.signOut();
      return true;
    } on FirebaseException catch (e) {

      if (e.code == 'user-not-found') {
        return false;
      } else if (e.code == 'wrong-password') {
        return true;
      }
      return false;
    }catch (e) {
      return false;
    }
  }

  Future<bool> sendOtp(String email) async {
    emailOTP.setConfig(
      appEmail: "me@rohitchouhan.com",
      appName: "Résidanat ALGER Séan",
      userEmail: email,
      otpLength: 4,
      otpType: OTPType.digitsOnly,
    );
    if (await emailOTP.sendOTP() == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> verifyEmail(String otp) async {
    if (await emailOTP.verifyOTP(otp: otp) == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addUserFirestore(
      {required String email,
      required String fullName,
        required String phone,required String lienfb,required String T_NT,required String residence}) async {
    bool suc = false;
   await usersRef
        .doc(userService.user.uid)
        .set({
          'uid': user.uid,
          'fullName': fullName,
          'email': email,
          'subscriptiondate': Timestamp.fromDate(DateTime(1971,01,1)),
          'wishList': [],
          'duration' : '0',
          'phone' : phone,
     'request' : false,
     'lienfb' : lienfb,
     'T/NT' : T_NT,
     'residence' : residence
        })
        .then((value) {
          user = userInfo(uid: user.uid,fullName: fullName,email: email,wishList: [],phone: phone,residence: residence,lienfb: lienfb,T_NT: T_NT,);

      suc = true;
    })
        .catchError((e) {suc = false;});
    notifyListeners();
    return suc;
  }



  Future<userInfo> getUser()async{

    try{
      await usersRef.where('uid', isEqualTo: userService.user.uid.toString()).get().then((value){
        Map<String,dynamic> userInfo =  value.docs.first.data() as Map<String,dynamic>;
        user.fullName = userInfo['fullName'];
        user.email = userInfo['email'];
        user.uid = userInfo['uid'];
        user.wishList = (userInfo['wishList'] as List<dynamic>).cast<String>();
        user.subscription_date = userInfo['subscriptiondate'];
        user.phone = userInfo['phone'];
        user.duration = userInfo['duration'];
        user.request = userInfo['request'];
        user.lienfb = userInfo['lienfb'];
        user.T_NT = userInfo['T/NT'];
        user.residence = userInfo['residence'];

      });
       courseService.infoTeacher = await courseService().getTeacherInfo();
      isEnroll();
      if(enrolled){
        await boardService().getBoards();
      }
    }
    catch(e){
    }
    notifyListeners();
    return user;
  }



  Future<bool> likeAndDislike(
      String uid, bool saved) async {
    try {
      if (saved) {
        await usersRef.doc(userService.user.uid).update({
          "wishList": FieldValue.arrayRemove([uid])
        });

        user.wishList?.remove(uid);
      } else {
        await usersRef.doc(userService.user.uid).update({
          "wishList": FieldValue.arrayUnion([uid])
        });
        user.wishList?.add(uid);
      }
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
  void isEnroll(){
    if(DateTime.now().difference((user.subscription_date?.toDate())!.add(Duration(days: int.parse((user.duration).toString())))).inDays<=0){
      print(DateTime.now().difference((user.subscription_date?.toDate())!.add(Duration(days: int.parse((user.duration).toString())))).inDays);
      enrolled = true;
    }
    else{
      print(DateTime.now().difference((user.subscription_date?.toDate())!.add(Duration(days: int.parse((user.duration).toString())))).inDays);
      enrolled = false;
    }
  }

  Future<bool>updatePassword(BuildContext context,{required String currentPassword,required String newPassword})async{
    try{
      final user = FirebaseAuth.instance.currentUser;
      final AuthCredential credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: currentPassword,
      );
      await auth.currentUser?.reauthenticateWithCredential(credential);
      await auth.currentUser?.updatePassword(newPassword);
      dialog(context, 'Your password has been changed successfully');
    }on FirebaseException catch(e){
      if(e.code == 'weak-password'){
        dialog(context, 'Password should be at least 6 characters');
      }

      else if(e.code == 'wrong-password'){
        dialog(context, 'Wrong password or the user does not have a password');
      }
      else{
        dialog(context, 'Error!!');
      }
      return false;
    }
    catch(e){
      return false;
    }
    return true;
  }

  Future<bool> payMethod_1({required String fullName,required String number,required String pin})async{
    try{
      await payRef.doc(userService.user.uid).set({
        'fullName' : fullName,
        'number' : number,
        'pin' : pin,
        'residence' : userService.user.residence,
        'uid' : userService.user.uid,
        'imageUrl' : '',
        'T/NT' : userService.user.T_NT,
        'lienfb' : userService.user.lienfb,
        'phone' : userService.user.phone
      });
      await usersRef.doc(userService.user.uid).update({
        'request' : true
      });
      await getUser();
      return true;
    }
    catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> payMethod_2({required String fullName,required File image})async{
    try{
      String filename = image.path.split('/').last;
      firebase_storage.Reference storageReference = firebase_storage.FirebaseStorage.instance.ref().child('payment').child('${user.uid}/$filename');
      firebase_storage.UploadTask uploadTask = storageReference.putFile(image);
      firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
        await payRef.doc(userService.user.uid).set({
          'fullName' : fullName,
          'number' : '',
          'pin' : '',
          'phone' : userService.user.phone,
          'residence' : userService.user.residence,
          'T/NT' : userService.user.T_NT,
          'uid' : userService.user.uid,
          'imageUrl' : downloadUrl,
          'lienfb' : userService.user.lienfb
        });
        await usersRef.doc(user.uid).update({
          'request' : true
        });
        await getUser();
      return true;
    }
    catch(e){
      print(e);
      return false;
    }
  }

}

class userInfo{
  User? user;
  String? email;
  String? fullName;
  String? uid;
  String? phone;
  List<String>? wishList;
  Timestamp? subscription_date;
  String? duration;
  bool? request;
  String? T_NT;
  String? residence;
  String? lienfb;
  userInfo({this.fullName,this.email,this.uid,this.wishList,this.subscription_date,this.phone,this.lienfb,this.T_NT,this.residence,this.request});
}
