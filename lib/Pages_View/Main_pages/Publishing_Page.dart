import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:maktabati2/Models/M_View_publishe.dart';
import 'package:maktabati2/Pages_View/Add_pages/Add_publisher.dart';
import 'package:maktabati2/Pages_View/Details_Pages/V_Book_Publishing.dart';
import 'package:maktabati2/const/mnue.dart';
import 'package:maktabati2/component/crud.dart';
import 'package:maktabati2/const/constance.dart';
import '../../Models/M_Sarch_Publishing.dart';
import '../../component/Publishing_Api.dart';
import '../../const/CustomPageRoute.dart';
import '../../const/SearchWidget.dart';
import '../../const/linkapi.dart';

class Publishing_Page extends StatefulWidget {
  const Publishing_Page({Key? key}) : super(key: key);

  @override
  State<Publishing_Page> createState() => _Publishing_PageState();
}

class _Publishing_PageState extends State<Publishing_Page> with Crud {
  List<Publishing> books = [];
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
    final books = await Publishing_Api.getBooks(query);

    setState(() => this.books = books);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          label: Text("اضافه"),
        onPressed: () {

          Navigator.push(
              context,
              new CustomPageRoute(child:  Add_Publisher()));


        },
        icon: Icon(Icons.add),
        backgroundColor: primary_Color,
      ),
      drawer: mnue(),
      appBar: AppBar(
        title: Text("دور النشر"),
        centerTitle: true,
        backgroundColor: primary_Color,
        shadowColor: Colors.white,
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
                        AwesomeDialog(context: context,title: "تنبيه",body: Text("هذا دار النشر يحتوي على كتب يرجئ حذف الكتب اولا ثم حذف دار النشر"))..show();
                      }else{
                        var response = await postRequest(delete_Publishe, {
                          "id":book.pub_id,
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
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  if(int.parse(book.book_num)==0){
                                    AwesomeDialog(dialogType: DialogType.info,context: context,title: "تنبيه",body: Text(" دار النشر لايوجد فيه كتب"))..show();
                                  }
                                  else
                                  Navigator.push(
                                      context,
                                      CustomPageRoute(

                                          child: V_Book_Publishing(
                                        sequential_deposit_no:
                                            book.sequential_deposit_no,
                                        owner: book.owner,
                                        establishment_date:
                                            book.establishment_date,
                                        name: book.name,
                                        id: book.pub_id,
                                      )));
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
                                          child: Text(book.name,

                                            textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold,
                                              )),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Row(children: [
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text( " كتاب   ${book.book_num}", textDirection: TextDirection.rtl,textAlign: TextAlign.center,),
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
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: '          ابحث عن دار نشر او صاحب دار نشر ',
        onChanged: searchBook,
      );
  Future searchBook(String query) async => debounce(() async {
        final books = await Publishing_Api.getBooks(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.books = books;
        });
      });
}
