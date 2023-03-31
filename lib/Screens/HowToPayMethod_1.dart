import 'package:flutter/material.dart';
import 'package:medcourse/Services/courseService.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Models/AppSettings.dart';

class HowToPayMethod_1 extends StatelessWidget {
  const HowToPayMethod_1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    PageController page = PageController();
    return FutureBuilder<List<String>>(
      future: courseService().getHowPayMethode1(),
      builder: (context, snapchat) {
        if (snapchat.connectionState == ConnectionState.done) {
          print(snapchat.data);
          return SafeArea(
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                PageView.builder(
                  itemCount: 5,
                  controller: page,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: size.width,
                      height: size.height,
                      child: Image.network(
                        snapchat.data![index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: SmoothPageIndicator(
                      controller: page,
                      count: 5,
                      effect: const ExpandingDotsEffect(
                        radius: 8,
                        spacing: 10,
                        dotHeight: 12,
                        dotWidth: 12,
                      )),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
