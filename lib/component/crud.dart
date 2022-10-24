import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';


 

class Crud {

    


  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response = await http.post(Uri.parse(url), body: data );
      if (response.statusCode == 200) {
        var responsebody = jsonDecode(response.body);
        return responsebody;
      } else {
        print("Error ${response.statusCode}");
      }
    } catch (e) {
      print("Error Catch $e");
    }
  }

  postRequestWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    request.files.add(multipartFile);
    data.forEach((key, value) {
        request.fields[key] = value ;
    });
    var myrequest = await request.send();

    var response = await http.Response.fromStream(myrequest) ;
    if (myrequest.statusCode == 200){
        return jsonDecode(response.body) ;
    }else {
      print("Error ${myrequest.statusCode}") ;
    }
  }
  
}






















// Future addRequestWithImageOne(url, data, [File? image]) async {
//   var uri = Uri.parse(url);
//   var request = new http.MultipartRequest("POST", uri);
//   request.headers.addAll(myheaders);

//   if (image != null) {
//     var length = await image.length();
//     var stream = new http.ByteStream(image.openRead());
//     stream.cast();
//     var multipartFile = new http.MultipartFile("file", stream, length,
//         filename: basename(image.path));
//     request.files.add(multipartFile);
//   }

//   // add Data to request
//   data.forEach((key, value) {
//     request.fields[key] = value;
//   });
//   // add Data to request
//   // Send Request
//   var myrequest = await request.send();
//   // For get Response Body
//   var response = await http.Response.fromStream(myrequest);
//   if (myrequest.statusCode == 200) {
//     print(response.body);
//     return jsonDecode(response.body);
//   } else {
//     print(response.body);
//     return jsonDecode(response.body);
//   }
// }
