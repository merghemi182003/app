import 'package:flutter/material.dart';
import 'package:medcourse/Services/userService.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../Models/AppSettings.dart';
import '../Widgets/Dialog.dart';

class RegisterProfile extends StatefulWidget {
  const RegisterProfile({Key? key}) : super(key: key);

  @override
  State<RegisterProfile> createState() => _RegisterProfileState();
}

class _RegisterProfileState extends State<RegisterProfile> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) => dialog(context,
        "Veuillez savoir qu'une fois vous entrez les informations de votre profil, vous ne pourrez plus les modifier!"));
    super.initState();
  }

  String dialogMsg = '';
  TextEditingController fullNameConttroler = TextEditingController();
  TextEditingController emailConttroler = TextEditingController();
  TextEditingController phoneConttroler = TextEditingController();
  TextEditingController residenceConttroler = TextEditingController();
  TextEditingController profileConttroler = TextEditingController();
  String? T_NT;
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var arg;
    try {
      arg = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      if (arg['email'] != null) {
        emailConttroler.text = arg['email']!;
      }
    } catch (e) {
      emailConttroler.text = (userService.googleUser?.email)!;
    }
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppSettings.dark
            ? const Color(0xff0D0D0D)
            : const Color(0xffF5F6FF),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _form,
              child: ModalProgressHUD(
                color: Colors.transparent,
                inAsyncCall: _loading,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: size.height * 0.3,
                        height: size.height * 0.3,
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      const SizedBox(
                        height: 10,
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
                          validator: (_) {
                            dialogMsg = '';
                            if (fullNameConttroler.text.isEmpty) {
                              dialogMsg = 'Entrer le nom et le prénom';
                            } else if (fullNameConttroler.text.length < 5) {
                              dialogMsg = 'Nom et prénom sont invalides';
                            }
                          },
                          style: TextStyle(
                            fontSize: size.height * 0.019,
                            color: AppSettings.dark
                                ? Colors.white
                                : const Color.fromARGB(240, 20, 20, 20),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Nom et prénom',
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
                          validator: (_) {
                            if (phoneConttroler.text.isEmpty) {
                              dialogMsg = 'Entrer le numéro du téléphone';
                            } else if (phoneConttroler.text.length < 10) {
                              dialogMsg = 'Le numéro du téléphone est invalide';
                            }
                          },
                          keyboardType: TextInputType.phone,
                          style: TextStyle(
                            fontSize: size.height * 0.019,
                            color: AppSettings.dark
                                ? Colors.white
                                : const Color.fromARGB(240, 20, 20, 20),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Le numéro du téléphone',
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
                          controller: residenceConttroler,
                          validator: (_) {
                            if (residenceConttroler.text.isEmpty) {
                              dialogMsg = 'Entrer la résidence';
                            }
                          },
                          style: TextStyle(
                            fontSize: size.height * 0.019,
                            color: AppSettings.dark
                                ? Colors.white
                                : const Color.fromARGB(240, 20, 20, 20),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Résidence',
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
                          controller: profileConttroler,
                          validator: (_) {
                            if (profileConttroler.text.isEmpty) {
                              dialogMsg = 'Entrer le lien de votre profil facebook';
                            }
                          },
                          style: TextStyle(
                            fontSize: size.height * 0.019,
                            color: AppSettings.dark
                                ? Colors.white
                                : const Color.fromARGB(240, 20, 20, 20),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Lien de votre profil facebook',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Radio(
                                  value: 'Travailleur',
                                  fillColor: MaterialStatePropertyAll(Colors.red),
                                  groupValue: T_NT,
                                  onChanged: (value) {
                                    setState(() {
                                      T_NT = value as String?;
                                    });
                                  },),
                              Text(
                                'Travailleur',
                                style: TextStyle(
                                    color: AppSettings.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: size.width * 0.035,
                                    fontFamily: 'Metropolis',
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                  value: 'Non travailleur',
                                  fillColor: MaterialStatePropertyAll(Colors.red),
                                  groupValue: T_NT,
                                  onChanged: (value) {
                                    setState(() {
                                      T_NT = value as String?;
                                    });
                                  }),
                              Text(
                                'Non travailleur',
                                style: TextStyle(
                                    color: AppSettings.dark
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: size.width * 0.035,
                                    fontFamily: 'Metropolis',
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height:
                            size.height * 0.07 > 50 ? size.height * 0.07 : 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            (_form.currentState?.validate());
                            if (T_NT == null) {
                              dialogMsg =
                                  'Sélectionner Travailleur/Non travailleur';
                            }
                            if (dialogMsg.isNotEmpty) {
                              dialog(context, dialogMsg);
                            } else {
                              setState(() {
                                _loading = true;
                              });
                              if (arg != null) {
                                await registerNewProfileWithEmail(arg, context);
                              } else {
                                if (await userService()
                                    .signUpWithGoogle(context)) {
                                  if (await userService().addUserFirestore(
                                      email: emailConttroler.text,
                                      fullName: fullNameConttroler.text,
                                      phone: phoneConttroler.text,
                                      T_NT: T_NT!,
                                      lienfb: profileConttroler.text,
                                      residence: residenceConttroler.text)) {
                                    Navigator.of(context)
                                        .popAndPushNamed('/navigatorscreen');
                                  } else {
                                    dialog(context, 'Erreur inconnue');
                                  }
                                }
                              }
                              setState(() {
                                _loading = false;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder()),
                          child: const Text('Valider'),
                        ),
                      ),
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

  Future<void> registerNewProfileWithEmail(
      Map<String, String> arg, BuildContext context) async {
    if (await userService().signUpWithEmailPassword(
        emailConttroler.text, arg['password']!, context)) {
      if (await userService().addUserFirestore(
          email: emailConttroler.text,
          fullName: fullNameConttroler.text,
          phone: phoneConttroler.text,
          T_NT: T_NT!,
          lienfb: profileConttroler.text,
          residence: residenceConttroler.text)) {
        Navigator.of(context).popAndPushNamed('/navigatorscreen');
      } else {
        dialog(context, 'unknown error');
      }
    }
  }
}
