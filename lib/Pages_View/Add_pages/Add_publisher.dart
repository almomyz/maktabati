import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:maktabati2/component/crud.dart';

import '../../const/linkapi.dart';

class Add_Publisher extends StatefulWidget {
  const Add_Publisher({Key? key}) : super(key: key);

  @override
  State<Add_Publisher> createState() => _Add_PublisherState();
}

class _Add_PublisherState extends State<Add_Publisher> with Crud{
  @override
  int Langnum=1;
  String Lang="الغات";
  final LangNum = TextEditingController();
  final sequential_deposit_no = TextEditingController();
  final owner = TextEditingController();
  final establishment_date = TextEditingController();
  final pub_name = TextEditingController();
DateTime dateR = DateTime(2022,9,10);

  Widget build(BuildContext context) {

    return Scaffold(
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
                  const Text('اضافة دار النشر',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent
                    ),),),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 45.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('اسم دار النشر',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        SizedBox(

                          child: TextField(
                           controller: pub_name,
                            autofocus: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Colors.black54,),
                            // style: TextStyle(fontSize: 10.0,height: 2.0,color: Colors.red),
                            decoration: InputDecoration(
                              hintText: "  دار المعرفة و العلوم   ",
                              contentPadding: EdgeInsets.symmetric(vertical: 6.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              fillColor: Colors.grey[100],
                              filled: true,
                            ),
                          ),
                        ),


                        Text('رقم الإجازة المتسلسل',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        SizedBox(

                          child: TextField(
                              controller: sequential_deposit_no,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Colors.black54,),
                            // style: TextStyle(fontSize: 10.0,height: 2.0,color: Colors.red),
                            decoration: InputDecoration(
                              hintText: "23476590",hintStyle: TextStyle(
                            ),
                              contentPadding: EdgeInsets.symmetric(vertical: 6.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),

                              fillColor: Colors.grey[100],
                              filled: true,
                            ),
                          ),
                        ),
                        Text('تاریخ التأسیس',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        SizedBox(

                          child: Center(
                            child: TextButton(
                              child: Text("${dateR.year}-${dateR.month}-${dateR.day}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                ),),
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent,),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              onPressed:SelectDate,
                            ),
                          ),
                        ),
                        Text('مؤسس دار النشر',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        SizedBox(
                          child: TextField(
                            controller: owner,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Colors.black54,),
                            // style: TextStyle(fontSize: 10.0,height: 2.0,color: Colors.red),
                            decoration: InputDecoration(
                              hintText: "نجیب محفوظ",
                              contentPadding: EdgeInsets.symmetric(vertical: 6.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              fillColor: Colors.grey[100],
                              filled: true,
                            ),
                          ),
                        ),
                        Text('لغات النشر',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        ExpansionTile(


                          title: Text('$Lang'),
                          children: [
                            InkWell(
                              onTap: (){

                              },
                              child: ListTile(
                                onTap: (){
                                  setState(() {
                                    Langnum=1;
                                    Lang="عربي";
                                  });
                                },
                                  leading: CircleAvatar(
                                    child: Text('AR'),
                                    backgroundColor: Colors.white,
                                  ),
                                  title: Text('عربي')),
                            ),
                            ListTile(
                                  onTap: (){
                                    setState(() {
                                      Lang="انجليزي";
                                      Langnum=2;
                                    });
                                  },
                                leading: CircleAvatar(
                                  child: Text('EN'),
                                  backgroundColor: Colors.white,
                                ),
                                title: Text('انجليزي')),
                          ],
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
                                var response = await postRequest(add_publisher, {
                                     "pub_name":pub_name.text,
                                     "LangNum":"$Langnum",
                                  "sequential_deposit_no":sequential_deposit_no.text
                                  ,"owner":owner.text,
                                  "establishment_date":"${dateR.year}-${dateR.month}-${dateR.day}"
                                }

                                );
                                  print(response);
                                if(response["status"]=="success")
                                {

                                  AwesomeDialog(dialogType: DialogType.success,context: context,title: "مبروك",body: Text("تم اضافه دار نشر بنجاح"))..show();


                                }
                                if(response["status"]=="fail"){

                                  AwesomeDialog(dialogType: DialogType.error,context: context,title: "تنبيه",body: Text("خطاء لم يتم الحذف "))..show();

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
  SelectDate()async{
   DateTime? newDateRange =await showDatePicker(
         context: context,
         initialDate: dateR,
         firstDate: DateTime(1900),
       lastDate: DateTime(2100),

     );

   if(newDateRange==null)return;
   setState(() {
     dateR=newDateRange;
   });
  }
}
