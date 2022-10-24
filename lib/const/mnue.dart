import 'package:flutter/material.dart';
import 'package:maktabati2/Pages_View/Main_pages/Categories_Page.dart';
import 'package:maktabati2/Pages_View/auth/login.dart';
import 'package:maktabati2/const/CustomPageRoute.dart';
import 'package:maktabati2/const/constance.dart';
import 'package:maktabati2/main.dart';

import '../Pages_View/Main_pages/Main_Page.dart';

class mnue extends StatelessWidget {

  const mnue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
   child: ListView(
     padding: EdgeInsets.zero
       ,children: [
     UserAccountsDrawerHeader(accountName: Text("مكتبتي"), accountEmail: Text("maktabati.gmail.com"),arrowColor: Colors.white,currentAccountPicture: CircleAvatar(
       child: ClipOval(

         child: Image.asset('assets/logo.png', ),
       ),
     )
       ,decoration: BoxDecoration(color: primary_Color),
       ),
     ListTile(
               focusColor: primary_Color,
       leading: Icon(Icons.home),
       title: Text(" القائمه الرئيسيه"),
       onTap :()=>Navigator.push(
           context,
    CustomPageRoute(  child: const Main_Page()))
     ),
             ListTile(
               leading: Icon(Icons.dashboard),
               title: Text("الاقسام"),
               onTap:()=>Navigator.push(
                   context,
                   CustomPageRoute(child:Categories_Page ()))
             ),
             ListTile(
       leading: Icon(Icons.logout),
       title: Text("تسجيل الخروج"),
        onTap: (){
          sharedPref.clear();
          Navigator.push(
              context,
              new CustomPageRoute(child:  Login()));
        }
     ),
             ListTile(
       leading: Icon(Icons.share),
       title: Text("مشاركه التطبيق"),
       onTap: ()async{
       },
     ),
             ListTile(
       leading: Icon(Icons.star),
       title: Text("عنا"),
        // onTap: ()=>Navigator.push(
        //     context,
        //     CustomPageRoute(  child: const Categories_Page()))
     ),
     ListTile(
         leading: Icon(Icons.help),
         title: Text("مساعده"),
         // onTap: ()=>Navigator.push(
         //     context,
         //     CustomPageRoute(  child: const Categories_Page()))
     ),

   ]),

    );
  }
}
