import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:maktabati2/component/crud.dart';
import 'package:maktabati2/const/linkapi.dart';

import '../../const/constance.dart';

class Add_Categories extends StatefulWidget {
  const Add_Categories({Key? key}) : super(key: key);

  @override
  State<Add_Categories> createState() => _Add_CategoriesState();
}

class _Add_CategoriesState extends State<Add_Categories> with Crud{
  @override
  final name=TextEditingController();
  bool isLoding = false;
  Widget build(BuildContext context)=>isLoding ?  Scaffold(body:  Center(child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 10,color:primary_Color,semanticsLabel: "جاري الاضافه", ),))
  :Scaffold(
      backgroundColor: Colors.grey[200],
      // Colors.black12, Colors.black26,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 250, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),


          child: Column(
              children: [
                SafeArea(child:
                const Text('إضافة قسم',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueAccent
                  ),),),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 45.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('إسم القسم',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent
                        ) ,),
                      SizedBox(

                        child: TextField(
               controller: name,
                          autofocus: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Colors.black54,),
                          // style: TextStyle(fontSize: 10.0,height: 2.0,color: Colors.red),
                          decoration: InputDecoration(
                            hintText: "التاریخ و الحضارة",
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
                          ), TextButton(

                            child: Text('حفظ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                              ),),
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent,),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ))),
                            onPressed: ()async {
                              setState(() => isLoding = true);
                              var response = await postRequest(add_Categories, {
                                "name":"${name.text}"
                              }

                              );
                              await Future.delayed(const Duration(seconds: 2));
                              setState(() => isLoding = false);
                              if(response["status"]=="success")
                              {

                                AwesomeDialog(dialogType: DialogType.success,context: context,title: "مبروك",body: Text("تم اضافه قسم بنجاح"))..show();


                              }
                              if(response["status"]=="fail"){

                                AwesomeDialog(dialogType: DialogType.error,context: context,title: "تنبيه",body: Text("خطاء لم اضافه قسم "))..show();

                              }
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

    );

}
