import 'package:flutter/material.dart';

import '../Models/AppSettings.dart';

void dialog(BuildContext context, String msg) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppSettings.dark
              ? const Color(0xff252525)
              : const Color(0xffffffff),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          content: Text(
            msg,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: AppSettings.dark ? Colors.white : Colors.black,
                fontSize: 20,
                fontFamily: 'Metropolis',
                fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0,left: 10,right: 10),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text(
                    'Close',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ],
        );
      });
}