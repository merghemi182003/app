import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medcourse/Screens/Payment.dart';
import 'package:medcourse/Services/userService.dart';
import 'package:provider/provider.dart';
import '../Models/AppSettings.dart';
import '../Widgets/Dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medcourse/Services/boardService.dart';
class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  String dialogMsg = '';
  String? _selectedGender;
  TextEditingController fullNameConttroler = TextEditingController();
  TextEditingController emailConttroler = TextEditingController();
  TextEditingController phoneConttroler = TextEditingController();
  XFile? image;
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    emailConttroler.text = (userService.user.email)!;
    fullNameConttroler.text = (userService.user.fullName)!;
    phoneConttroler.text = (userService.user.phone)!;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppSettings.dark? const Color(0xff0D0D0D) : const Color(0xffF5F6FF),
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text(
                          'Profil',
                          style: TextStyle(
                              color: AppSettings.dark ? Colors.white : Colors.black,
                              fontSize: size.width * 0.05,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Text(
                      'Rejoint ${DateFormat.yMMMd().format((userService.auth.currentUser?.metadata.creationTime)!)}',
                      style: TextStyle(
                          fontSize: size.height * 0.015,
                          fontFamily: 'Metropolis',
                          color: AppSettings.dark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: size.height * 0.04,
                    ),
                    Card(
                      elevation: 5,
                      color: AppSettings.dark
                          ? const Color.fromARGB(240, 20, 20, 20)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(300),
                      ),
                      child: TextFormField(
                        controller: fullNameConttroler,
                        readOnly: true,
                        style: TextStyle(
                          fontSize: size.height * 0.019,
                          color: AppSettings.dark
                              ? Colors.white
                              : const Color.fromARGB(240, 20, 20, 20),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Le nom et le prénom',
                          prefixIcon: const Icon(Icons.person,color: Colors.blue,),
                          hintStyle: const TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(300),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                                style: AppSettings.dark
                                    ? BorderStyle.none
                                    : BorderStyle.solid),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(300),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                                style: AppSettings.dark
                                    ? BorderStyle.none
                                    : BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Card(
                      elevation: 5,
                      color: AppSettings.dark
                          ? const Color.fromARGB(240, 20, 20, 20)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(300)),
                      child: TextFormField(
                        controller: emailConttroler,
                        readOnly: true,
                        style: TextStyle(
                          fontSize: size.height * 0.019,
                          color: AppSettings.dark
                              ? Colors.white
                              : const Color.fromARGB(240, 20, 20, 20),
                        ),
                        decoration: InputDecoration(
                          hintText: 'E-mail',
                          prefixIcon: const Icon(Icons.email_outlined,color: Colors.blue,),
                          hintStyle: const TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(300),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                                style: AppSettings.dark
                                    ? BorderStyle.none
                                    : BorderStyle.solid),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(300),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                                style: AppSettings.dark
                                    ? BorderStyle.none
                                    : BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Card(
                      elevation: 5,
                      color: AppSettings.dark
                          ? const Color.fromARGB(240, 20, 20, 20)
                          : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(300)),
                      child: TextFormField(
                        controller: phoneConttroler,
                        readOnly: true,
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          fontSize: size.height * 0.019,
                          color: AppSettings.dark
                              ? Colors.white
                              : const Color.fromARGB(240, 20, 20, 20),
                        ),
                        decoration: InputDecoration(
                          hintText: 'Le numéro de téléphone',
                          prefixIcon: const Icon(Icons.phone,color: Colors.blue,),
                          hintStyle: const TextStyle(color: Colors.grey),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(300),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                                style: AppSettings.dark
                                    ? BorderStyle.none
                                    : BorderStyle.solid),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(300),
                            borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1,
                                style: AppSettings.dark
                                    ? BorderStyle.none
                                    : BorderStyle.solid),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Row(
                      children: [
                        Text(
                          'Paiement : \n\n',
                          style: TextStyle(
                              color: AppSettings.dark ? Colors.white : Colors.black,
                              fontSize: size.width * 0.04,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: userService.enrolled?  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'du : ${DateFormat.yMMMd().format((userService.user.subscription_date?.toDate())!)}',
                              style: TextStyle(
                                  color: AppSettings.dark ? Colors.white : Colors.black,
                                  fontSize: size.width * 0.04,
                                  fontFamily: 'Metropolis',
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              'au : ${DateFormat.yMMMd().format((userService.user.subscription_date?.toDate().add(Duration(days: int.parse(userService.user.duration.toString()))))!)}',
                              style: TextStyle(
                                  color: AppSettings.dark ? Colors.white : Colors.black,
                                  fontSize: size.width * 0.04,
                                  fontFamily: 'Metropolis',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ) : Text(
                          "Pas d'abonnement",
                          style: TextStyle(
                              color: AppSettings.dark ? Colors.white : Colors.black,
                              fontSize: size.width * 0.04,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.06,),
                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.07 > 50 ? size.height * 0.07 : 50,
                      child: ElevatedButton(
                        onPressed: ()async{
                          Navigator.push(context,MaterialPageRoute(builder: (_)=> const Payment()));
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder()),
                        child: const Text('Page de paiement'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
