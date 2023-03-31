import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Models/AppSettings.dart';

class HowToPayMethod_2 extends StatelessWidget {
  const HowToPayMethod_2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    PageController page = PageController();
    List<String> images = [
      'https://scontent.fblj1-2.fna.fbcdn.net/v/t1.15752-9/334703904_538884354824839_6636467958713022831_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=ae9488&_nc_eui2=AeEafr_zhiLiKX3BXPDFm0P-aFDzk-5gt9loUPOT7mC32XwOWXfL47GNW3yGPA8nkC6QCgzGzEAMZMRwqNF38Lvh&_nc_ohc=K9g9iMYR4goAX9BLkZJ&_nc_ht=scontent.fblj1-2.fna&oh=03_AdShTKIxOwE-EQb6c4E-NX6_EYHt2mJi1IIkXj5yu-mpXA&oe=644D874D',
      'https://scontent.fblj1-1.fna.fbcdn.net/v/t1.15752-9/334334265_587096636678190_5900494107047222966_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=ae9488&_nc_eui2=AeHHLRW1qKaWa4bcJzwkz6u0i3Td9euITViLdN3164hNWOY9gO9LXXXFVq4DXT3-rq9h0JBwWWfxxBDym2VQysgC&_nc_ohc=v2PuWIQ__Q8AX8GOQoA&_nc_ht=scontent.fblj1-1.fna&oh=03_AdQF5VKtieH9ERAO0BD1Yw20b9BD_nyhdtOF-3eajmB4Ew&oe=644D5995'
    ];
    return SafeArea(
      child: Container(
        color: AppSettings.dark? const Color(0xff0D0D0D) : const Color(0xffF5F6FF),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
          child: Column(
            children: [
              const SizedBox(height: 15,),
              Text("Vous payez chez chaabane copy pres du mustapha ou chez rayan copy pres de  ISM BATNA , vous écrviez vos noms et vous signez puis vous photographier la liste ou vos BON POUR et les envoyer sur cette plate-forme",style: TextStyle(
              color: AppSettings.dark ? Colors.white : Colors.black,
              fontSize: size.height * 0.018,
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.bold,decoration: TextDecoration.none),),
              SizedBox(height: 15,),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    PageView.builder(
                      itemCount: images.length,
                      controller: page,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: size.width,
                          height: size.height,
                          child: Image.network(images[index],fit: BoxFit.contain,),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: SmoothPageIndicator(
                          controller: page,
                          count: images.length,
                          effect: const ExpandingDotsEffect(
                            radius: 8,
                            spacing: 10,
                            dotHeight: 12,
                            dotWidth: 12,
                          )),
                    ),
                  ],
                ),
              ),
            ],

          ),
        ),
      ),
    );
  }
}
