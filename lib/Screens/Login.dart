
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcourse/Models/AppSettings.dart';
import 'package:medcourse/Services/userService.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:medcourse/Widgets/Dialog.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailConttroler = TextEditingController();
  TextEditingController passwordConttroler = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _loading = false;
  String dialogMsg = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async { return false;},
      child: Scaffold(
        backgroundColor: AppSettings.dark? const Color(0xff0D0D0D) : const Color(0xffF5F6FF),
        body: Container(
          width: size.width,
          height:size.height,
          color: Colors.transparent,
          child: ModalProgressHUD(
            color : Colors.transparent,
            inAsyncCall: _loading,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: size.height * 0.15,
                        height: size.height * 0.15,
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Text(
                        'Connectez-vous à votre compte',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: size.height * 0.03,
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
                              dialogMsg =  'Entrer votre email';
                            } else if (!emailConttroler.text.contains(RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$'))) {
                              dialogMsg =  'Email éronée';
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
                        child: Selector<AppSettings, bool>(
                          selector: (context, appsettings) =>
                              appsettings.getPaaswordVisibelity(),
                          builder: (_, visible, child) {
                            return TextFormField(
                              validator: (_) {
                                if (passwordConttroler.text.isEmpty) {
                                  dialogMsg =  'Entrer le mot de passe';
                                }

                              },
                              keyboardType: TextInputType.visiblePassword,
                              cursorColor: AppSettings.dark
                                  ? Colors.white
                                  : const Color.fromARGB(240, 20, 20, 20),
                              obscureText: visible,
                              controller: passwordConttroler,
                              style: TextStyle(
                                fontSize: size.height * 0.019,
                                color: AppSettings.dark
                                    ? Colors.white
                                    : const Color.fromARGB(240, 20, 20, 20),
                              ),
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: visible
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
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('/forgetpassword');
                            },
                            child: const Text(
                              'Mot de passe oublié?',
                              style: TextStyle(color: Color(0xff304FFE)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: size.height * 0.07>50 ? size.height * 0.07 : 50 ,
                        child: ElevatedButton(
                          onPressed: () async{
                            (_form.currentState?.validate())!;
                            if(dialogMsg.isNotEmpty){
                              dialog(context, dialogMsg);
                            }
                            else{
                              setState(() {
                                _loading = true;
                              });
                              if(await userService().signInWithEmailPassword(emailConttroler.text, passwordConttroler.text, context)) {
                                Navigator.of(context).popAndPushNamed('/navigatorscreen');
                              }
                              setState(() {
                                _loading = false;
                              });

                            }
                          },
                          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                          child: const Text('Se connecter'),
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
                              if(await userService().signInWithGoogle(context)){
                                Navigator.of(context).popAndPushNamed('/navigatorscreen');
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
                          Text("Vous n'avez pas de compte? ",
                              style: TextStyle(
                                color: AppSettings.dark ? Colors.white : Colors.black,
                              )),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/register');
                            },
                            child: const Text(
                              "S'inscrire",
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
          ),
        ),
      ),
    );
  }
}
