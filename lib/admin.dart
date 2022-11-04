import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as  http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grievanceportal/data.dart';

class AdminLogIn extends StatefulWidget {
  const AdminLogIn({Key? key}) : super(key: key);

  @override
  _AdminLogInState createState() => _AdminLogInState();
}

class _AdminLogInState extends State<AdminLogIn> {
  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: Admin(),
    );
  }
}
class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override

  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool processing = false;
  @override

  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Welcome Admin! Please login."),
            const Text(''),
            TextField(
              controller: username,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.account_box,),
                  hintText: 'email'),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.lock,),
                  hintText: 'password'),
            ),
            MaterialButton(onPressed: ()=>adminRegister(),
                child: processing == false ? Text('Sign In',style:
                GoogleFonts.varelaRound(fontSize: 18.0,color: Colors.blue),):const CircularProgressIndicator(backgroundColor: Colors.red,)
            )
          ],
        ),
      ),
    );
  }
  void adminRegister()async{
    setState(() {
      processing = true;
    });
    var url = "https://portalgrievance.000webhostapp.com/adminLogin.php";
    var res = await http.post(url,body:{
      "email":username.text,
      "pass":password.text,
    });
    var data = jsonDecode(res.body);
    if(data=="success"){
      Fluttertoast.showToast(
          msg:"Login successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Alldata()));
    }
    else{
      if(data=="error"){
        Fluttertoast.showToast(
            msg:"User name or password incorrect",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    }
    setState(() {
      processing = false;
    });
  }
}

