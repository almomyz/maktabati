import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:lottie/lottie.dart';
import 'package:maktabati2/Models/M_Sarch_Categories.dart';
import 'package:maktabati2/Pages_View/Details_Pages/V_Book_Categories.dart';
import 'package:maktabati2/const/mnue.dart';
import 'package:maktabati2/component/Categories_Api.dart';
import 'package:maktabati2/component/crud.dart';
import 'package:maktabati2/const/CustomPageRoute.dart';
import 'package:maktabati2/const/constance.dart';
import 'package:shimmer/shimmer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../const/Laoding.dart';
import '../../const/SearchWidget.dart';
import '../../const/linkapi.dart';
import '../Add_pages/Add_Categories.dart';

class Categories_Page extends StatefulWidget {
  const Categories_Page({Key? key}) : super(key: key);

  @override
  State<Categories_Page> createState() => _Categories_PageState();
}

class _Categories_PageState extends State<Categories_Page> with Crud{

 bool isLoding=false;

  List<Categories> books=[] ;
  String query = '';
  Timer? debouncer;
  @override
  void initState() {
    super.initState();

    init();


  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
      VoidCallback callback, {
        Duration duration = const Duration(milliseconds: 1000),
      }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final books = await Categories_Api.getBooks(query);

    setState(() => this.books = books);
    print(books);
  }




  @override
  Widget build(BuildContext context) =>isLoding
      ?  Loading():
     Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          label: Text("اضافه"),
        onPressed: () {
          Navigator.push(
              context,
              new CustomPageRoute(child:  Add_Categories()));
        },
        icon:  Icon(Icons.add),
        backgroundColor: primary_Color,

      ),
      drawer: mnue(),
      appBar: AppBar(
        title: Text("الاقسام"),
        centerTitle: true,
        backgroundColor: primary_Color,
        shadowColor: Colors.white,
        actions: [],
      ),
      body: ListView(
        children: [


          buildSearch(),

          Container(
            height: 450,
            child: GridView.builder(

              itemCount: books.length,
              padding: EdgeInsets.only(top: 50),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 20),
              itemBuilder: (context, index) {
                final book = books[index];
                return FocusedMenuHolder(
                  menuWidth: 60.5,
                  animateMenuItems: true,

                  menuItems: [
                    FocusedMenuItem(title: Text(""), onPressed: (){},trailingIcon: Icon(Icons.edit,color: primary_Color,)),
                    FocusedMenuItem(title: Text(""), onPressed: ()async{





                      int num=int.parse(book.book_num);
                      if(num>0){
                        AwesomeDialog(context: context,title: "تنبيه",body: Text("هذا القسم يحتوي على كتب يرجئ حذف الكتب اولا ثم حذف القسم"))..show();
                      }else{
                         var response = await postRequest(delete_Categories, {
                          "id":book.cat_id,
                        }

                        );



                        if(response["status"]=="success")
                        {

                          AwesomeDialog(dialogType: DialogType.success,context: context,title: "مبروك",body: Text("تم الحذف بنجاح"))..show();


                        }
                        else{
                          AwesomeDialog(dialogType: DialogType.error,context: context,title: "تنبيه",body: Text("خطاء لم يتم الحذف "))..show();

                        }

                        return  response;

                      }





                    },trailingIcon: Icon(Icons.delete,color: Colors.red,))
                  ],
                  onPressed: (){},

                  child: Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.black54)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: InkWell(
                              onTap: (){
                                       if(int.parse(book.book_num)==0){
                                         AwesomeDialog(dialogType: DialogType.info,context: context,title: "تنبيه",body: Text(" القسم لايوجد فيه كتب"))..show();
                                       }else

                                       {
                                         Navigator.push(
                                             context,
                                             CustomPageRoute(
                                                 child: V_Book_Categories(
                                                     name: book.cat_name,
                                                     id: book.cat_id)));
                                       }

                              },
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Card(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(book.cat_name, textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),

                                      Expanded(
                                        flex: 1,
                                        child: Row(children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(book.book_num+"    كتاب"),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Icon(
                                            Icons.menu_book_rounded,
                                            color: primary_Color,
                                          )
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ))),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );






  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: '                    ابحث عن قسم',
    onChanged:searchBook,
  );
  Future searchBook(String query) async => debounce(() async {
    final books = await Categories_Api.getBooks(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.books = books;
    });
  });

Widget okDelete(){

  return Dialog(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset("assets/done.json",

                        repeat: true,
                        onLoaded: (compositoin) {

                        }),
                    Text(
                      "تم الحذف بنجاح",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ]
              )
          );



}

}
