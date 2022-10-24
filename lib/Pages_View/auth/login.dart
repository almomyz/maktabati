import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:maktabati2/Pages_View/auth/signup.dart';
import 'package:maktabati2/Pages_View/auth/valid.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../component/crud.dart';
import '../../const/CustomPageRoute.dart';
import '../../const/constance.dart';
import '../../const/linkapi.dart';
import '../../main.dart';
import '../Main_pages/Navigtion_Bar.dart';
import 'customtextform.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formstate = GlobalKey();
bool _show_password =false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Crud crud = Crud();

  bool isLoading = false;

  login() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await crud.postRequest(
          linkLogin, {"email": email.text, "password": password.text});
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        print(response['data']['user_id'].toString());
        print(response['data']['user_email']);
        print( response['data']['user_name']);
        sharedPref.setString("id", response['data']['user_id'].toString());
        sharedPref.setString("username", response['data']['user_name']);
        sharedPref.setString("email", response['data']['user_email']);
        Navigator.push(
            context,
            new CustomPageRoute(child:  BottomNavBar()));
      } else {
        AwesomeDialog(
            context: context,
            title: "تنبيه",
            body: Text(
                "البريد الالكتروني او كلمة المرور خطأ او الحساب غير موجود"))
          ..show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(10),
      child: isLoading == true
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                Form(
                  key: formstate,
                  child: Column(
                    children: [
                      

                      SizedBox(height: 30,),
                      Image.asset(
                        "assets/logo.png",
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(height: 30,),
                      Row(textDirection: TextDirection.rtl,children:[

                        SizedBox(width: 20,),

                        Text("مرحباً بعودتك",textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: primary_Color,fontSize: 25,fontWeight: FontWeight.bold)),

                      ]

                      ),
                      Row(textDirection: TextDirection.rtl,children:[

                        SizedBox(width: 20,),

                        Text("سجل الدخول للمتابعه",textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),

                      ]

                      ),
                      SizedBox(height: 30,),
                      CustTextFormSign(
                         icon: Icon(Icons.email,color: primary_Color,),
                        valid: (val) {
                          return validInput(val!, 3, 20);
                        },
                        mycontroller: email,
                        hint: "البريد الاكتروني",
                      ),
                      TextFormField(

                        textAlign: TextAlign.right,
                        validator: (val) {
                          return validInput(val!, 3, 10);
                        },
                        obscureText: !this._show_password,
                        controller: password,
                        decoration: InputDecoration(
                            prefixIcon: IconButton(icon: Icon(Icons.remove_red_eye),onPressed:(){
                              setState(() {
                                this._show_password=!this._show_password;
                              });
                            },color: this._show_password?Colors.blue:Colors.grey, ),
                            suffixIcon:Icon(Icons.lock,color: primary_Color),

                            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                            hintText: "كلمه المرور",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(10)))),


                      ),

              SizedBox(height: 20,),

                      MaterialButton(

                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: 70, vertical: 10),
                        onPressed: () async {
                           await login();


                        },
                        child: Text("دخول"),
                      ),


                      Container(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[


                          InkWell(
                            child: Text("سجل الان",style: TextStyle( fontWeight: FontWeight.bold,color: primary_Color),),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  new CustomPageRoute(child:  SignUp()));
                            },
                          ),
                          SizedBox(width: 7,),
                          Text("لیس لدیك حساب؟"),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
    ));
  }


  Future openfile({required String url, required String? fileName}) async{
    final file=     await downlodfile(url, fileName!);
    if(file ==null)return null;
    print('path  ${file.path}' );
    OpenFile.open(file.path);


  }




  Future<File?> downlodfile(String url, String name) async{

    final appStorge=await getApplicationDocumentsDirectory();
    final file=File('${appStorge.path}/$name');
    try {
      final response = await Dio().get(url,
        options: Options(responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: 0,

        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    }
    catch(e){
      return null;
    }
  }
}
