import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grievanceportal/home.dart';
import 'package:http/http.dart' as  http;
import 'package:email_validator/email_validator.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);
  @override
  _ReportState createState() => _ReportState();
}
class _ReportState extends State<Report> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String dropdownvalue2 = 'Select a City          ';
  // List of items in our dropdown menu
  var item = [
    'Select a City          ',
    'Chennai',
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
  bool processing = false;
  late File _image;
  TextEditingController street =  TextEditingController();
  TextEditingController ward =  TextEditingController();
  TextEditingController zone =  TextEditingController();
  TextEditingController landmark =  TextEditingController();
  TextEditingController mobileno =  TextEditingController();
  TextEditingController email =  TextEditingController();
  TextEditingController department =  TextEditingController();
  TextEditingController complaint =  TextEditingController();
  TextEditingController file =  TextEditingController();
  Future getImage() async{
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image.path);
    });
  }
  Future UploadImage()async{
      final isValidForm = _key.currentState!.validate();
      if (isValidForm) {
        setState(() {
          processing = true;
        });
        final url = Uri.parse("https://portalgrievance.000webhostapp.com/upload.php");
        var request = http.MultipartRequest('POST', url);
        request.fields['city'] = dropdownvalue2;
        request.fields['street'] = street.text;
        request.fields['ward'] = ward.text;
        request.fields['zone'] = zone.text;
        request.fields['landmark'] = landmark.text;
        request.fields['mobileno'] = mobileno.text;
        request.fields['email'] = email.text;
        request.fields['department'] = department.text;
        request.fields['complaint'] = complaint.text;
        request.fields['file'] = file.text;
        var pic = await http.MultipartFile.fromPath("image", _image.path);
        request.files.add(pic);
        var response = await request.send();
        if (response.statusCode == 200) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
          Fluttertoast.showToast(
              msg: "Successfully Submitted",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0
          );
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
          Fluttertoast.showToast(
              msg: "Not Submitted",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
        setState(() {
          processing = false;
        });
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: processing == false ? SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  const Text(""),
                  const Text(""),
                  const Text("Assessment Details"),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      // Initial Value
                      value: dropdownvalue2,
                      // Down Arrow Icon
                      icon: const Icon(Icons.keyboard_arrow_down),
                      // Array list of items
                      items: item.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue2) {
                        setState(() {
                          dropdownvalue2 = newValue2!;
                        });
                      },
                    ),
                  ),
                  TextFormField(
                    controller: street,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)
                      ),
                        hintText: 'Street Name',
                    ),

                  ),
                  TextFormField(
                     controller: ward,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)
                        ),
                        hintText: 'Select Ward No'),
                  ),
                  TextFormField(
                    controller: zone,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)
                        ),
                        hintText: 'Select Zone'),
                  ),
                  TextFormField(
                    controller: landmark,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal)
                        ),
                        hintText: 'Landmark'),
                  ),
                  Column(
                    children:  [
                          const Text("Personal info"),
                      TextFormField(
                        controller: mobileno,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal)
                            ),
                            hintText: 'Contact Number'),
                        validator: (value){
                          if(value!= null && value.length > 9){
                            return null;
                          }
                          else{
                            return "Please give a valid Number";
                          }
                        },
                      ),
                      TextFormField(
                        controller: email,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal)
                            ),
                            hintText: 'Email'),
                        validator: (email)=>
                        email != null && !EmailValidator.validate(email) ? 'Enter a valid email ': null,
                      ),
                      TextFormField(
                        controller: department,
                        decoration:const InputDecoration(
                            border: OutlineInputBorder(

                                borderSide: BorderSide(color: Colors.teal)
                            ),
                            hintText: 'Department'),
                      ),
                      TextFormField(
                         controller: complaint,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(

                                borderSide: BorderSide(color: Colors.teal)
                            ),
                            hintText: 'Complaint Category'),
                      ),
                      TextFormField(
                         controller: file,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal)
                            ),
                            hintText: 'File A Complaint'),
                      ),

                       // Container(
                       //   child: File == null ? const Text('No image found') : Image.file(_image),
                       // ),
                      Row(
                        children: [
                          ElevatedButton(onPressed: ()=>getImage(), child: const Text("Choose a File")),
                          const Text("* This Filed is Important"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(onPressed: ()=>UploadImage(), child: const Text("Submit")),
                          const Text("    "),
                          ElevatedButton(onPressed: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home())), child: const Text("Back To Home"),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red, // Background color
                            ),
                          ),
                        ],
                      ),

                    ],
                  )
                ],
              ),
            ),

        ) :   Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            const CircularProgressIndicator(backgroundColor: Colors.red,),
            Text("Loading...",style: GoogleFonts.varelaRound(fontSize: 18.0,color: Colors.blue),),
          ],
        )),
        padding: const EdgeInsets.all(18.0),
      )
    );
  }
}



