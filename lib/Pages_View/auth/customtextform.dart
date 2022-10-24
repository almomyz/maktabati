import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustTextFormSign extends StatelessWidget {

  final Icon icon;
  final String hint ;
  final String? Function(String?) valid ; 
  final TextEditingController mycontroller ; 
  const CustTextFormSign({Key? key, required this.hint, required this.mycontroller, required this.valid,required this.icon,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: TextFormField(

        textAlign: TextAlign.right,
        validator: valid,
        controller: mycontroller,
        decoration: InputDecoration(
        suffixIcon: icon,

            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            hintText: hint,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
