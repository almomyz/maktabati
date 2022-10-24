import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:maktabati2/Models/M_View_Book.dart';
import 'package:maktabati2/Pages_View/Add_pages/Add_borrow.dart';
import 'package:maktabati2/Pages_View/Details_Pages/Details_book.dart';
import 'package:maktabati2/component/crud.dart';
import 'package:maktabati2/const/constance.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../Models/M_Sarch_Book.dart';
import '../../component/Books_Api.dart';
import '../../const/CustomPageRoute.dart';
import '../../const/SearchWidget.dart';
import '../../const/linkapi.dart';
import '../../const/mnue.dart';
import '../Add_pages/Add_Book.dart';

class Main_Page extends StatefulWidget {
  const Main_Page({Key? key}) : super(key: key);

  @override
  State<Main_Page> createState() => _Main_PageState();
}

class _Main_PageState extends State<Main_Page> with Crud {




  List<Book> books=[] ;
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
    final books = await BooksApi.getBooks(query);

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
              new CustomPageRoute(child:  Add_Book()));

        },
        icon:  Icon(Icons.add),
        backgroundColor: primary_Color,

      ),
        drawer: mnue(),
        appBar: AppBar(
          title: Text("القائمه الرئيسية"),
          centerTitle: true,
          backgroundColor: primary_Color,
          shadowColor: Colors.white,
          actions: [],
        ),
        body: ListView(
          shrinkWrap: false,
          children: [
            Expanded(flex :1,child: buildSearch()),

            Expanded(
              child: Container(
                height: 450,
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: books.length,
                  padding: EdgeInsets.only(top: 50),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1 / 2,
                      crossAxisCount: 3,

                      mainAxisSpacing: 10,
                      crossAxisSpacing: 0),
                  itemBuilder: (context, index) {
                    if(books.isNotEmpty){
                      final book = books[index];
                      return FocusedMenuHolder(

                        menuWidth: 60.5,


                        animateMenuItems: false,

                        menuItems: [
                          FocusedMenuItem(title: Text(""), onPressed: () {


                          }, trailingIcon: Icon(Icons.edit,
                            color: primary_Color,)),
                          FocusedMenuItem(title: Text(""), onPressed: () async{
                            var response = await postRequest(
                                delete_book, {
                              "id": book.id,
                              //"imagename": book.urlImage
                            });

                            if(response["status"]=="success")
                            {

                              AwesomeDialog(dialogType: DialogType.success,context: context,title: "مبروك",body: Text("تم الحذف بنجاح"))..show();


                            }
                            if(response["status"]==null){

                              AwesomeDialog(dialogType: DialogType.error,context: context,title: "تنبيه",body: Text("خطاء لم يتم الحذف "))..show();

                            }

                          }, trailingIcon: Icon(Icons.delete,
                            color: Colors.red,))

                        ],
                        onPressed: () {},
                        child: InkWell(
                          onTap: (){

                            Navigator.push(
                                context,
                                new CustomPageRoute(child:  Detalis_book(part_path: book.part_path,subtitle: book.subtitle,id: book.id,title: book.title,auther_name: book.author,copy_num: book.edition_no,dascription: book.description,Publisher: book.pub_name,laung: book.lang_name,Categories: book.cat_name,date: book.publication_date,formate: book.format,Image_url: link_Image +"books/"+ book.urlImage,page_num: book.pages_no,price: book.price,Reting: book.rating,Size: book.size,)));
                          },
                          child: Container(

                            margin: EdgeInsets.fromLTRB(5, 10, 10, 0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                                border: Border.all(color: Colors.black54)),
                            child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(7)),
                                child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Container(
                                      decoration: BoxDecoration(),
                                      child: Card(
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Image.network(
                                                  link_Image + "books/"+book.urlImage,
                                                  fit: BoxFit.cover),
                                              height: 160,
                                            ),

                                            SizedBox(height: 5,),
                                            Expanded(
                                              flex: 1,
                                              child: Text(book.title,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Color.fromRGBO(
                                                        32, 44, 83, 100),
                                                    fontWeight: FontWeight.bold,
                                                  )),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                  book.author, style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      32, 122, 122, 100)
                                              )),
                                            ),

                                            Expanded(
                                              flex: 1,
                                              child: RatingBarIndicator(
                                                  itemSize: 20,
                                                  itemCount: 5,
                                                  rating: double?.parse(
                                                      book.rating),
                                                  itemBuilder: (context, index) {
                                                    return Icon(Icons.star,
                                                      color: Colors.amber,);
                                                  }),
                                            )
                                          ],
                                        ),
                                      ),
                                    ))),
                          ),
                        ),
                      );
                    }
                    return Text("loding");
                    },
                ),
              ),
            )


          ],
        )



        );
  }

  void _showSecondPage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          body: Center(
            child: Hero(
              tag: 'image1',
              child: Row(children: [Text("data"),Image.asset('assets/18.png',height: 150,width: 150,),]),
            ),
          ),
        ),
      ),
    );
  }




  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: '             ابحث عن كتاب او مؤلف  ',
    onChanged:searchBook,
  );
  Future searchBook(String query) async => debounce(() async {
    final books = await BooksApi.getBooks(query);

    if (!mounted) return;

    setState(() {
      this.query = query;
      this.books = books;
    });
  });




}
