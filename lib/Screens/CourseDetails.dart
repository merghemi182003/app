import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medcourse/Services/courseService.dart';
import 'package:medcourse/Services/userService.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';
import '../Models/AppSettings.dart';
import 'package:intl/intl.dart';
class EnrolledCourse extends StatefulWidget {
  Map<String, dynamic> course;

  EnrolledCourse({Key? key, required this.course}) : super(key: key);

  @override
  State<EnrolledCourse> createState() => _EnrolledCourseState();
}

class _EnrolledCourseState extends State<EnrolledCourse> {
  YoutubePlayerController? vcs;
  YoutubeMetaData? _videoMetaData;
  String? videoID;
  int i = 0;
  String urlVideo = '';

  @override
  void initState() {
    urlVideo = widget.course['urlVideo'];
    _playVideo(init: true);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return userService.enrolled? YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: vcs!,
        showVideoProgressIndicator: true,
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: AppSettings.dark
              ? const Color(0xff000000)
              : const Color(0xffF5F6FF),
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                player,
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: ClipOval(
                                  child: Image.network(courseService.infoTeacher['urlPhoto'])
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  courseService.infoTeacher['name'],
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: size.width * 0.03,
                                      fontFamily: 'Metropolis',
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                  DateFormat('y MMM d HH:mm').format((widget.course['postTime'] as Timestamp).toDate()),
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: size.width * 0.03,
                                    fontFamily: 'Metropolis',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          widget.course['name'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 30,
                          style: TextStyle(
                              color: AppSettings.dark ? Colors.white : Colors.black,
                              fontSize: size.width * 0.05,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text(
                            'Description : \n\n',
                          style: TextStyle(
                              color: AppSettings.dark ? Colors.white : Colors.black,
                              fontSize: size.width * 0.04,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.course['description']}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 30,
                          style: TextStyle(
                              color: AppSettings.dark ? Colors.white : Colors.black,
                              fontSize: size.width * 0.03,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ) :  Scaffold(
      backgroundColor: AppSettings.dark? const Color(0xff0D0D0D) : const Color(0xffF5F6FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network('https://i3.ytimg.com/vi_webp/$videoID/sddefault.webp',fit: BoxFit.contain,),
                Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipOval(
                          child: Image.network(courseService.infoTeacher['urlPhoto'],)
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          courseService.infoTeacher['name'],
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: size.width * 0.03,
                              fontFamily: 'Metropolis',
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('y MMM d HH:mm').format((widget.course['postTime'] as Timestamp).toDate()),
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: size.width * 0.03,
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  widget.course['name'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 30,
                  style: TextStyle(
                      color: AppSettings.dark ? Colors.white : Colors.black,
                      fontSize: size.width * 0.05,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  'Description : \n\n',
                  style: TextStyle(
                      color: AppSettings.dark ? Colors.white : Colors.black,
                      fontSize: size.width * 0.04,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  '${widget.course['description']}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 30,
                  style: TextStyle(
                      color: AppSettings.dark ? Colors.white : Colors.black,
                      fontSize: size.width * 0.03,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _playVideo({bool init = false}) {
    videoID = YoutubePlayer.convertUrlToId(urlVideo);
    vcs = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ))
      ..addListener(() {
        _videoMetaData = const YoutubeMetaData();
      });
  }
}
/*Scaffold(
      backgroundColor:
      AppSettings.dark ? const Color(0xff0D0D0D) : const Color(0xffffffff),
      body: SafeArea(
        child: Padding(
          padding:
          EdgeInsets.only(top: size.height * 0.02, left: 30, right: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      width: size.width * 0.02,
                    ),
                    SizedBox(
                      width: (size.width - 60) * 0.85,
                      child: Text(
                        '${course['name']}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color:
                            AppSettings.dark ? Colors.white : Colors.black,
                            fontSize: size.width * 0.05,
                            fontFamily: 'Metropolis',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                SizedBox(
                  width: double.infinity,
                  height: size.height * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: course['photo'] != ''
                        ? Image.network(
                      course['photo']!,
                      fit: BoxFit.fill,
                    )
                        : Image.asset('assets/images/online-course.png'),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppSettings.dark
                            ? const Color(0xff111425)
                            : const Color(0xffEBEEFF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.person_pin_sharp,
                              color: Colors.blue,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${(course['nEnroll']) as int}",
                              style: const TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppSettings.dark
                              ? const Color(0xff111425)
                              : const Color(0xffEBEEFF),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star_half,
                              color: Colors.blue,
                            ),
                            Text(
                              "${(course['rate'] as int).toDouble()}",
                              style: const TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  course['name'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                      color: AppSettings.dark ? Colors.white : Colors.black,
                      fontSize: size.width * 0.04,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.03,
                ),
                Text(
                  course['description'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 30,
                  style: TextStyle(
                      color: AppSettings.dark ? Colors.white : Colors.black,
                      fontSize: size.width * 0.03,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Text(
                  '${(course['videos'] as List<dynamic>).length.toString()} Lessons',
                  style: TextStyle(
                      color: AppSettings.dark ? Colors.white : Colors.black,
                      fontSize: size.width * 0.05,
                      fontFamily: 'Metropolis',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );*/
