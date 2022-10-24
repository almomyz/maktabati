import 'dart:io';
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../component/pdf_api.dart';
import '../../const/CustomPageRoute.dart';
import '../../const/constance.dart';
import '../../const/linkapi.dart';
import '../../const/mnue.dart';
import '../Add_pages/Add_borrow.dart';

class Detalis_book extends StatefulWidget {
final Image_url;
final id;
final title;
final part_path;
final subtitle;
final auther_name;
 final Categories;
final Reting;
 final Publisher;
final page_num;
final laung;
final Size;
final formate;
final copy_num;
final price;
final date;
final dascription;

   Detalis_book({Key? key, this.Image_url, this.title, this.subtitle, this.auther_name,  this.Reting, this.page_num,  this.Size, this.formate, this.copy_num, this.price, this.date, this.dascription, this.id, this.Categories, this.Publisher, this.laung, this.part_path}) :super(key: key);

  @override
  State<Detalis_book> createState() => _Detalis_bookState();
}

class _Detalis_bookState extends State<Detalis_book> {
bool downloding =false;
String progressString='';
String downlodedImagepath='';


Future <bool>  getstorgePremission  ()async{
  
  return await Permission.storage.request().isGranted;
  
  
}
Future<String> getDownloadFolferPath()async{
  return await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
  
  
}

Future downlodFile(String  downloadDirectory)async{
  Dio dio=Dio();
  var downloadedImagepath= '$downloadDirectory/almomyz.pdf';
  try{
    await dio.download("${link_Image+"pdf/almomyz.pdf"}", downloadedImagepath,

    onReceiveProgress: (rec,total){
      print("Rec:$rec,total:$total");
      setState(() {
        downloding=true;
        progressString=((rec/total)*100).toStringAsFixed(0)+"%";
      });

    }
    );
  }catch(e){
    print(e);
    
  }
  await Future.delayed(const Duration(seconds: 3));
  return downloadedImagepath;

}
Future <void>doDownloadFile()async{
  if(await getstorgePremission() ) {
    String downloadDirectory = await getDownloadFolferPath();
    await downlodFile(downloadDirectory).then((imagePath) {
      displayImage(imagePath);

    });
  }
}

void displayImage(String downlodDirectory){
setState(() {
  downloding=false;
  progressString="completed";
  downlodedImagepath=downlodDirectory;


});

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mnue(),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: primary_Color,
        shadowColor: Colors.white,
        actions: [],
      ),
body: ListView(
  children:   [
    Container(

      height: 230,

    color: Colors.teal[50],

      child:   Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [



        Column(children: [





          Expanded(flex: 1,child: Text(widget.title,textAlign: TextAlign.right,textDirection: TextDirection.ltr,style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold))),

          Expanded(flex: 1,child: Text(widget.subtitle,style: TextStyle(fontSize: 17,))),

          Expanded(flex: 1,child: Text(widget.auther_name,textAlign: TextAlign.start,textDirection: TextDirection.rtl,style: TextStyle(color: primary_Color,fontSize: 20,fontWeight: FontWeight.bold))),

          Expanded(flex: 1,child: Text(widget.Categories,textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: primary_Color,fontSize: 20,fontWeight: FontWeight.bold))),

          Expanded(

            flex: 1,

            child: RatingBarIndicator(

                itemSize: 20,

                itemCount: 5,

                rating: double?.parse(
                    widget.Reting),

                itemBuilder: (context, index) {

                  return Icon(Icons.star,

                    color: Colors.amber,);

                }),

          ),

          Expanded(flex: 1,child: Text(widget.Publisher,style: TextStyle(fontSize: 17,))),

        ]),

        Card(child: Image.network(widget.Image_url,height: 200,width: 120,fit: BoxFit.contain,)),







      ]),

    ),
    SizedBox(height: 10,),
    Container(

      height: 80,
      color: Colors.white,
      child: ListView(scrollDirection: Axis.horizontal,children: [
       SizedBox(width: 20,),

        Container(width: 2,height: 6,color: Colors.black54,),   SizedBox(width: 20,),
        Column(children:[

          Expanded(flex:1,child: Text("عدد النسخ",textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: primary_Color,fontSize: 20,))),

          Expanded(flex: 1,child: Text(widget.copy_num,textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold))),
        ]),
        SizedBox(width: 10,),
        Container(width: 2,height: 6,color: Colors.black54,),   SizedBox(width: 20,),
        Column(children:[

          Expanded(flex: 1,child: Text("نوع الملف",textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: primary_Color,fontSize: 20,))),

          Expanded(flex: 1,child: Text(widget.formate,textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold))),
        ]),
        SizedBox(width: 10,),
        Container(width: 2,height: 6,color: Colors.black54,),   SizedBox(width: 20,),
        Column(children:[

          Expanded(flex: 1,child: Text("الحجم",textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: primary_Color,fontSize: 20,))),

          Expanded(flex: 1,child: Text(widget.Size,textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold))),
        ]),
        SizedBox(width: 10,),
        Container(width: 2,height: 6,color: Colors.black54,),   SizedBox(width: 20,),
        Column(children:[

          Expanded(flex: 1,child: Text("اللغه",textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: primary_Color,fontSize: 20,))),

          Expanded(flex: 1,child: Text(widget.laung,textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold))),
        ]),
        SizedBox(width: 10,),
        Container(width: 2,height: 6,color: Colors.black54,),   SizedBox(width: 20,),
        Column(children:[

          Expanded(flex: 1,child: Text("الصفحات",textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: primary_Color,fontSize: 20,))),

          Expanded(flex: 1,child: Text(widget.page_num,textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold))),
        ]),
        SizedBox(width: 10,),
        Container(width: 2,height: 6,color: Colors.black54,),   SizedBox(width: 20,),
        Column(children:[

          Expanded(flex: 1,child: Icon(Icons.price_check,color: primary_Color,size: 30,)

          ),

          Expanded(flex: 1,child: Text(widget.price,textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold))),
        ]),
        SizedBox(width: 10,),
        Container(width: 2,height: 6,color: Colors.black54,),   SizedBox(width: 20,),
        Column(children:[

          Expanded(flex: 1,child: Icon(Icons.calendar_today_outlined,size: 30,color: primary_Color,)),

          Expanded(flex: 1,child: Text(widget.date,textAlign: TextAlign.end,textDirection: TextDirection.ltr,style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold))),
        ]),
        SizedBox(width: 10,),
        Container(width: 2,height: 6,color: Colors.black54,),   SizedBox(width: 20,),

      ],),
    ),
       SizedBox(height: 30,),
    Container(height: 130,color: Colors.white,child: Column(children: [
      Expanded(flex: 1,child: Text("وصف الكتاب :",textAlign: TextAlign.right,textDirection: TextDirection.rtl,style: TextStyle(color: primary_Color,fontSize: 20,fontWeight: FontWeight.bold))),
      Expanded(flex: 3,child: Text(widget.dascription,textAlign: TextAlign.right,textDirection: TextDirection.rtl,style: TextStyle(fontSize: 15,))),

    ]

    ),),
    SizedBox(height: 30,),
    Row(children: [
      SizedBox(width: 10,),
      Expanded(
        flex: 1,
        child: TextButton(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Text('اعاره',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
              Icon(Icons.person,color: Colors.white),

              ],
          ),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent,),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ))),
          onPressed: () async{

            Navigator.push(
                context,
                new CustomPageRoute(child:  Add_borrow(id: widget.id,)));
          },
        ),
      ),
      SizedBox(width: 10,),
      Expanded(
        flex: 1,
        child: TextButton(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Text('تصفح',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
              Icon(Icons.menu_book_sharp,color: Colors.white),

            ],
          ),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent,),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ))),
          onPressed: () async{
            openfile(
                url: '${link_Image+"pdf/"+widget.part_path}',
                fileName: "${widget.part_path}"
            );
          },
        ),
      ),
      SizedBox(width: 10,),

      Expanded(
        flex: 1,
        child: TextButton(

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              Text('تحميل',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),
              Icon(Icons.download,color: Colors.white),

            ],
          ),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blueAccent,),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ))),

               onPressed: ()async {
                await doDownloadFile();

          }


               ),
      ),
      SizedBox(width: 10,),


    ],)
  ],


),




    );
  }

  
  
  
  
  
  
 Future openfile({required String url, required String? fileName}) async{
    final file=     await downlodfile(url, fileName!);
    if(file ==null)return null;
    else
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
    print(e);
    return null;

  }
  }


}
