import 'package:flutter/material.dart';
import 'package:medcourse/Models/AppSettings.dart';
import 'package:medcourse/Services/userService.dart';
import '../Widgets/Dialog.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailConttroler = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String dialogMsg = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppSettings.dark? const Color(0xff0D0D0D) : const Color(0xffF5F6FF),
      body: SafeArea(
        child: Padding(
          padding:
          EdgeInsets.only(top: size.height * 0.02, left: 30, right: 30),
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 43,
                          height: 43,
                          decoration: BoxDecoration(
                              color: AppSettings.dark? const Color(0xff111425) : const Color(0xffEBEEFF),
                              borderRadius: BorderRadius.circular(15)
                          ),
                          child: const Icon(Icons.arrow_back_ios_new,color: Colors.blue,),
                        ),
                      ),
                      SizedBox(width: size.width * 0.02,),
                      Text(
                        'Mot de passe oublié?',
                        style: TextStyle(
                            color: AppSettings.dark ? Colors.white : Colors.black,
                            fontSize: size.width * 0.05,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.04,),
                  Image.asset(
                    'assets/images/logoWithText.png',
                    width: size.height * 0.3,
                    height: size.height * 0.3,
                  ),
                  SizedBox(height: size.height * 0.04,),
                  Card(
                    elevation: 5,
                    color: AppSettings.dark
                        ? const Color.fromARGB(240, 20, 20, 20)
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(300)),
                    child: TextFormField(
                      validator: (_) {
                        dialogMsg = '';
                        if (emailConttroler.text.isEmpty) {
                          dialogMsg = "Entrer l'adresse e-mail";
                        } else if (!emailConttroler.text.contains(RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'))) {
                          dialogMsg = 'E-mail erroné';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: AppSettings.dark
                          ? Colors.white
                          : const Color.fromARGB(240, 20, 20, 20),
                      controller: emailConttroler,
                      style: TextStyle(
                        fontSize: size.height * 0.019,
                        color: AppSettings.dark
                            ? Colors.white
                            : const Color.fromARGB(240, 20, 20, 20),
                      ),
                      decoration: InputDecoration(
                        hintText: 'Email',
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
                                : BorderStyle.solid,),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.06,),
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.07>50 ? size.height * 0.07 : 50 ,
                    child: ElevatedButton(
                      onPressed: () async {
                        await forgetPassword(context);
                      },
                      style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                      child: const Text('Envoyer'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> forgetPassword(BuildContext context) async {
    (_form.currentState?.validate())!;
    if(dialogMsg.isNotEmpty){
      dialog(context, dialogMsg);
    }
    else{
      if(await userService().forgetPassword(emailConttroler.text, context)){

      }
    }
  }
}
