import 'package:flutter/material.dart';
import 'package:medcourse/Services/userService.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:medcourse/Services/courseService.dart';
class Board extends StatelessWidget {
  String text, link,image,time;

  Board(
      {Key? key, required this.text, required this.link, required this.image,required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: userService.enrolled? SingleChildScrollView(
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
                          color: Colors.black,
                          fontSize: size.width * 0.03,
                          fontFamily: 'Metropolis',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.black,
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
              text.replaceAll(r'\n', '\n'),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 0.04,
                  fontFamily: 'Metropolis',
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async{
                await launchUrl(Uri.parse(link),mode: LaunchMode.externalApplication);
              },
              child: Text(
                link,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width * 0.04,
                    fontFamily: 'Metropolis',
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (image!='') InteractiveViewer(
        scaleEnabled: true,
        minScale: 0.5,
        maxScale: 4.0,
        scaleFactor: 2.0,
        child: Image.network(
          image,
          fit: BoxFit.contain,
        )) else const SizedBox()
          ],
        ),
      ) : const SizedBox(),
    );
  }
}
