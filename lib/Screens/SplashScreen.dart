import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medcourse/Models/AppSettings.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.popAndPushNamed(context, FirebaseAuth.instance.currentUser==null? '/signin' : '/navigatorscreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppSettings.dark? const Color(0xff0D0D0D) : const Color(0xffF5F6FF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppSettings.dark? 'assets/images/splashLogoDark.gif' : 'assets/images/splashLogoLight.gif',
                width: size.height * 0.4,
                height: size.height * 0.4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
