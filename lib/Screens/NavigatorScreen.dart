import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:medcourse/Models/AppSettings.dart';
import 'package:medcourse/Screens/FavoriteTab.dart';
import 'package:medcourse/Screens/ProfileTab.dart';
import 'package:medcourse/Screens/SettingsTab.dart';
import 'package:medcourse/Widgets/Dialog.dart';
import 'package:provider/provider.dart';

import 'HomeTab.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({Key? key}) : super(key: key);

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {

  int index = 0;
  List<Widget> Tabs = [
    const HomeTab(),
    const WishListTab(),
    const SettingsTab(),
    const ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async{ return false; },
      child: SafeArea(
        child: Consumer<AppSettings>(
          builder: (_,appsetting,child){
            return Scaffold(
              backgroundColor: AppSettings.dark? const Color(0xff0D0D0D) : const Color(0xffF5F6FF),
              body: Tabs[appsetting.getIndex()],
              bottomNavigationBar: Container(
                height: size.height * 0.11,
                color: Colors.transparent,
                child: Material(
                  elevation: 20,
                  child: GNav(
                    selectedIndex: appsetting.getIndex(),
                    tabMargin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    tabBorderRadius: 20,
                    gap: 8,
                    activeColor: const Color(0xff585AFE),
                    color: const Color(0xff585AFE),
                    backgroundColor: AppSettings.dark
                        ? const Color(0xff252525)
                        : const Color(0xffffffff),
                    tabShadow: [
                      (AppSettings.dark)
                          ? const BoxShadow(color: Color(0xff26293A))
                          : const BoxShadow(color: Color(0xffEBEEFF))
                    ],
                    onTabChange: (i) {
                      context.read<AppSettings>().setIndex(i);
                    },
                    tabs: const [
                      GButton(
                        icon: Icons.home,
                        text: 'Accueil',
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      ),
                      GButton(
                        icon: Icons.favorite,
                        text: 'Favoris',
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      ),
                      GButton(
                        icon: Icons.settings,
                        text: 'Paramètres',
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      ),
                      GButton(
                        icon: Icons.person,
                        text: 'Profil',
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
