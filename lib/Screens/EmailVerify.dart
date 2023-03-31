import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:provider/provider.dart';

import '../Models/AppSettings.dart';
import '../Services/userService.dart';
import '../Widgets/Dialog.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
  void startTimer() {
    Timer _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(Provider.of<AppSettings>(context, listen: false).getTime()>0){
        context.read<AppSettings>().setTime();
      }
      else{
        timer.cancel();
        AppSettings.sec = 30;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }
  String code = '';
  @override
  Widget build(BuildContext context) {
    print("object");
    final size = MediaQuery.of(context).size;
    final arg = ModalRoute.of(context)?.settings.arguments as Map<String,Object>;
    return Scaffold(
      backgroundColor: AppSettings.dark? const Color(0xff0D0D0D) : const Color(0xffF5F6FF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.09,),
              Text(
                'Le code a été envoyé à',
                style: TextStyle(
                  color: AppSettings.dark ? Colors.white : Colors.black,
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${arg['email']}",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: size.width * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: size.height * 0.07,),
              OtpTextField(
                numberOfFields: 4,
                borderWidth: 4,
                enabledBorderColor: Colors.blue,
                disabledBorderColor: Colors.blue,
                borderColor: Colors.blue,
                focusedBorderColor: Colors.blue,
                styles: [TextStyle(color: AppSettings.dark? Colors.white : Colors.black),TextStyle(color: AppSettings.dark? Colors.white : Colors.black),TextStyle(color: AppSettings.dark? Colors.white : Colors.black),TextStyle(color: AppSettings.dark? Colors.white : Colors.black),],
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: AppSettings.dark? Colors.white : Colors.black)
                ),
                showFieldAsBox: false,
                onSubmit: (String verificationCode){
                  code = verificationCode;
                }, // end onSubmit
              ),
              SizedBox(height: size.height * 0.1,),
              Consumer<AppSettings>(
                builder: (_,appsetting,child){
                  if(appsetting.getTime()>0&&appsetting.getTime()<30){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Renvoyer le code dans ',
                          style: TextStyle(
                              color: AppSettings.dark ? Colors.white : Colors.black,
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '${appsetting.getTime()}',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          's',
                          style: TextStyle(
                            color: AppSettings.dark ? Colors.white : Colors.black,
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    );
                  }
                  else{
                    return  InkWell(
                      onTap: () async {
                        if (appsetting.getTime() == 30) {
                          startTimer();
                          userService().sendOtp(arg['email'] as String);
                        }
                      },
                      child: Text(
                        'Renvoyer',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: size.width * 0.04,
                            fontWeight: FontWeight.w500),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: size.height * 0.3,),
              SizedBox(
                width: double.infinity,
                height: size.height * 0.07>50 ? size.height * 0.07 : 50 ,
                child: ElevatedButton(
                  onPressed: () async {
                    if(await userService().verifyEmail(code)){
                      Navigator.of(context).popAndPushNamed(
                          '/registerprofile',
                          arguments: {
                            'email' : arg['email'] as String,
                            'password' : arg['password'] as String,
                          }
                      );
                    }
                    else{
                      dialog(context, 'otp invalide');
                    }
                  },
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text('Verifier'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
