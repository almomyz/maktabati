import 'package:flutter/material.dart';
import 'package:maktabati2/Pages_View/auth/login.dart';

import '../../const/CustomPageRoute.dart';

class Success extends StatefulWidget {
  Success({Key? key}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text("تم انشاء الحساب بنجاح الان يمكنك تسجيل الدخول" , style: TextStyle(fontSize: 20),),
          ),
          MaterialButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                Navigator.push(
                    context,
                    new CustomPageRoute(child:  Login()));
              },
              child: Text("تسجيل الدخول"))
        ],
      ),
    );
  }
}
