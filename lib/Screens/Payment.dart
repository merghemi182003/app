import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'HowToPayMethod_1.dart';
import '../Models/AppSettings.dart';
import '../Services/userService.dart';
import '../Widgets/Dialog.dart';
import 'HowToPayMethod_2.dart';

class Payment extends StatefulWidget {
  const Payment({ Key? key }) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }
  TextEditingController numberConttroler = TextEditingController();
  TextEditingController pinConttroler = TextEditingController();
  TextEditingController fullNameBMConttroler = TextEditingController();
  TextEditingController fullNamecppConttroler = TextEditingController();
  final GlobalKey<FormState> _form1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _form2 = GlobalKey<FormState>();
  File? imageSrc;
  late String dialogMsg;
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new , color:  AppSettings.dark ? Colors.white : Colors.black,),

        ),
        bottom: TabBar(
          controller: _tabController,
          tabs:  [
            Tab(child: Text('Methode 1',style: TextStyle(
                color: AppSettings.dark ? Colors.white : Colors.black,
                fontSize: size.width * 0.04,
                fontFamily: 'Metropolis',
                fontWeight: FontWeight.bold),),),
            Tab(child: Text('Methode 2',style: TextStyle(
                color: AppSettings.dark ? Colors.white : Colors.black,
                fontSize: size.width * 0.04,
                fontFamily: 'Metropolis',
                fontWeight: FontWeight.bold),),),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: AppSettings.dark? const Color(0xff0D0D0D) : const Color(0xffF5F6FF),
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: TabBarView(
                controller: _tabController,
                children: [
                  ModalProgressHUD(
                    color : Colors.transparent,
                    inAsyncCall: _loading,
                    progressIndicator: const CircularProgressIndicator(color: Colors.white,),
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 10, left: 30, right: 30),
                      child: Form(
                        key: _form1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: size.height * 0.03,),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const HowToPayMethod_1()));
                              },
                              child: Text(
                                'Comment payer? (Methode 1)',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: size.width * 0.04,
                                    fontFamily: 'Metropolis',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: size.height * 0.04,),
                            Card(
                              elevation: 5,
                              color: AppSettings.dark
                                  ? const Color.fromARGB(240, 20, 20, 20)
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(300),
                              ),
                              child: TextFormField(
                                controller: fullNameBMConttroler,
                                validator: (_){
                                  dialogMsg = '';
                                  if(fullNameBMConttroler.text.isEmpty){
                                    dialogMsg = 'SVP entrer nom et prénom';
                                  }
                                },
                                style: TextStyle(
                                  fontSize: size.height * 0.019,
                                  color: AppSettings.dark
                                      ? Colors.white
                                      : const Color.fromARGB(240, 20, 20, 20),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Baridimob Nom et Prénom',
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(300),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: AppSettings.dark
                                            ? BorderStyle.none
                                            : BorderStyle.solid),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(300),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: AppSettings.dark
                                            ? BorderStyle.none
                                            : BorderStyle.solid),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.03,),
                            Card(
                              elevation: 5,
                              color: AppSettings.dark
                                  ? const Color.fromARGB(240, 20, 20, 20)
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(300),
                              ),
                              child: TextFormField(
                                controller: numberConttroler,
                                validator: (_){
                                  if(numberConttroler.text.isEmpty){
                                    dialogMsg = 'SVP entrer le numéro du retrait';
                                  }
                                  else if(numberConttroler.text.length!=10){
                                    dialogMsg = 'SVP entrer un numéro du retrait valide';
                                  }
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontSize: size.height * 0.019,
                                  color: AppSettings.dark
                                      ? Colors.white
                                      : const Color.fromARGB(240, 20, 20, 20),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Numéro du retrait',
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(300),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: AppSettings.dark
                                            ? BorderStyle.none
                                            : BorderStyle.solid),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(300),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: AppSettings.dark
                                            ? BorderStyle.none
                                            : BorderStyle.solid),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.03,),
                            Card(
                              elevation: 5,
                              color: AppSettings.dark
                                  ? const Color.fromARGB(240, 20, 20, 20)
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(300),
                              ),
                              child: TextFormField(
                                controller: pinConttroler,
                                validator: (_){
                                  if(pinConttroler.text.isEmpty){
                                    dialogMsg = 'SVP entrer le code PIN';

                                  }
                                  else if(pinConttroler.text.length!=4){
                                    dialogMsg = 'SVP entrer un code PIN valide';
                                  }
                                },
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontSize: size.height * 0.019,
                                  color: AppSettings.dark
                                      ? Colors.white
                                      : const Color.fromARGB(240, 20, 20, 20),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'code PIN',
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(300),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: AppSettings.dark
                                            ? BorderStyle.none
                                            : BorderStyle.solid),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(300),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: AppSettings.dark
                                            ? BorderStyle.none
                                            : BorderStyle.solid),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.05,),
                            SizedBox(
                              width: double.infinity,
                              height: size.height * 0.07 > 50 ? size.height * 0.07 : 50,
                              child: ElevatedButton(
                                onPressed: ()async{
                                  (_form1.currentState?.validate())!;
                                  if(dialogMsg.isNotEmpty){
                                    dialog(context, dialogMsg);
                                  }
                                  else{
                                    setState(() {
                                      _loading = true;
                                    });
                                    if(userService.user.request!){
                                      dialog(context, 'Vous ne pouvez pas rajouter une autre demande avant de traiter la précédante');
                                    }
                                    else{
                                      print('object');
                                      if(await userService().payMethod_1(fullName: fullNameBMConttroler.text, number: numberConttroler.text, pin: pinConttroler.text)){
                                        dialog(context, 'Votre demande a été envoyé on va la traiter dans les brefs delais');
                                      }
                                      else{
                                        dialog(context, 'Erreur inconnue');
                                      }
                                    }
                                    setState(() {
                                      _loading = false;
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder()),
                                child: const Text('Valider'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ModalProgressHUD(
                    color : Colors.transparent,
                    inAsyncCall: _loading,
                    progressIndicator: const CircularProgressIndicator(color: Colors.white,),
                    child: Padding(
                      padding:
                      const EdgeInsets.only(top: 10, left: 30, right: 30),
                      child: Form(
                        key: _form2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: size.height * 0.03,),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const HowToPayMethod_2()));
                              },
                              child: Text(
                                'Comment payer? (Methode 2)',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: size.width * 0.04,
                                    fontFamily: 'Metropolis',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: size.height * 0.04,),
                            Card(
                              elevation: 5,
                              color: AppSettings.dark
                                  ? const Color.fromARGB(240, 20, 20, 20)
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(300),
                              ),
                              child: TextFormField(
                                controller: fullNamecppConttroler,
                                validator: (_){
                                  dialogMsg = '';
                                  if(fullNamecppConttroler.text.isEmpty){
                                    dialogMsg = 'SVP entrer nom et prénom';
                                  }
                                },
                                style: TextStyle(
                                  fontSize: size.height * 0.019,
                                  color: AppSettings.dark
                                      ? Colors.white
                                      : const Color.fromARGB(240, 20, 20, 20),
                                ),
                                decoration: InputDecoration(
                                  hintText: 'Nom et Prénom',
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(300),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: AppSettings.dark
                                            ? BorderStyle.none
                                            : BorderStyle.solid),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(300),
                                    borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1,
                                        style: AppSettings.dark
                                            ? BorderStyle.none
                                            : BorderStyle.solid),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.03,),
                            SizedBox(
                              width: double.infinity,
                              height: size.height * 0.07 > 50 ? size.height * 0.07 : 50,
                              child: ElevatedButton(
                                onPressed: ()async{
                                  (_form2.currentState?.validate())!;
                                  if(imageSrc==null){
                                    dialogMsg = "SVP ajouter le BON";
                                  }
                                  if(dialogMsg.isNotEmpty){
                                    dialog(context, dialogMsg);
                                  }
                                  else{
                                    setState(() {
                                      _loading = true;
                                    });
                                    if(userService.user.request!){
                                      dialog(context, 'Vous ne pouvez pas rajouter une autre demande avant de traiter la précédante');
                                    }
                                    else{
                                      if(await userService().payMethod_2(fullName: fullNamecppConttroler.text, image: imageSrc!)){
                                        dialog(context, 'Votre demande a été envoyé on va la traiter dans les brefs delaisy');
                                      }
                                      else{
                                        dialog(context, 'Erreur inconnue');
                                      }
                                    }
                                    setState(() {
                                      _loading = false;
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder()),
                                child: const Text('Valider'),
                              ),
                            ),
                            SizedBox(height: size.height * 0.03,),
                            imageSrc!=null? Image.file(imageSrc!,fit: BoxFit.fill,) : const SizedBox()
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: ()async{await _pickImages();},child: const Icon(Icons.add),),
    );
  }
  Future<void> _pickImages() async {
    final XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery); // Call pickMultiImage() to select multiple images
    if (image != null) {
      setState(() {
        imageSrc = File(image.path);
      });
    }
  }
}
