
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medcourse/Services/boardService.dart';
import 'package:medcourse/Services/courseService.dart';
import 'package:medcourse/Services/userService.dart';
import 'package:medcourse/Widgets/Board.dart';
import 'package:medcourse/Widgets/Dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/AppSettings.dart';
import '../Widgets/Course.dart';
import 'package:intl/intl.dart';
class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String? firstName;
  late List<Map<String, dynamic>> courseList;
  bool buildHome = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: Future.wait([userService().getUser()]),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          try {
            firstName = (userService.user.fullName as String)
                .substring(0, (userService.user.fullName as String).indexOf(' '));
          } catch (e) {
            firstName = (userService.user.fullName as String);
          }
          return Container(
            width: size.width,
            height: size.height * 0.89,
            color: AppSettings.dark
                ? const Color(0xff000000)
                : const Color(0xffF5F6FF),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              width: 43,
                            ),
                            SizedBox(
                              width: size.width * 0.02,
                            ),
                            Text(
                              "Bonjour, ${capitalize(firstName!)}!",
                              style: TextStyle(
                                color: AppSettings.dark
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: size.width * 0.05,
                                fontFamily: 'Metropolis',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nouveautés',
                          style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontFamily: 'Metropolis',
                              color: AppSettings.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () async {
                            Navigator.of(context).pushNamed('/allboard');
                          },
                          child: const Text(
                            'Voir tout',
                            style: TextStyle(color: Color(0xff304FFE)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Container(
                      width: double.infinity,
                      height: size.height * 0.18,
                      decoration: BoxDecoration(
                          color: const Color(0xff4855FD),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF0A1CE7),
                              blurRadius: 20,
                              spreadRadius: 0.0, // shadow direction: bottom right
                            )
                          ]),
                      child: userService.enrolled?  Board(text: boardService.borads[0]['text'], link: boardService.borads[0]['link'], image: boardService.borads[0]['image'],time: DateFormat('y MMM d HH:mm').format((boardService.borads[0]['time'] as Timestamp).toDate()),) : Board(text: '', link: '', image: '', time: ''),
                    ),

                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      children: [
                        Text(
                          'Nos séances : ',
                          style: TextStyle(
                              fontSize: size.height * 0.02,
                              fontFamily: 'Metropolis',
                              color: AppSettings.dark
                                  ? Colors.white
                                  : Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future: courseService().getAllCourse(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            courseList = snapshot.data
                            as List<Map<String, dynamic>>;
                            return ListView.builder(
                              itemCount: courseList.length,
                              itemBuilder: (context, index) {
                                //print(userServices.wishList);

                                if(!buildHome){
                                  buildHome = true;
                                  for (var element in courseList) {
                                    if((userService.user.wishList?.contains(element['uid']))!){
                                      userService.user.wishList?.add(element['uid']);
                                    }
                                  }

                                }
                                return Column(
                                  children: [
                                    Course(
                                      course: courseList[index],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    )
                                  ],
                                );
                              },
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container(
            color: AppSettings.dark
                ? const Color(0xff000000)
                : const Color(0xffffffff),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  String capitalize(String s) =>
      s.isNotEmpty ? '${s[0].toUpperCase()}${s.substring(1)}' : '';

}
