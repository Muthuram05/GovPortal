// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as  http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grievanceportal/home.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:email_validator/email_validator.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  dynamic token = FlutterSession().get('token');
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Grievance'),),
        resizeToAvoidBottomInset: false,
        body: const SafeArea(
          child: MyApp(),
        ),
      ),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  bool signin = true;
  bool processing = false;

  final _controllername = TextEditingController();
  final _controlleremail = TextEditingController();
  final _controllerpass = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(child: const Icon(Icons.account_circle,size: 200,)),
          boxUi()
        ],
      ),
    );
  }
  void changeState(){
    if(signin){
      setState(() {
        signin = false;
      });

    }
    else {
      setState(() {
        signin = true;
      });
    }
  }
  void registerUser()async {
    final isValidForm = _formkey.currentState.validate();
    if (isValidForm) {
    setState(() {
      processing = true;
    });
    var url = "https://portalgrievance.000webhostapp.com/signup.php";

    var res = await http.post(url, body: {
      "email": _controlleremail.text,
      "name": _controllername.text,
      "pass": _controllerpass.text,
    }, headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
    var data = jsonDecode(res.body);
    if (data == "error") {
      Fluttertoast.showToast(
          msg: "Account Already Exists,Please login",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else {
      if (data == "sucess") {
        Fluttertoast.showToast(
            msg: "Account Created",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else {
        Fluttertoast.showToast(
            msg: "Error",
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
  void userSignIn()async{
    setState(() {
      processing = true;
    });
    var url = "https://portalgrievance.000webhostapp.com/signin.php";
    var res = await http.post(url,body:{
      "email":_controlleremail.text,
      "pass":_controllerpass.text,
    });
    var data = jsonDecode(res.body);
    if(data=="success"){
      await FlutterSession().set('token',_controlleremail.text);
      Fluttertoast.showToast(
          msg:"Login successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
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

  Widget boxUi(){
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: SizedBox(
          width: 500,
          height:350,
          child: Column(
            children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                
                FlatButton(

                  onPressed: ()=> changeState(),
                  child: Text('SIGN IN',style: GoogleFonts.varelaRound(
                    color: signin==true ? Colors.blue : Colors.grey,fontSize: 25.0,fontWeight: FontWeight.bold,
                  ),),
                ),
                FlatButton(
                  onPressed: ()=> changeState(),
                  child: Text('SIGN UP',style: GoogleFonts.varelaRound(
                      color: signin!=true ? Colors.blue : Colors.grey,fontSize: 25.0,fontWeight: FontWeight.bold,
                  ),),
                ),


              ],
            ),
            signin == true ? signInUi(): signUpUi(),
          ],
          ),
      ),
        );

  }
  Widget signInUi(){
    return Flexible(child: Container(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children:  [
          TextField(
            controller: _controlleremail,
            decoration: const InputDecoration(prefixIcon: Icon(Icons.account_box,),
                hintText: 'email'),
          ),
          TextField(
            controller: _controllerpass,
            obscureText: true,
            decoration: const InputDecoration(prefixIcon: Icon(Icons.lock,),
                hintText: 'pass'),
          ),
          const SizedBox(height: 10.0),
          MaterialButton(onPressed: ()=>userSignIn(),
            child: processing == false ?Text('Sign In',style:
            GoogleFonts.varelaRound(fontSize: 18.0,color: Colors.blue),):const CircularProgressIndicator(backgroundColor: Colors.red,)
          )
        ],
      ),
    ),);
  }
  Widget signUpUi(){
    return Flexible(
      child:
        Container(
          padding: const EdgeInsets.all(5.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _controllername,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.account_circle,),
                      hintText: 'name'),
                  validator: (value){
                    if(value!= null && value.length > 4){
                      return null;
                    }
                    else{
                      return "Please give us your name";
                    }
                  },
                ),
                TextFormField(
                  controller: _controlleremail,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.account_box,),
                      hintText: 'email'),
                  validator: (email)=>
                  email != null && !EmailValidator.validate(email) ? 'Enter a valid email ': null,
                ),
                TextFormField(
                  controller: _controllerpass,
                  obscureText: true,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.lock,),
                      hintText: 'pass'),
                  validator: (value){
                    if(value!= null && value.length > 4){
                      return null;
                    }
                    else{
                      return "Please give a valid Password";
                    }
                  },
                ),
                const SizedBox(height: 10.0),
                MaterialButton(onPressed: ()=>registerUser(),
                  child: processing == false ? Text('Sign Up',style:
                  GoogleFonts.varelaRound(fontSize: 18.0,color: Colors.blue),):const CircularProgressIndicator(backgroundColor: Colors.red,)

                )
              ],
            ),
          ),
        )
    );
  }
}


