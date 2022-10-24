import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:maktabati2/component/crud.dart';
import 'package:maktabati2/const/linkapi.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../Models/M_Sarch_Author.dart';
import '../../Models/M_Sarch_Categories.dart';
import '../../Models/M_Sarch_Publishing.dart';
import '../../component/Author_Api.dart';
import '../../component/Categories_Api.dart';
import '../../component/Publishing_Api.dart';
import '../../const/constance.dart';
class Add_Book extends StatefulWidget {
  const Add_Book({Key? key}) : super(key: key);
  @override
  State<Add_Book> createState() => _Add_BookState();
}
class _Add_BookState extends State<Add_Book> with Crud{
  List <String> Cat_name =[];
  List <String> auth_name =[];
  List <String> pub_name =[];
  int Langnum=1;
  List<Categories> books=[] ;
  List<Author> auth=[] ;
  List<Publishing> pub=[] ;
  String Lang="الغات";
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  var image;
  late File? file= image;
  var imgPicker= ImagePicker();
  var urlimg;
  var imgname;
  DateTime dateR = DateTime(2022,9,10);

  String att_type="نوع الملحق";
  final pages_no = TextEditingController();
  final auther = TextEditingController();
  final location = TextEditingController();
  final subtitle = TextEditingController();
  final description = TextEditingController();
  final title = TextEditingController();
  final price = TextEditingController();
  final edition_no = TextEditingController();
  final publication_date = TextEditingController();
  final depository_no = TextEditingController();
  final dewey_no = TextEditingController();
  final isbn = TextEditingController();
  final num_of_copies = TextEditingController();
  final rating = TextEditingController();
  final size = TextEditingController();
  final work_on_book = TextEditingController();
  String format = " اختار صيغه الكتاب";
  bool isLoding = false;
  String value_cat=" اختيار  القسم ";
  String value_auth=" اختيار  المؤلف ";
  String value_pub=" اختيار  دار النشر ";

