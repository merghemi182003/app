import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medcourse/Services/boardService.dart';
import 'package:medcourse/Services/userService.dart';
import 'package:medcourse/Widgets/Board.dart';
import 'package:intl/intl.dart';
import '../Models/AppSettings.dart';

class AllBoard extends StatefulWidget {
  const AllBoard({Key? key}) : super(key: key);

  @override
  State<AllBoard> createState() => _AllBoardState();
}

class _AllBoardState extends State<AllBoard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor:
          AppSettings.dark ? const Color(0xff0D0D0D) : const Color(0xffF5F6FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
          child:  Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 43,
                      height: 43,
                      decoration: BoxDecoration(
                          color: AppSettings.dark
                              ? const Color(0xff111425)
                              : const Color(0xffEBEEFF),
                          borderRadius: BorderRadius.circular(15)),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    'Nouveautés',
                    style: TextStyle(
                        color: AppSettings.dark ? Colors.white : Colors.black,
                        fontSize: size.width * 0.04,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.04,
              ),
              userService.enrolled?
              Expanded(
                child: ListView.builder(
                  itemCount: boardService.borads.length,
                  itemBuilder: (_, index) {
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xff4855FD),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xFF0A1CE7),
                                blurRadius: 20,
                                spreadRadius:
                                    0.0, // shadow direction: bottom right
                              )
                            ],
                          ),
                          child: Board(
                              text: boardService.borads[index]['text'],
                              link: boardService.borads[index]['link'],
                              image: boardService.borads[index]['image'],
                              time: DateFormat('yyyy-MM-dd HH:mm').format(
                                  (boardService.borads[index]['time']
                                          as Timestamp)
                                      .toDate())),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
              ) : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
