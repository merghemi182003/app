import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medcourse/Widgets/Dialog.dart';
import '../Models/AppSettings.dart';
import '../Services/userService.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentpasswordConttroler = TextEditingController();
  TextEditingController newpasswordConttroler = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _loading = false;
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
                    SizedBox(width: size.width * 0.03,),
                    Text(
                      'Changer le mot de passe',
                      style: TextStyle(
                          color: AppSettings.dark ? Colors.white : Colors.black,
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.04,),
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
                          dialogMsg = '';
                          if (currentpasswordConttroler.text.isEmpty) {
                            dialogMsg =  'Entrez le mot de passe';
                          }

                        },
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: AppSettings.dark
                            ? Colors.white
                            : const Color.fromARGB(240, 20, 20, 20),
                        obscureText: appsetting.getPaaswordVisibelity(),
                        controller: currentpasswordConttroler,
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
                          hintText: 'Mot de passe actuel',
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
                SizedBox(height: size.height * 0.03,),
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
                          if (newpasswordConttroler.text.isEmpty) {
                            dialogMsg =  "Le nouveau mot de passe ne peut pas être vide";
                          }

                        },
                        keyboardType: TextInputType.visiblePassword,
                        cursorColor: AppSettings.dark
                            ? Colors.white
                            : const Color.fromARGB(240, 20, 20, 20),
                        obscureText: appsetting.getPaaswordVisibelity(),
                        controller: newpasswordConttroler,
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
                          hintText: 'Nouveau mot de passe',
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
                SizedBox(height: size.height * 0.05,),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.07 > 50 ? size.height * 0.07 : 50,
                  child: ElevatedButton(
                    onPressed: () async {

                      (_form.currentState?.validate())!;
                      if(dialogMsg.isNotEmpty){
                        dialog(context, dialogMsg);
                      }
                      else{

                        setState(() {
                          _loading = true;
                        });
                        await userService().updatePassword(context,currentPassword: currentpasswordConttroler.text, newPassword: newpasswordConttroler.text );
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
    );
  }
}
