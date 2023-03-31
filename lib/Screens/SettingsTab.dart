import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcourse/Services/userService.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Models/AppSettings.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        color: AppSettings.dark
            ? const Color(0xff000000)
            : const Color(0xffF5F6FF),
        child: Padding(
          padding:
          const EdgeInsets.only(top: 10, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: AppSettings.dark
                                ? const Color(0xff111425)
                                : const Color(0xffEBEEFF),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Icon(
                          Icons.dark_mode,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Dark Mode',
                        style: TextStyle(
                            fontSize: size.height * 0.02,
                            fontFamily: 'Metropolis',
                            color:
                            AppSettings.dark ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  CupertinoSwitch(
                      activeColor: Colors.blue,
                      value: context.watch<AppSettings>().getDark(),
                      onChanged: (dark) {
                        context.read<AppSettings>().setDark();
                      })
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              InkWell(
                onTap: ()async{
                  await launchUrl(
                      Uri.parse('https://www.facebook.com/profile.php?id=100063756502406'),
                      mode: LaunchMode.externalApplication,
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: AppSettings.dark
                              ? const Color(0xff250E13)
                              : const Color(0xffEBEEFF),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Icon(
                        Icons.facebook,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Facebook',
                      style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontFamily: 'Metropolis',
                          color:
                          AppSettings.dark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              InkWell(
                onTap: ()async{
                  await launchUrl(
                    Uri.parse('https://www.youtube.com/@lazharmerghemi2907'),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                              color: AppSettings.dark
                                  ? const Color(0xff250E13)
                                  : const Color(0xffEBEEFF),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        SizedBox(width: 30,child: Image.asset('assets/images/youtube.png'))
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Youtube',
                      style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontFamily: 'Metropolis',
                          color:
                          AppSettings.dark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: AppSettings.dark
                            ? const Color(0xff250E13)
                            : const Color(0xffEBEEFF),
                        borderRadius: BorderRadius.circular(15)),
                    child: const Icon(
                      Icons.verified_user_outlined,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Version 1.1.2',
                    style: TextStyle(
                        fontSize: size.height * 0.02,
                        fontFamily: 'Metropolis',
                        color:
                        AppSettings.dark ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed('/aboutus');
                },
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: AppSettings.dark
                              ? const Color(0xff250E13)
                              : const Color(0xffEBEEFF),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Icon(
                        Icons.info_outline,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'À Propos de nous',
                      style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontFamily: 'Metropolis',
                          color:
                          AppSettings.dark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed('/changepassword');
                },
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: AppSettings.dark
                              ? const Color(0xff250E13)
                              : const Color(0xffEBEEFF),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Icon(
                        Icons.security_rounded,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Changer le mot de passe',
                      style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontFamily: 'Metropolis',
                          color:
                          AppSettings.dark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              InkWell(
                onTap: () async {
                  bool logout = false;
                  showBottomSheet(
                      context: context,
                      builder: (context) {
                        return Consumer<AppSettings>(
                          builder: (_,appsetting,child){
                            return Material(
                              borderRadius: const BorderRadius.only(topRight:Radius.circular(20),topLeft: Radius.circular(20)),
                              elevation: 20,
                              child: Container(
                                width: double.infinity,
                                height: size.height * 0.25,
                                decoration: BoxDecoration(
                                    color: appsetting.getDark()
                                        ? const Color(0xff161B20)
                                        : const Color(0xffffffff),
                                    borderRadius: const BorderRadius.only(topRight:Radius.circular(20),topLeft: Radius.circular(20))
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(Icons.logout,color: Colors.blue,size: 48,),
                                    ),
                                    Text(
                                      'Êtes-vous sûr de vous déconnecter ?',
                                      style: TextStyle(
                                        color: appsetting.getDark() ? Colors.white : Colors.black,
                                        fontSize: size.width * 0.04,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Metropolis',
                                      ),
                                    ),
                                    const SizedBox(height: 30,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width : size.width * 0.3,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            style: ButtonStyle(
                                                backgroundColor: const MaterialStatePropertyAll(Colors.transparent),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(18.0),
                                                        side: const BorderSide(color: Colors.blue)
                                                    )
                                                ),
                                                elevation  : const MaterialStatePropertyAll(0)
                                            ),
                                            child: const Text('Annuler',style: TextStyle(color: Colors.blue),),
                                          ),
                                        ),
                                        SizedBox(
                                          width : size.width * 0.3,
                                          child: ElevatedButton(

                                            onPressed: () async{
                                              if(await userService().signOut()){
                                                AppSettings.index = 0;
                                                Navigator.of(context).popAndPushNamed('/signin');
                                              }
                                            },
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(18.0),
                                                        side: const BorderSide(color: Colors.blue)
                                                    )
                                                ),
                                                elevation  : const MaterialStatePropertyAll(0)
                                            ),
                                            child: const Text('Oui'),
                                          ),
                                        )
                                      ],

                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      backgroundColor: Colors.transparent
                  );
                },
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          color: AppSettings.dark
                              ? const Color(0xff250E13)
                              : const Color(0xffEBEEFF),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Icon(
                        Icons.logout,
                        color: Color(0xffFF1843),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Déconnecter',
                      style: TextStyle(
                          fontSize: size.height * 0.02,
                          fontFamily: 'Metropolis',
                          color: AppSettings.dark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
