import 'package:flutter/material.dart';
import 'package:medcourse/Services/courseService.dart';
import 'package:medcourse/Services/userService.dart';
import '../Models/AppSettings.dart';
import '../Widgets/Course.dart';


class WishListTab extends StatefulWidget {
  const WishListTab({Key? key}) : super(key: key);

  @override
  State<WishListTab> createState() => _WishListTabState();
}

class _WishListTabState extends State<WishListTab> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppSettings.dark? const Color(0xff0D0D0D) : const Color(0xffF5F6FF),
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.only(top: 10, left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Favoris',
                style: TextStyle(
                    color: AppSettings.dark ? Colors.white : Colors.black,
                    fontSize: size.width * 0.05,
                    fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: size.height * 0.02,),
              Expanded(
                child: Container(
                  color: !AppSettings.dark? const Color(0xffF5F6FF)  : null,
                  child:  ListView.builder(
                    itemCount: courseService.allCourseList.length,
                    itemBuilder: (context, index) {
                      return (userService.user.wishList?.contains(courseService.allCourseList[index]['uid']))!? Column(
                        children: [
                          Course(course: courseService.allCourseList[index]),
                          const SizedBox(height: 10,)
                        ],
                      ) : const SizedBox();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
