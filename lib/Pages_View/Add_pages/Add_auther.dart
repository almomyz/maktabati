import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:maktabati2/component/crud.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../const/Laoding.dart';
import '../../const/constance.dart';
import '../../const/linkapi.dart';

class Add_auther extends StatefulWidget {
  const Add_auther({Key? key}) : super(key: key);

  @override
  State<Add_auther> createState() => _Add_autherState();
}

class _Add_autherState extends State<Add_auther> with Crud{
  var image;
  late File file= image;
  var imgPicker= ImagePicker();
  var urlimg;
  var imgname;
GlobalKey<FormState> formStute= GlobalKey();
  final author_deathday = TextEditingController();
  final author_birthday = TextEditingController();
  final author_profession = TextEditingController();
  final author_description = TextEditingController();
  final author_name = TextEditingController();
  final author_nationality = TextEditingController();
  bool isLoding = false;
  DateTime dateR1 = DateTime(2022,9,10);
  DateTime dateR2 = DateTime(2022,9,10);
  @override
  Widget build(BuildContext context) =>isLoding ?  Scaffold(body:  Center(child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 10,color:primary_Color,semanticsLabel: "جاري الاضافه", ),))
      :
     Container(
       child: Scaffold(
        backgroundColor: Colors.grey[200],
        // Colors.black12, Colors.black26,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),


            child: Column(
                children: [

                  SafeArea(child:
                  const Text('إضافة مؤلف',
                    style: TextStyle(
                        fontSize: 20,

                        color: Colors.blueAccent
                    ),),),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 45.0),
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: ()async{
                            await selectimg(context);
                          },
                          child: Center(
                            child: Container(
                                width: 140,
                                height: 140,
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                decoration: BoxDecoration(
                                    color: Colors.grey,

                                    borderRadius: BorderRadius.all(Radius.circular(100  ))
                                ),

                                child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(100  )),
                                    child: AspectRatio(
                                      aspectRatio: 16/9,
                                      child:
                                      Center(
                                        child: InkWell(
                                          onTap:()async{
                                            await selectimg(context);
                                          } ,
                                          child: image == null ? image=  CircleAvatar(
                                            maxRadius: 70 ,
                                            child: Icon(Icons.person_add_alt_1_rounded,size: 100  ,color: Colors.white),
                                            backgroundColor: Colors.blue,

                                          ):Image.file(file,width:150 ,fit: BoxFit.fill ,),),
                                      ),
                                    ))),
                          ),
                        ),
                        Text('إسم المؤلف',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        SizedBox(

                          child: TextField(
                            controller: author_name,
                            autofocus: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Colors.black54,),
                            // style: TextStyle(fontSize: 10.0,height: 2.0,color: Colors.red),
                            decoration: InputDecoration(
                              hintText: "محمود درویش",
                              contentPadding: EdgeInsets.symmetric(vertical: 6.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              fillColor: Colors.grey[100],
                              filled: true,
                            ),
                          ),
                        ),


                        Text('الجنسیة',
                          style: TextStyle(

                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        SizedBox(

                          child: TextField(
                          controller: author_nationality,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Colors.black54,),
                            // style: TextStyle(fontSize: 10.0,height: 2.0,color: Colors.red),
                            decoration: InputDecoration(
                              hintText: "مصري",
                              contentPadding: EdgeInsets.symmetric(vertical: 6.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),

                              fillColor: Colors.grey[100],
                              filled: true,
                            ),
                          ),
                        ),
                        Text('المھنة',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        SizedBox(
                          child: TextField(
                            controller:author_profession ,
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Colors.black54,),
                            // style: TextStyle(fontSize: 10.0,height: 2.0,color: Colors.red),
                            decoration: InputDecoration(
                              hintText:"مؤلف ومراجع" ,
                              contentPadding: EdgeInsets.symmetric(vertical: 6.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              fillColor: Colors.grey[100],
                              filled: true,
                            ),
                          ),
                        ),
                        Text('تاریخ المیلاد',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        SizedBox(
                          child: Center(
                            child: TextButton(
                              child: Text("${dateR1.year}-${dateR1.month}-${dateR1.day}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent,),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              onPressed:()=>SelectDate1(context),
                            ),
                          ),
                        ),
                        Text('تاریخ الوفاه',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        SizedBox(
                          child: Center(
                            child: TextButton(
                              child: Text("${dateR2.year}-${dateR2.month}-${dateR2.day}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent,),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              onPressed:()=>SelectDate2(context),
                            ),
                          ),
                        ),
                        Text('وصف قصیر',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        SizedBox(
                          child: TextField(
                            controller: author_description,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Colors.black54,),
                            // style: TextStyle(fontSize: 10.0,height: 2.0,color: Colors.red),
                            decoration: InputDecoration(
                              hintText: "وصف قصیر عن المؤلف",
                              contentPadding: EdgeInsets.symmetric(vertical: 6.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              fillColor: Colors.grey[100],
                              filled: true,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
                              ),
                              child: const Text("الغاء",
                                style: TextStyle(
                                    color: Colors.blueAccent
                                ),),
                            ),
                            TextButton(
                              child: Text('حفظ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent,),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              onPressed: () async{
                                setState(() => isLoding = true);
                                var response = await postRequestWithFile(add_auther, {
                                  "author_deathday":"${dateR2.year}-${dateR2.month}-${dateR2.day}",
                                  "author_birthday":"${dateR1.year}-${dateR1.month}-${dateR1.day}",
                                  "author_nationality":author_nationality.text,
                                  "author_profession":author_profession.text,
                                  "author_description":author_description.text,
                                  "author_name":author_name.text,

                                },file);
                                await Future.delayed(const Duration(seconds: 2));
                                setState(() => isLoding = false);
                                if(response["status"]=="success")


                                  AwesomeDialog(dialogType: DialogType.success,context: context,title: "مبروك",body: Text("تم اضافه مؤلف بنجاح"))..show();



                                if(response["status"]=="fail")

                                  AwesomeDialog(dialogType: DialogType.error,context: context,title: "تنبيه",body: Text("خطاء اضافه مؤلف "))..show();


                                print(response);

                              },
                            ),
                            // OutlinedButton(
                            //   onPressed: () {},
                            //   child: Text('حفظ'),
                            //     style: ButtonStyle(
                            //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            //             RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.circular(10.0),
                            //                 side: BorderSide(color: Colors.red)
                            //             )
                            //         )
                            //     )
                            // )
                            // OutlinedButton(
                            //   onPressed: null,
                            //   style: ButtonStyle(
                            //     shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0,))),
                            //   ),
                            //   child: const Text("الغاء",
                            //     style: TextStyle(
                            //         color: Colors.blueAccent
                            //     ),),
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ),

    ),
     );



  selectimg(context) async {
    var imgpiced= await imgPicker.getImage(source:ImageSource.gallery );
    if(imgpiced!=null){
      setState(() {
        file=File(imgpiced.path);
        imgname=basename(imgpiced.path);
      });

    }else{
      showTopSnackBar(
        context,
        CustomSnackBar.info(
            message:
            "لم يتم اختيار صوره ",backgroundColor: Colors.amber),
      );

    }

  }

  SelectDate1(context)async{
    DateTime? newDateRange =await showDatePicker(
      context: context,
      initialDate: dateR1,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),

    );

    if(newDateRange==null)return;
    setState(() {
      dateR1=newDateRange;
    });
  }


  SelectDate2(context)async{
    DateTime? newDateRange =await showDatePicker(
      context: context,
      initialDate: dateR2,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),

    );

    if(newDateRange==null)return;
    setState(() {
      dateR2=newDateRange;
    });
  }
}
