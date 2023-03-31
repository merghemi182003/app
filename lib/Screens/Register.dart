import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../Models/AppSettings.dart';
import '../Services/userService.dart';
import '../Widgets/Dialog.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController emailConttroler = TextEditingController();
  TextEditingController passwordConttroler = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _loading = false;
  String dialogMsg = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppSettings.dark? const Color(0xff0D0D0D) : const Color(0xffF5F6FF),
      body: Form(
        key: _form,
        child: ModalProgressHUD(
          color : Colors.transparent,
          inAsyncCall: _loading,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
              child: Column(
                children: [
                  SizedBox(
                    width: size.height * 0.3,
                    height: size.height * 0.3,
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    'Créer un nouveau compte',
                    style: TextStyle(
                        fontSize: size.height * 0.027,
                        color: AppSettings.dark ? Colors.white : Colors.black),
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
                      validator: (_) {
                        dialogMsg = '';
                        if (emailConttroler.text.isEmpty) {
                          dialogMsg =  "Entrer l'adresse e-mail";
                        } else if (!emailConttroler.text.contains(RegExp(
                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'))) {
                          dialogMsg =  'E-mail erroné';
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
                                  : BorderStyle.solid),
                        ),
                      ),
                    ),
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
                        borderRadius: BorderRadius.circular(300)),
                    child: Consumer<AppSettings>(
                      builder: (_,appsetting,child){
                        return TextFormField(
                          validator: (_) {
                            if (passwordConttroler.text.isEmpty) {
                              dialogMsg =  'Entrer le mot de passe';
                            }
                            else if(passwordConttroler.text.length<6){
                              dialogMsg =  'Le mot de passe doit être au moins de 6 caractères';
                            }

                          },
                          keyboardType: TextInputType.visiblePassword,
                          cursorColor: AppSettings.dark
                              ? Colors.white
                              : const Color.fromARGB(240, 20, 20, 20),
                          obscureText: appsetting.getPaaswordVisibelity(),
                          controller: passwordConttroler,
                          style: TextStyle(
                            fontSize: size.height * 0.019,
                            color: AppSettings.dark
                                ? Colors.white
                                : const Color.fromARGB(240, 20, 20, 20),
                          ),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: appsetting.getPaaswordVisibelity()
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility_outlined),

                              onPressed: () => context.read<AppSettings>().setPaaswordVisibelity(),
                            ),
                            hintText: 'Mot de passe',
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
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.07>50 ? size.height * 0.07 : 50 ,
                    child: ElevatedButton(
                      onPressed: () async{
                        setState(() {
                          _loading = true;
                        });
                        await registerNewUser(context);
                        setState(() {
                          _loading = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                      child: const Text("S'inscrire"),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Text(
                    'ou continuer avec',
                    style: TextStyle(
                      color: AppSettings.dark ? Colors.white : Colors.black,
                    ),
                  ),
                  SizedBox(height: size.height * 0.028,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: AppSettings.dark
                                  ? const Color(0xff26293A)
                                  : Colors.white),
                          onPressed: () {},
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/facebook.svg',
                                width: 43,
                                height: 43,
                              ),
                            ],
                          )),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: AppSettings.dark
                                ? const Color(0xff26293A)
                                : Colors.white),
                        onPressed: () async{
                          setState(() {
                            _loading = true;
                          });
                          if(await userService().selectGoogle(context)){
                            Navigator.of(context).popAndPushNamed('/registerprofile');
                          }
                          setState(() {
                            _loading = false;
                          });

                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/google.svg',
                              width: 43,
                              height: 43,
                            ),
                          ],
                        ),)
                    ],
                  ),
                  SizedBox(height: size.height * 0.03,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Vous avez déjà un compte? ",
                          style: TextStyle(
                            color: AppSettings.dark ? Colors.white : Colors.black,
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Se connecter',
                          style: TextStyle(color: Color(0xff304FFE)),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),

      )
    );
  }

  Future<void> registerNewUser(BuildContext context) async {
    _form.currentState?.validate();
    if (dialogMsg.isNotEmpty) {
      dialog(context, dialogMsg);
    }
    else {
      setState(() {
        _loading = true;
      });
      if ((await userService().isUser(emailConttroler.text))) {
        dialog(context, 'Votre email a été déja utilisé ');
      }
      else {
        if (await userService().sendOtp(emailConttroler.text)) {
          Navigator.of(context).pushNamed(
              '/emailverify',
              arguments: {
                'email': emailConttroler.text,
                'password': passwordConttroler.text
              }
          );
        }
        else {
          dialog(context, "Échec d'envoi otp");
        }
      }
      setState(() {
        _loading = false;
      });
    }
  }
}
