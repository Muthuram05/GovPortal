import 'dart:convert';
import 'package:http/http.dart' as  http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Track extends StatelessWidget {
  const Track({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const TrackData();
  }
}
class TrackData extends StatefulWidget {
  const TrackData({Key? key}) : super(key: key);
  @override
  _TrackDataState createState() => _TrackDataState();
}
class _TrackDataState extends State<TrackData> {
  bool processing = false;
  TextEditingController email = TextEditingController();
  TextEditingController landmark = TextEditingController();
  void Search()async{
    setState(() {
      processing = true;
    });
    var url = "https://portalgrievance.000webhostapp.com/track.php";
    var res = await http.post(url,body:{
      "email":email.text,
      "landmark":landmark.text,
    });
    var data = jsonDecode(res.body);
    if(data=="success"){
      Fluttertoast.showToast(
          msg:"Your Report is Processing",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }
    else{
      if(data=="error"){
        Fluttertoast.showToast(
            msg:"Data Not Found",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title:  const Text("TRACK COMPLAINT STATUS",style:TextStyle(fontSize: 15.0),),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: email,
                decoration: const InputDecoration(prefixIcon: Icon(Icons.account_box,),
                    hintText: 'email'),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: landmark,
                decoration: const InputDecoration(prefixIcon: Icon(Icons.location_city,),
                    hintText: 'landmark'),
              ),
            ),
            TextButton(
              onPressed: ()=>Search(),
            child: const Text("Search"),
            )
          ],
        ),
      ),
    );
  }
}

