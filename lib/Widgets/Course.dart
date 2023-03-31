import 'package:flutter/material.dart';
import 'package:medcourse/Models/AppSettings.dart';
import 'package:medcourse/Services/courseService.dart';
import '../Screens/CourseDetails.dart';
import '../Services/userService.dart';

class Course extends StatefulWidget {
  Map<String,dynamic> course;
  Course(
      {Key? key,required this.course})
      : super(key: key);

  @override
  State<Course> createState() => _CourseState();
}

class _CourseState extends State<Course> {
  late String nameCourse,uid;
  late String urlImage;
  late bool isSaved;
  @override
  void initState() {
    super.initState();
    nameCourse = widget.course['name'];
    uid = widget.course['uid'];
    urlImage = widget.course['photo'];
    isSaved = (userService.user.wishList?.contains(uid))!;//(widget.userInfo['wishList'] as List<dynamic>).contains(uid);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: ()async{
          Navigator.of(context).push(MaterialPageRoute(builder: (_){
            return EnrolledCourse(course: widget.course,);
          }));
        },
        child: Container(
          width: double.infinity,
          height: size.height * 0.12>=75? size.height * 0.12 : 75,
          decoration: BoxDecoration(
            color: AppSettings.dark
                ? const Color(0xff26293A)
                : const Color(0xffffffff),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: (size.width-60) * 0.22,
                  height: (size.width-60) * 0.22,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: urlImage.isNotEmpty? Image.network(urlImage) : Image.asset('assets/images/online-course.png'),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width:  userService.enrolled? (size.width - 60) * 0.5 : (size.width - 60) * 0.7,
                    child: Text(
                      nameCourse,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: size.height * 0.016,
                          fontFamily: 'Metropolis',
                          color: AppSettings.dark ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    'Dr Merghemi Lazhar',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: size.height * 0.016,
                        fontFamily: 'Metropolis',
                        color: Colors.blue,
                        fontWeight: FontWeight.bold),
                  ),

                ],
              ),
              userService.enrolled? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: ()async{
                          if(await userService().likeAndDislike(uid, isSaved)) {
                            setState((){
                              isSaved = !isSaved;
                            });
                          }

                        },
                        icon: Icon(isSaved? Icons.favorite : Icons.favorite_border,color: const Color(0xff4855FD),)),
                  ],
                ),
              ) : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