  @override
  Widget build(BuildContext context) =>isLoding ?  Scaffold(body:  Center(child: CircularProgressIndicator(backgroundColor: Colors.white,strokeWidth: 10,color:primary_Color,semanticsLabel: "جاري الاضافه", ),))
      :
     Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('اضافة كتاب'),
        centerTitle: true,
      ),
      body:  Container(
        child: Column(
          children: [
            Expanded(
              child: Stepper(
                type: stepperType,
                physics: ScrollPhysics(),
                currentStep: _currentStep,
                onStepTapped: (step) => tapped(step),
                onStepContinue:  continued,
                onStepCancel: cancel,
                steps: <Step>[
                  Step(
                    title:Text('عن الكتاب',),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
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
                                          child: file==null ? image=  CircleAvatar(
                                            maxRadius: 70 ,
                                            child: Icon(Icons.note_add,size: 100  ,color: Colors.white),
                                            backgroundColor: Colors.blue,

                                          ):Image.file(file!,width:150 ,fit: BoxFit.fill ,),
                                        ),
                                      ),
                                    ))),
                          ),
                        ),
                        Text('عنوان الكتاب',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        TextFormField(
                          controller: title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                            hintText: "كتاب فن اللامبالاة",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),
                        Text('العنوان الفرعي',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        TextFormField(
                          controller: subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                            hintText: "لعیش حیاه تخالف المألوف",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),
                        Text('وصف الكتاب',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        TextFormField(
                          controller: description,
                          textAlign: TextAlign.center,
                          style: TextStyle(

                              height: 0.1
                          ),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(),
                            hintText: "وصف للكتاب",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),
                        Text('القسم',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                     SizedBox(height: 10,),
                     DropdownButton<String>(iconSize: 30,isExpanded: true,hint: Text(value_cat),items: Cat_name.map(buildMenuItem).toList(), onChanged: (value)=> setState(() {
                       this.value_cat=value!;
                     }))
,
                        SizedBox(height: 10,),
                        Text('موقع الكتاب',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        TextFormField(
                          controller:location ,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                            icon: Icon(Icons.upload_outlined,color: Colors.blue,),

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),
                        Text('السعر',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: price,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                            hintText: "20",
                            icon: Icon(Icons.price_check,color: Colors.blue),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),

                        Text('عدد الصفحات',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: pages_no,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                            hintText: "70",

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),


                        Text('الحجم',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),
                        TextFormField(
                          keyboardType: TextInputType.number,

                          controller: size,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                            hintText: "70 MB",

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),
                        Text('صيغه الكتاب',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),

                        ExpansionTile(


                          title: Text('$format'),
                          children: [
                            InkWell(
                              onTap: (){

                              },
                              child: ListTile(
                                  onTap: (){
                                    setState(() {

                                      format="PDF";
                                    });
                                  },
                                  leading: CircleAvatar(
                                    child:Icon(Icons.picture_as_pdf,color: primary_Color),
                                    backgroundColor: Colors.white,
                                  ),
                                  title: Text('PDF')),
                            ),
                            ListTile(
                                onTap: (){
                                  setState(() {
                                    format="ورقي";

                                  });
                                },
                                leading: CircleAvatar(
                                  child: Icon(Icons.library_books,color: primary_Color,),
                                  backgroundColor: Colors.white,
                                ),
                                title: Text('ورقي')),
                          ],
                        ),
                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 0 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: new Text('تأليف ونشر'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('المؤلف',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),


                        DropdownButton<String>(iconSize: 30,isExpanded: true,hint: Text(value_auth),items: auth_name.map(buildMenuItem).toList(), onChanged: (value)=> setState(() {
                          this.value_auth=value!;
                        }))
                        ,
                        SizedBox(height: 10,),

                        Text('العمل على الكتاب',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),

                        TextFormField(
                          controller: work_on_book,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                             hintText:"مؤلف" ,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),
                        Text('اللغه',
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

                        Text('دار النشر',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),

                        SizedBox(height: 10,),
                        DropdownButton<String>(iconSize: 30,isExpanded: true,hint: Text(value_pub),items: pub_name.map(buildMenuItem).toList(), onChanged: (value)=> setState(() {
                          this.value_pub=value!;
                        }))
                        ,
                        SizedBox(height: 10,),

                        Text('تاریخ النشر',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),

                        Center(
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
                            onPressed:()=>SelectDate(context),
                          ),
                        ),




                      ],
                    ),
                    isActive: _currentStep >= 0,
                    state: _currentStep >= 1 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: new Text('ترقيم وتصنيف'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('رقم النسخة',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),

                        TextFormField(
                          keyboardType: TextInputType.number,

                          controller: num_of_copies,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                          hintText: "14",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),

                        Text('رقم الجزء',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),

                        TextFormField(
                          keyboardType: TextInputType.number,

                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                              hintText: "4",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),

                        Text('رقم الطبعة',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),


                        TextFormField(
                          keyboardType: TextInputType.number,

                          controller: edition_no,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                             hintText: "2",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),

                        Text('رقم الإیداع',
                          style: TextStyle(


                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),

                        TextFormField(
                          keyboardType: TextInputType.number,

                          controller: depository_no,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                                 hintText: "1353545343545",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),

                        Text('الترقیم الدولي',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),

                        TextFormField(
                          keyboardType: TextInputType.number,

                          controller: isbn,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                             hintText: "987464646464.323",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),

                        Text('التصنیف الدیوي',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),

                        TextFormField(
                          keyboardType: TextInputType.number,

                          controller: dewey_no,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                             hintText: "1.23.46.65",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),

                        Text('التقييم',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),

                        TextFormField(
                          keyboardType: TextInputType.number,
                          controller: rating,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                            hintText: "4",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),


                      ],
                    ),
                    isActive:_currentStep >= 0,
                    state: _currentStep >= 2 ?
                    StepState.complete : StepState.disabled,
                  ),
                  Step(
                    title: new Text('اختياري'),
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text('إسم السلسلھ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),

                        TextFormField(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                             hintText: "سلسلھ عالم الصغار",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),

                        Text('رقم الكتاب في السلسلة',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),

                        TextFormField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                                hintText: "20",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),

                        Text('إسم الملحق',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),

                        TextFormField(
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                            hintText: "كتیب تعلیمات",

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),

                        ExpansionTile(


                          title: Text('$att_type'),
                          children: [
                            InkWell(
                              onTap: (){

                              },
                              child: ListTile(
                                  onTap: (){
                                    setState(() {

                                      att_type="كتيب";
                                    });
                                  },
                                  leading: CircleAvatar(
                                    child:Icon(Icons.menu_book,color: primary_Color),
                                    backgroundColor: Colors.white,
                                  ),
                                  title: Text('كتيب')),
                            ),
                            ListTile(
                                onTap: (){
                                  setState(() {
                                    att_type="CD";

                                  });
                                },
                                leading: CircleAvatar(
                                  child: Icon(Icons.play_circle_fill_rounded,color: primary_Color,),
                                  backgroundColor: Colors.white,
                                ),
                                title: Text('CD')),
                          ],
                        ),

                        Text('موقع الملحق',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent
                          ) ,),

                        TextFormField(
                          style: TextStyle(
                              height: 0.1
                          ),
                          decoration: InputDecoration(
                           icon: Icon(Icons.upload_outlined,color: Colors.blue,),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                  color: Colors.blueAccent
                              ),
                            ),


                            filled: true,
                            fillColor: Colors.grey.shade200,
                          ),
                        ),



                      ],
                    ),
                    isActive:_currentStep >= 0,
                    state: _currentStep >= 3 ?
                    StepState.complete : StepState.disabled,
                  ),

                ],


                controlsBuilder: (BuildContext context, ControlsDetails controls) {
                  return Container(
                    margin: EdgeInsets.only(top: 50.0),
                    child: Row(
                      children: <Widget>[




                        if(_currentStep != 0 )
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(

                                  RoundedRectangleBorder(

                                    borderRadius: BorderRadius.circular(10.0)
                                    ,
                                  )),
                                  backgroundColor: MaterialStateProperty.all<
                                      Color>(Colors.white)),
                              onPressed: controls.onStepCancel,
                              child: const Text('السابق',
                                  style: TextStyle(color: Colors.blue)),
                            ),
                          ),

                        const SizedBox(
                          width: 12.0,
                        ),
                        if(_currentStep == 3)

                          Expanded(
                            child: ElevatedButton(

                              style: ButtonStyle(  shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(

                                  RoundedRectangleBorder(

                                    borderRadius: BorderRadius.circular(10.0)
                                    ,
                                  )),backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
                              onPressed: ()async{

                                setState(() => isLoding = true);
                                await Future.delayed(const Duration(seconds: 2));
                                var response = await postRequestWithFile(add_book, {
                                  "pages_no":pages_no.text,
                                  "price":price.text,
                                  "description":description.text,
                                  "subtitle":subtitle.text,
                                  "title":title.text,
                                  "publication_date":"${dateR.year}-${dateR.month}-${dateR.day}",
                                  "edition_no":edition_no.text,
                                  "depository_no":depository_no.text,
                                  "dewey_no":dewey_no.text,
                                  "isbn":isbn.text,
                                  "cat_name":value_cat.toString(),
                                  "num_of_copies":num_of_copies.text,
                                  "rating":rating.text,
                                  "size":size.text,
                                  "format":format,
                                  "work_on_book" :work_on_book.text,
                                  "pub_name":value_pub.toString(),
                                  "auth_name":value_auth.toString()
                                },file!);

                                setState(() => isLoding = false);


                                  AwesomeDialog(dialogType: DialogType.success,context: context,title: "مبروك",body: Text("تم اضافه مؤلف بنجاح"))..show();




                                  AwesomeDialog(dialogType: DialogType.error,context: context,title: "تنبيه",body: Text("خطاء اضافه مؤلف "))..show();


                                print(response);

                              },
                              child: const Text('تم',style: TextStyle(color: Colors.white)),

                            ),
                          ),


                          const SizedBox(
                            width: 12.0,
                          ),

                        if(_currentStep != 3)
                          Expanded(
                            child: ElevatedButton(

                              style: ButtonStyle(shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(

                                  RoundedRectangleBorder(

                                    borderRadius: BorderRadius.circular(10.0)
                                    ,
                                  )),
                                  backgroundColor: MaterialStateProperty.all<
                                      Color>(Colors.blue)),
                              onPressed: controls.onStepContinue,
                              child: const Text('التالي',
                                  style: TextStyle(color: Colors.white)),

                            ),
                          ),


                      ],
                    ),
                  );
                },



                // // controlsBuilder: (context,{onStepContinue,onStepCancel}){
                // //   return Container(
                // //     margin: EdgeInsets.only(top: 50),
                // //     child: Row(
                // //       children: [
                // //         Expanded(child:
                // //         ElevatedButton(onPressed: onStepContinue,
                // //             child: Text('data'))),
                // //         SizedBox(width: 10.0,),
                // //         Expanded(child:
                // //         ElevatedButton(onPressed: onStepCancel,
                // //             child: Text('data')))
                // //       ],
                // //     ),
                // //   );
                // },

              ),
            ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.list),
        onPressed: switchStepsType,
      ),

    );



  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 3 ?
    setState(() => _currentStep += 1): null;
  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }
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

 DropdownMenuItem<String> buildMenuItem(String Item)=>
     DropdownMenuItem(value: Item,child: Text(Item),);



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init_cat();
    init_auth();
    init_pub();

  }

  Future init_cat() async {
    final books = await Categories_Api.getBooks('');

    setState(() => this.books = books);

    for(int i=0;i<books.length;i++){

    final   book = books[i];
       Cat_name.add(book.cat_name);

    }
    print(Cat_name);

  }
  Future init_auth() async {
    final books = await AuthorApi.getBooks('');

    setState(() => this.auth = books);

    for(int i=0;i<books.length;i++){

    final   book = books[i];
       auth_name.add(book.author_name);

    }
    print(auth_name);

  }
  Future init_pub() async {
    final books = await Publishing_Api.getBooks('');

    setState(() => this.pub = books);

    for(int i=0;i<books.length;i++){

    final   book = books[i];
       pub_name.add(book.name);

    }
    print(pub_name);

  }

  SelectDate(context)async{
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


