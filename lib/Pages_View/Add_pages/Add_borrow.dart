import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:maktabati2/component/User_API.dart';
import 'package:maktabati2/component/crud.dart';

import '../../Models/M_View_users.dart';
import '../../const/linkapi.dart';

class Add_borrow extends StatefulWidget {
  final id;
   Add_borrow({Key? key, required this.id}) : super(key: key);

  @override
  State<Add_borrow> createState() => _Add_borrowState();
}

class _Add_borrowState extends State<Add_borrow> with Crud{
  List <String> Users_name =[];
  List<Users> books=[] ;
  String value_name=" اختيار  اسم المستعير ";
  DateTime dateR1 = DateTime(2022,9,10);
  DateTime dateR2 = DateTime(2022,9,10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // Colors.black12, Colors.black26,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 170, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),


          child: Column(
              children: [
                SafeArea(child:
                const Text('إعارة كتاب',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueAccent
                  ),),),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 45.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      Text(' اسم المستعير',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent
                        ) ,),
                      DropdownButton<String>(iconSize: 30,isExpanded: true,hint: Text(value_name),items: Users_name.map(buildMenuItem).toList(), onChanged: (value)=> setState(() {
                        this.value_name=value!;
                      })),


                      Text('تاریخ الاستعارة',
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
                            onPressed:()=>SelectDate1(),
                          ),
                        ),
                      ),

                      Text('تاریخ الاعادة',
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
                            onPressed:()=>SelectDate2(),
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

                              if(dateR1.isAfter(dateR2)){

                                AwesomeDialog(dialogType: DialogType.info,context: context,title: "تنبيه",body: Text("لايمكن ان يكون تاريخ الاعاده قبل تاريخ الاعاره"))..show();

                              }else{

                              var response = await postRequest(add_borrow, {
                                "id":widget.id,
                                "return_date":"${dateR1.year}-${dateR1.month}-${dateR1.day}",
                                "borrow_date":"${dateR2.year}-${dateR2.month}-${dateR2.day}",
                                "user_name":value_name
                              }

                             );
                              print(response);
                              if(response["status"]=="success")
                              {

                                AwesomeDialog(dialogType: DialogType.success,context: context,title: "مبروك",body: Text("تم الاستعاره بنجاح"))..show();


                              }
                              if(response["status"]=="fail"){

                                AwesomeDialog(dialogType: DialogType.error,context: context,title: "تنبيه",body: Text("خطاء لم يتم الحذف "))..show();

                              }

                            }},
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

    );;
  }


  Future init_Users() async {
    final books = await User_API.getBooks('');

    setState(() => this.books = books);

    for(int i=0;i<books.length;i++){

      final   book = books[i];
      Users_name.add(book.user_name);

    }
    print(Users_name);

  }

  DropdownMenuItem<String> buildMenuItem(String Item)=>
      DropdownMenuItem(value: Item,child: Text(Item),);


  @override
  void initState() {
    init_Users();
  }

  SelectDate1()async{
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


  SelectDate2()async{
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
