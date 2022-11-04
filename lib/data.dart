import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Alldata());

class Alldata extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      debugShowCheckedModeBanner: false,
      home: MyData(),
    );
  }
}

class MyData extends StatefulWidget {
  @override
  _MyDataState createState() => _MyDataState();
}

class _MyDataState extends State<MyData> {
  List data = [];
  // Initial Selected Value
  String dropdownvalue = '';
  // List of items in our dropdown menu
  var items = [
    '',
    '	Chennai',
    'Coimbatore',
    'Madurai',
    'Tiruchirappalli',
    'Salem',
    'Tirunelveli',
    'Tiruppur',
    'Vellore',
    'Erode',
    'Thoothukkudi',
    'Dindigul',
    'Thanjavur',
    'Ranipet',
    'Virudhunagar',
    'Karur',
    'Nilgiris',
    'Krishnagiri',
    'Kanyakumari',
    'Kanchipuram',
    'Namakkal',
    'Sivaganga',
    'Cuddalore',
    'Tiruvannamalai',
    'Pudukkottai',
    'Tirupathur',
    'Nagapattinam',
  ];
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    final response = await http.get('https://portalgrievance.000webhostapp.com/viewdata.php');
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    }
  }
  void Cityname()async{
    var url = "https://portalgrievance.000webhostapp.com/city.php";
    var res = await http.post(url,body:{
      "city":dropdownvalue,
    });
    setState(() {
      var test = jsonDecode(res.body);
        data = test;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            DropdownButton(
              // Initial Value
              value: dropdownvalue,
              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),
              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),

              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });

              },
            ),
            ElevatedButton(onPressed: ()=>Cityname(),child:const Text("Submit") ,),
            Expanded(

              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) => ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Assessment Details",style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),),
                        Text("City : "+data[index]['city']),
                        Text("Street Name : "+ data[index]['street']),
                        Text("Ward : "+data[index]['ward']),
                        Text("Zone : "+data[index]['zone']),
                        Text("Landmark : "+data[index]['landmark']),
                        const  Text("Personal Information" ,style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),),
                        Text("Mobile Number : "+data[index]['mobileno']),
                        Text("Email : "+data[index]['email']),
                        Text("Department : "+data[index]['department']),
                        Text("Complaint : "+data[index]['complaint']),
                        Text("File : "+data[index]['file']),
                      ],
                    ),
                    subtitle: SizedBox(width:500,height:500,
                      child: Column(
                        children: [
                          Image.network("https://portalgrievance.000webhostapp.com/uploads/${(data[index]['image'])}",width: 400,height: 400,),
                          const Text(""),
                          const Divider(
                            color: Colors.black,
                          ),
                        ],
                      ),),

                  ),),
            ),
          ],
        ),
      )

    );
  }
}