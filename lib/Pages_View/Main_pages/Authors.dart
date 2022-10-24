import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:lottie/lottie.dart';
import 'package:maktabati2/Models/M_View_author.dart';
import 'package:maktabati2/Pages_View/Add_pages/Add_auther.dart';
import 'package:maktabati2/Pages_View/Details_Pages/V_Book_Athors.dart';
import 'package:maktabati2/const/mnue.dart';
import 'package:maktabati2/component/crud.dart';
import 'package:maktabati2/const/constance.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../Models/M_Sarch_Author.dart';
import '../../component/Author_Api.dart';
import '../../const/CustomPageRoute.dart';
import '../../const/SearchWidget.dart';
import '../../const/linkapi.dart';

class Authors extends StatefulWidget   {
  const Authors({Key? key}) : super(key: key);

  @override
  State<Authors> createState() => _AuthorsState();
}

class _AuthorsState extends State<Authors>  with Crud{





  List<Author> books=[] ;
  String query = '';
  Timer? debouncer;
  @override
  void initState() {
    super.initState();
    final books =  AuthorApi.getBooks(query);


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
    final books = await AuthorApi.getBooks(query);
    setState(() => this.books = books);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              new CustomPageRoute(child:  Add_auther()));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        icon:Icon(Icons.add),
        backgroundColor: primary_Color, label: Text("اضافه"),

      ),
      drawer: mnue(),
      appBar: AppBar(
        title: Text("المؤلفين"),
        centerTitle: true,
        backgroundColor: primary_Color,
        shadowColor: Colors.white,
        actions: [],
      ),
      body:ListView(

        children: [
          buildSearch(),
          Container(
            height: 450,
            child:GridView.builder(
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
                    FocusedMenuItem(title: Text(""), onPressed: (){
                      
                    },trailingIcon: Icon(Icons.edit,color: primary_Color,)),
                    FocusedMenuItem(title: Text(""), onPressed: ()async{





                      int num=int.parse(book.book_num);
                      if(num>0){
                        AwesomeDialog(context: context,title: "تنبيه",body: Text("هذا القسم يحتوي على كتب يرجئ حذف الكتب اولا ثم حذف القسم"))..show();
                      }else{
                        var response = await postRequest(delete_auther, {
                          "id":book.author_id,
                          "img":book.author_img
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

                  child: InkWell(
                    onTap: (){

                      if(int.parse(book.book_num)==0){
                        AwesomeDialog(dialogType: DialogType.info,context: context,title: "تنبيه",body: Text(" المؤلف لايوجد فيه كتب"))..show();
                      }else
                      Navigator.push(
                          context,
                          CustomPageRoute(child: V_Book_Athors(author_profession: book.author_profession,author_birthday: book.author_birthday,id: book.author_id,name: book.author_name,descrapion: book.author_description,photo: link_Image+"authors/"+book.author_img,)));


                    },
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
                              child: Container(
                                decoration: BoxDecoration(),
                                child: Card(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundColor: Colors.grey.shade800,
                                        backgroundImage: NetworkImage(link_Image+"authors/"+book.author_img),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(book.author_name,textAlign: TextAlign.right ,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("${book.book_num}"+"  كتاب"),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Icon(
                                            Icons.menu_book_outlined,
                                            color: primary_Color,
                                          )
                                        ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ))),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }



  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: '                    ابحث عن مؤلف او عدد كتب',
    onChanged:searchBook,
  );
  Future searchBook(String query) async => debounce(() async {
    final books = await AuthorApi.getBooks(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.books = books;
    });
  });

}
