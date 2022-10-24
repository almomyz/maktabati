
import 'package:flutter/material.dart';
import 'package:maktabati2/Pages_View/auth/success.dart';
import 'package:maktabati2/Pages_View/auth/valid.dart';

import '../../component/crud.dart';
import '../../const/CustomPageRoute.dart';
import '../../const/constance.dart';
import '../../const/linkapi.dart';
import 'customtextform.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formstate = GlobalKey();
  Crud _crud = Crud();
  bool _show_password =false;
  bool isLoading = false;

  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signUp() async {
    if (formstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        Navigator.push(
            context,
            new CustomPageRoute(child:  Success()));
      } else {
        print("SignUp Fail");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading == true
            ? Center(child: CircularProgressIndicator())
            : Container(
                padding: EdgeInsets.all(10),
                child: ListView(
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

                          SizedBox(height: 20,),
                          Row(textDirection: TextDirection.rtl,children:[

                            SizedBox(width: 20,),

                            Text("أھلا بك",textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: primary_Color,fontSize: 25,fontWeight: FontWeight.bold)),

                          ]

                          ),
                          Row(textDirection: TextDirection.rtl,children:[

                            SizedBox(width: 20,),

                            Text("انشاء حساب جديد",textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),

                          ]

                          ),
                          SizedBox(height: 30,),

                          CustTextFormSign(
                              icon: Icon(Icons.person,color: primary_Color),
                            valid: (val) {
                              return validInput(val!, 3, 20);
                            },
                            mycontroller: username,
                            hint: "اسم المستخدم",
                          ),
                          CustTextFormSign(
                            icon: Icon(Icons.email,color: primary_Color),
                            valid: (val) {
                              return validInput(val!, 5, 40);
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
                              await signUp();
                            },
                            child: Text("إنشاء حساب"),
                          ),
                          Container(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:[


                              InkWell(
                                child: Text("تسجيل الدخول",style: TextStyle( fontWeight: FontWeight.bold,color: primary_Color),),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new CustomPageRoute(child:  Login()));
                                },
                              ),
                              SizedBox(width: 7,),
                              Text(" لدیك حساب؟"),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ));
  }
}
