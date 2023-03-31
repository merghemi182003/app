import 'package:flutter/material.dart';

import '../Models/AppSettings.dart';

class AboutUS extends StatefulWidget {
  const AboutUS({Key? key}) : super(key: key);

  @override
  State<AboutUS> createState() => _AboutUSState();
}

class _AboutUSState extends State<AboutUS> {
  double _scale = 1.0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppSettings.dark? const Color(0xff0D0D0D) : const Color(0xffF5F6FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
          child: Column(
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
                    'À Propos de nous',
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
              Text("Décrocher une bonne spécialité est le rêve de tout étudiant en médecine et pour cela il est important d'avoir à par les bonnes sources de cours et de QCMs , un espace où vous pouvez travailler en équipe, d'échanger les idées et de se motiver Notre plate-forme vous offre l'occasion d'assister à des séances de visiconférance (avec Dr Merghemi Lazhar résident en ophtalmologie dans les hopitaux d'ALGER ) où on traitera ensemble  les examens récents d'externats et les dossiers cliniques du Résidanat  avec plein de rappels et d'astuces pour une bonne mémorisation.",
                  style: TextStyle(
                  fontSize: size.height * 0.02,
                  fontFamily: 'Metropolis',
                  color: AppSettings.dark
                      ? Colors.white
                      : Colors.black,
                  fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20,),
              InteractiveViewer(
                scaleEnabled: true,
                minScale: 0.5,
                maxScale: 4.0,
                scaleFactor: 2.0,
                child: Image.network(
                  'https://medcourse.s3.ir-thr-at1.arvanstorage.ir/résidanat.jpeg',
                  fit: BoxFit.contain,
                  scale: _scale,
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
