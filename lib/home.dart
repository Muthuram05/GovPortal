import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grievanceportal/report.dart';
import 'package:grievanceportal/admin.dart';
import 'package:grievanceportal/track.dart';
import 'package:grievanceportal/main.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('Grievance'),
        actions: [
          IconButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminLogIn())),
      icon:const Icon(Icons.account_circle,size: 35,)),
          ],
        leading:const Image(image: AssetImage("images/GovermentLogo.png"),width: 15.0,height: 15.0,
        ),
        backgroundColor: Colors.purple,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const Report())),
         child: const Text("REPORT AN INCIDENT"),style: ElevatedButton.styleFrom(
                  maximumSize: const Size(240,50),
                    minimumSize: const Size(240,40)
                  ),),
                 ElevatedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const Track())),
                   child: const Text("TRACK COMPLAINT STATUS"),style: ElevatedButton.styleFrom(
                     maximumSize: const Size(240,50),
                     minimumSize: const Size(240,40)
                 ),)
                  ],
            ),
      ),
      floatingActionButton: SizedBox(
        height: 50.0,
        width: 50.0,
        child: FittedBox(
          child: FloatingActionButton(onPressed: (){
            if (Platform.isAndroid) {
              SystemNavigator.pop();
           }
            else if (Platform.isIOS) {
              exit(0);
            }
          },
            tooltip: 'Close app',
            child:
            const Icon(Icons.logout),
          ),
        ),
      )
    );
  }
}
