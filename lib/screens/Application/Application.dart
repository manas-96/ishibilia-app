import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/screens/Notifications.dart';

import '../../helper.dart';


class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {


  var sponsorCompany= {
  "id": null,
  "application_form_id": null,
  "name": "",
  "address": "",
  "phone": "",
  "created_at": "",
  "updated_at": ""
  };
  var spouse= {
    "id": null,
    "application_form_id": null,
    "name": "",
    "email": "",
    "mobile": "",
    "nationality": "",
    "date_of_birth": "",
    "iqama": "",
    "image": "",
    "document_copy": "",
    "created_at": "",
    "updated_at": ""
  };

  var pointOfContact={
    "id": null,
    "application_form_id": null,
    "name": "Wells and Hebert Trading",
    "email": "ditubarowu@mailinator.com",
    "mobile": "Humphrey Cash Traders",
    "created_at": "2021-06-13T14:41:02.000000Z",
    "updated_at": "2021-06-13T14:41:02.000000Z"
  };
  List childName=[];
  List childImage=[];
  List childSchool=[];
  List childGrade=[];
  List childNationality=[];
  List childDob=[];
  List childIqama=[];
  List childDocument=[];


  List workerName=[];
  List workerImage=[];
  List workerType=[];
  List workerNationality=[];
  List workerDob=[];
  List workerIqama=[];
  List workerMobile=[];



  List petName=[];
  List petImage=[];
  List petBreed=[];
  List petVac=[];
  List petColor=[];
  List petType=[];
  List petAge=[];

  List make=[];
  List vColor=[];
  List vModel=[];
  List vLicencePlate=[];
  List vImage=[];
  List vInsurance=[];
  List drivingLicence=[];





  var object={
    "nationality":null,
    "iqama":null,
    "passport_no":null,
    "religion":null,
    "tel_office":null,
    "whatsapp_no":null,
    "current_residence_tel":null,
    "address":null,
    "marital_status":null,
    "confirm_information":true,
    "agree_on_speed_limit":true,
    "agree_on_correct_information":true,
    "agree_on_rules":true,
    "company_name":null,
    "company_address":null,
    "company_telephone_no":null,
    "company_poc_name":null,
    "company_poc_email":null,
    "company_poc_mobile":null,
    "spouse_name":null,
    "spouse_mobile":null,
    "spouse_nationality":null,
    "spouse_date_of_birth":null,
    "spouse_iqama":null,
  };
  String moveIn="";
  String lastPeriod="";
  bool information=false;

  bool checkData=false;
  var data;
  getApplication()async{
    final result = await APIClient().getApplication();
    if(result=="failed"){
      if(mounted){
        setState(() {
          checkData=true;
        });
      }
    }
    else{
      print("data");
      if(mounted){
        setState(() {
          data=result;
          print(data["spouse"]);
        });
      }
      if(result["status"]==0){
        if(mounted){
          setState(() {
            checkData=true;
          });
        }
      }
    }
  }


  var maritialStatus;
  bool choseImg=false;
  bool chosePassport=false;
  File _image;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        choseImg=true;
       // upload();
      } else {
        //('No image selected.');
      }
    });
  }
  File _passport;
  Future getPassport() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _passport = File(pickedFile.path);
        chosePassport=true;
        // upload();
      } else {
        //('No image selected.');
      }
    });
  }
  List country;
  getCountry()async{
    final result = await APIClient().countries();
    if(mounted){
      setState(() {
        country=result;
      });
    }
  }
  String nationality;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountry();
    getApplication();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/splash.jpg'),fit: BoxFit.cover
              )
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications,color: Colors.white,),
            onPressed: (){
              Get.to(Notifications());
            },
          )
        ],
        elevation: 0,
        title: Text('Residential Information',style: TextStyle(color: Colors.white),),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.4),
              image: DecorationImage(
                  image: AssetImage('images/splash.jpg'),fit: BoxFit.fill
              )
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: displayApplication(),
          )
      ),
    );
  }
  displayApplication(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Container(
             color: Colors.white,
             width: MediaQuery.of(context).size.width,
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Text('Application No',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Container(
                       decoration: BoxDecoration(
                         border: Border.all(color: Colors.black54)
                       ),
                       child: Padding(
                         padding: const EdgeInsets.only(left: 8.0, right: 8),
                         child: TextFormField(
                           onChanged: (val){

                           },
                           initialValue: "weew-485",
                           decoration: InputDecoration(
                             border: InputBorder.none
                           ),
                         ),
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Text("Name: *",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Container(
                       decoration: BoxDecoration(
                           border: Border.all(color: Colors.black54)
                       ),
                       child: Padding(
                         padding: const EdgeInsets.only(left: 8.0, right: 8),
                         child: TextFormField(
                           onChanged: (val){

                           },
                           initialValue: "Manas Saha",
                           decoration: InputDecoration(
                            // labelText: 'Name',
                               border: InputBorder.none
                           ),
                         ),
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Text("Nationality: *",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Container(
                       decoration: BoxDecoration(
                         border: Border.all(width: 1,color: Colors.black54),
                         //color:  Colors.white70,
                       ),

                       //color:  Colors.pink[900],
                       child: Padding(
                         padding: const EdgeInsets.only(left: 8, right: 8,),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: <Widget>[
                             Expanded(
                               child: DropdownButtonHideUnderline(
                                 child: ButtonTheme(
                                   alignedDropdown: true,
                                   child: DropdownButton<String>(
                                     value: nationality,
                                     iconSize: 30,
                                     icon: (null),
                                     style: TextStyle(
                                       color: Colors. black,
                                       fontSize: 16,
                                     ),
                                     hint: Text('Nationality',style: TextStyle(color: Colors.black54)),
                                     onChanged: (String newValue) {
                                       setState(() {
                                         nationality=newValue;
                                         //(_myState);
                                       });
                                     },
                                     items: country?.map((item) {
                                       return new DropdownMenuItem(
                                         child: Container(width: 100,
                                           child: new Text(item['name'],
                                             style: TextStyle(),),
                                         ),
                                         value: item['id'].toString(),
                                       );
                                     })?.toList() ??
                                         [],
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Text("Iqama No. (If applicable):",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Container(
                       decoration: BoxDecoration(
                           border: Border.all(color: Colors.black54)
                       ),
                       child: Padding(
                         padding: const EdgeInsets.only(left: 8.0, right: 8),
                         child: TextFormField(
                           onChanged: (val){

                           },
                           initialValue: "64565469",
                           decoration: InputDecoration(
                             // labelText: 'Name',
                               border: InputBorder.none
                           ),
                         ),
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Text("Passport No: *",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Container(
                       decoration: BoxDecoration(
                           border: Border.all(color: Colors.black54)
                       ),
                       child: Padding(
                         padding: const EdgeInsets.only(left: 8.0, right: 8),
                         child: TextFormField(
                           onChanged: (val){

                           },
                           initialValue: "64565469",
                           decoration: InputDecoration(
                             // labelText: 'Name',
                               border: InputBorder.none
                           ),
                         ),
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Text("Religion",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Container(
                       decoration: BoxDecoration(
                           border: Border.all(color: Colors.black54)
                       ),
                       child: Padding(
                         padding: const EdgeInsets.only(left: 8.0, right: 8),
                         child: TextFormField(
                           onChanged: (val){

                           },
                           //initialValue: "64565469",
                           decoration: InputDecoration(
                             // labelText: 'Name',
                               border: InputBorder.none
                           ),
                         ),
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Text("Image: *",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Container(
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                           border: Border.all(color: Colors.black54)
                       ),
                       child: Padding(
                         padding: const EdgeInsets.only(left: 8.0, right: 8),
                         child: InkWell(
                           onTap: (){
                             getImage();
                           },
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text("Choose Image"),
                           ),
                         ),
                       ),
                     ),
                   ),
                   choseImg?Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Container(
                       width: 120,height: 120,
                       decoration: BoxDecoration(
                           image: DecorationImage(
                             image: FileImage(_image),fit: BoxFit.contain
                           ),
                           border: Border.all(color: Colors.black54)
                       ),
                     ),
                   ):Container(),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Text("Passport: *",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Container(
                       width: MediaQuery.of(context).size.width,
                       decoration: BoxDecoration(
                           border: Border.all(color: Colors.black54)
                       ),
                       child: Padding(
                         padding: const EdgeInsets.only(left: 8.0, right: 8),
                         child: InkWell(
                           onTap: (){
                             getPassport();
                           },
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Text("Choose Image"),
                           ),
                         ),
                       ),
                     ),
                   ),
                   chosePassport?Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: Container(
                       width: 120,height: 120,
                       decoration: BoxDecoration(
                           image: DecorationImage(
                               image: FileImage(_passport),fit: BoxFit.contain
                           ),
                           border: Border.all(color: Colors.black54)
                       ),
                     ),
                   ):Container(),
                 ],
               ),
             ),
           ),
            SizedBox(height: 30,),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Tel Office',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: TextFormField(
                            onChanged: (val){

                            },
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Whatsapp No',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: TextFormField(
                            onChanged: (val){

                            },
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Mobile No',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: TextFormField(
                            initialValue: '6294535521',
                            onChanged: (val){

                            },
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),
            SizedBox(height: 30,),
            Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Current Residence Tel:',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFormField(
                              onChanged: (val){

                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Email',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFormField(
                              initialValue: 'omisrivastava08@gmail.com',
                              onChanged: (val){

                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            SizedBox(height: 30,),
            Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Alternative Address: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFormField(
                              onChanged: (val){

                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Marital Status: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Radio(
                              value: 2,
                              groupValue: maritialStatus,
                              onChanged: (val){
                                setState(() {
                                  maritialStatus=val;//(selectedAddress.toString());
                                  //(selectedAddress);
                                });
                              },
                              activeColor: Colors.black,
                            ),
                            new Text(
                              'Accompanied',
                              style: new TextStyle(
                                  fontSize: 16.0,color: Colors.black
                              ),
                            ),
                            new Radio(
                              value: 0,
                              groupValue: maritialStatus,
                              onChanged: (val){
                                setState(() {
                                  maritialStatus=val;//(selectedAddress.toString());
                                  //(selectedAddress);
                                });
                              },
                              activeColor: Colors.black,
                            ),
                            new Text(
                              'Single',
                              style: new TextStyle(
                                  fontSize: 16.0,color: Colors.black
                              ),
                            ),
                            new Radio(
                              value: 1,
                              groupValue: maritialStatus,
                              onChanged: (value){
                                setState(() {
                                  maritialStatus=value;

                                  //(selectedAddress);
                                });
                              },
                              activeColor: Colors.black,
                            ),
                            new Text(
                              'Married',
                              style: new TextStyle(fontSize: 16.0,color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
            ),
            SizedBox(height: 30,),
            Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Sponsor/Company Name: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFormField(
                              onChanged: (val){

                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Company Address: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFormField(
                              initialValue: 'Durgapur',
                              onChanged: (val){

                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Company Telephone No.: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFormField(
                              initialValue: '876873544',
                              onChanged: (val){

                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            SizedBox(height: 30,),
            Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Company Poc (Point of contact): *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFormField(
                              onChanged: (val){

                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Company POC E-mail: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFormField(
                              initialValue: 'abc@gmail.com',
                              onChanged: (val){

                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Company POC Mobile: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFormField(
                              initialValue: '876873544',
                              onChanged: (val){

                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            SizedBox(height: 30,),

            /// spouse
            Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Spouse name: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFormField(
                              initialValue: spouse["name"]??"",
                              onChanged: (val){
                                spouse["name"]=val;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Spouse Email: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFormField(
                              initialValue: spouse["email"]??"",
                              onChanged: (val){
                                spouse["email"]=val;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Spouse Mobile: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFormField(
                              initialValue: spouse["mobile"]??"",
                              onChanged: (val){
                                spouse["mobile"]=val;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Spouse Nationality: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFormField(
                              initialValue: spouse["nationality"]??"",
                              onChanged: (val){
                                spouse["nationality"]=val;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Spouse DOB: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: DateTimePicker(
                            controller: TextEditingController(text: spouse["date_of_birth"]??""),
                            type: DateTimePickerType.date,
                            dateMask: 'yyyy/MM/dd',
                            firstDate: DateTime(1980),
                            lastDate: DateTime.now(),
                            onChanged: (val) => setState(() => spouse["date_of_birth"] = val),
                            decoration: InputDecoration(
                                prefix: Container(width: 14,),
                                suffix: Icon(Icons.event,color: Theme.of(context).primaryColor,),
                                border: InputBorder.none,
                            ),
                          ),

                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Spouse iqama: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: TextFormField(
                              initialValue: spouse["iqama"]??"",
                              onChanged: (val){
                                spouse["iqama"]=val;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Spouse Image: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: InkWell(
                              onTap: (){
                                print("val");
                                getSpouseImage();
                              },
                              child: Container(
                                height: 52,
                                width: MediaQuery.of(context).size.width,
                                child: Text(spouse["image"]??""),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Spouse Document: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8),
                            child: InkWell(
                              onTap: (){
                                print("val");
                                getSpouseIDocument();
                              },
                              child: Container(
                                height: 52,
                                width: MediaQuery.of(context).size.width,
                                child: Text(spouse["document_copy"]??""),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            SizedBox(height: 30,),
            childName.length!=0?Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: childName.length,
                  itemBuilder: (context,index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Child Name: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                onChanged: (val){
                                  setState(() {
                                    childName[index]=val;
                                  });
                                }
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Child School: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                  onChanged: (val){
                                    setState(() {
                                      childSchool[index]=val;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Child Grade: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                  onChanged: (val){
                                    setState(() {
                                      childGrade[index]=val;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Child DOB: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: DateTimePicker(
                              controller: TextEditingController(text: "DOB"),
                              type: DateTimePickerType.date,
                              dateMask: 'yyyy/MM/dd',
                              firstDate: DateTime(1980),
                              lastDate: DateTime.now(),
                              onChanged: (val) => setState(() => childDob[index] = val),
                              decoration: InputDecoration(
                                prefix: Container(width: 14,),
                                suffix: Icon(Icons.event,color: Theme.of(context).primaryColor,),
                                border: InputBorder.none,
                              ),
                            ),

                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Child Document: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: InkWell(
                                onTap: (){
                                  getChildDoc(index);
                                },
                                child: Container(
                                  height: 52,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(spouse[index]??""),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    );
                  },
                ),
              ),
            ):Container(),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Children",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy')),
                    childName.length>0? IconButton(
                      icon: Icon(Icons.delete,color: Colors.red,),
                      onPressed: (){

                      },
                    ):Container(),
                    Container(),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15, bottom: 15),
                        child: Text("+ Add Child",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      onPressed: (){
                         setState(() {
                           childName.add("null");
                           childImage.add("null");
                           childSchool.add("null");
                           childGrade.add("null");
                           childNationality.add("null");
                           childDob.add("null");
                           childIqama.add("null");
                           childDocument.add("null");
                           print(childDob);
                         });
                      },
                      color: buttonColor,
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 30,),
            workerName.length!=0?Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: workerName.length,
                  itemBuilder: (context,index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Worker Name: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                  onChanged: (val){
                                    setState(() {
                                      workerName[index]=val;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Worker Mobile: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                  onChanged: (val){
                                    setState(() {
                                      workerMobile[index]=val;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Worker DOB: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: DateTimePicker(
                              //controller: TextEditingController(text: spouse["date_of_birth"]??""),
                              type: DateTimePickerType.date,
                              dateMask: 'yyyy/MM/dd',
                              firstDate: DateTime(1980),
                              lastDate: DateTime.now(),
                              onChanged: (val) => setState(() => workerDob[index] = val),
                              decoration: InputDecoration(
                                prefix: Container(width: 14,),
                                suffix: Icon(Icons.event,color: Theme.of(context).primaryColor,),
                                border: InputBorder.none,
                              ),
                            ),

                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Worker Image: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: InkWell(
                                onTap: (){
                                  getWorkerImage(index);
                                },
                                child: Container(
                                  height: 52,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(workerImage[index]??""),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Worker Iqamq: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: InkWell(
                                onTap: (){
                                  getWorkerIq( index);
                                },
                                child: Container(
                                  height: 52,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(workerIqama[index]??""),
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    );
                  },
                ),
              ),
            ):Container(),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Worker",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy')),
                    workerName.length>0? IconButton(
                      icon: Icon(Icons.delete,color: Colors.red,),
                      onPressed: (){

                      },
                    ):Container(),
                    Container(),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15, bottom: 15),
                        child: Text("+ Add Worker",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      onPressed: (){
                        setState(() {
                          workerMobile.add("null");
                          workerName.add("null");
                          workerImage.add("null");
                          workerNationality.add("null");
                          workerDob.add("null");
                          workerImage.add("null");
                          workerIqama.add("null");
                          workerType.add("null");
                          print(workerName);
                        });
                      },
                      color: buttonColor,
                    )
                  ],
                ),
              ),
            ),

            SizedBox(height: 30,),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Move-in-date: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54)
                        ),
                        child: DateTimePicker(
                          controller: TextEditingController(),
                          type: DateTimePickerType.date,
                          dateMask: 'yyyy/MM/dd',
                          firstDate: DateTime(1980),
                          lastDate: DateTime.now(),
                          onChanged: (val) => setState(() => moveIn = val),
                          decoration: InputDecoration(
                            prefix: Container(width: 14,),
                            suffix: Icon(Icons.event,color: Theme.of(context).primaryColor,),
                            border: InputBorder.none,
                          ),
                        ),

                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text('Lease-period: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54)
                        ),
                        child: DateTimePicker(
                          controller: TextEditingController(),
                          type: DateTimePickerType.date,
                          dateMask: 'yyyy/MM/dd',
                          firstDate: DateTime(1980),
                          lastDate: DateTime.now(),
                          onChanged: (val) => setState(() => lastPeriod = val),
                          decoration: InputDecoration(
                            prefix: Container(width: 14,),
                            suffix: Icon(Icons.event,color: Theme.of(context).primaryColor,),
                            border: InputBorder.none,
                          ),
                        ),

                      ),
                    ),
                    CheckboxListTile(
                        title: Text('I confirm above information is true'),
                        value: information,
                        activeColor: Colors.blue,
                        onChanged:(bool newValue){
                          setState(() {
                            information = newValue;
                          });

                        }),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30,),
            make.length!=0?Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: make.length,
                  itemBuilder: (context,index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Make: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                  onChanged: (val){
                                    setState(() {
                                      make[index]=val;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Vehicle Color: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                  onChanged: (val){
                                    setState(() {
                                      vColor[index]=val;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Vehicle Model: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                  onChanged: (val){
                                    setState(() {
                                      vModel[index]=val;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Vehicle Image: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: InkWell(
                                onTap: (){
                                  getVehicleImage(index);
                                },
                                child: Container(
                                  height: 52,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(vImage[index]??""),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Vehicle Insurance: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: InkWell(
                                onTap: (){
                                  getVehicleInsurance(index);
                                },
                                child: Container(
                                  height: 52,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(vInsurance[index]??""),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Driving Licence: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: InkWell(
                                onTap: (){
                                  getDrivingLicence(index);
                                },
                                child: Container(
                                  height: 52,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(drivingLicence[index]??""),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Driving Licence: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: InkWell(
                                onTap: (){
                                  getDrivingLicence(index);
                                },
                                child: Container(
                                  height: 52,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(drivingLicence[index]??""),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Licence Plate: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: InkWell(
                                onTap: (){
                                  getLicencePlate(index);
                                },
                                child: Container(
                                  height: 52,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(vLicencePlate[index]??""),
                                ),
                              ),
                            ),
                          ),
                        ),


                      ],
                    );
                  },
                ),
              ),
            ):Container(),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Vehicle",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy')),
                    make.length>0? IconButton(
                      icon: Icon(Icons.delete,color: Colors.red,),
                      onPressed: (){

                      },
                    ):Container(),
                    Container(),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15, bottom: 15),
                        child: Text("+ Add Vehicle",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      onPressed: (){
                        setState(() {
                          make.add("null");
                          vColor.add("null");
                          vModel.add("null");
                          vLicencePlate.add("null");
                          vImage.add("null");
                          vInsurance.add("null");
                          drivingLicence.add("null");

                        });
                      },
                      color: buttonColor,
                    )
                  ],
                ),
              ),

            ),


            SizedBox(height: 30,),
            petName.length!=0?Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: petName.length,
                  itemBuilder: (context,index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Pet Name: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                  onChanged: (val){
                                    setState(() {
                                      petName[index]=val;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Pet Breed: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                  onChanged: (val){
                                    setState(() {
                                      petBreed[index]=val;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Pet Vaccine: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                  onChanged: (val){
                                    setState(() {
                                      petVac[index]=val;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Pet Type: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                  onChanged: (val){
                                    setState(() {
                                      petType[index]=val;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Pet Age: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: TextFormField(
                                  onChanged: (val){
                                    setState(() {
                                      petAge[index]=val;
                                    });
                                  }
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text('Pet Image: *',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy'),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black54)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: InkWell(
                                onTap: (){
                                  getPetImage(index);
                                },
                                child: Container(
                                  height: 52,
                                  width: MediaQuery.of(context).size.width,
                                  child: Text(petImage[index]??""),
                                ),
                              ),
                            ),
                          ),
                        ),


                      ],
                    );
                  },
                ),
              ),
            ):Container(),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Pet",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17,fontFamily: 'fancy')),
                    petName.length>0? IconButton(
                      icon: Icon(Icons.delete,color: Colors.red,),
                      onPressed: (){

                      },
                    ):Container(),
                    Container(),
                    RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 15, top: 15, bottom: 15),
                        child: Text("+ Add Pet",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      onPressed: (){
                        setState(() {
                          petName.add("null");
                          petImage.add("null");
                          petBreed.add("null");
                          petVac.add("null");
                          petColor.add("null");
                          petType.add("null");
                          petAge.add("null");
                        });
                      },
                      color: buttonColor,
                    )
                  ],
                ),
              ),

            ),

          ],
        ),
      ),
    );
  }

  File _childImage;
  Future getChildImage(int index) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _childImage = File(pickedFile.path);
        //String basename = basename(_spouseImage.path);
        childImage[index]=_childImage.path;
      } else {
        //('No image selected.');
      }
    });
  }
  File _childDoc;
  Future getChildDoc(int index) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _childDoc = File(pickedFile.path);
        //String basename = basename(_spouseImage.path);
        childDocument[index]=_childDoc.path;
      } else {
        //('No image selected.');
      }
    });
  }
  File _spouseImage;
  Future getSpouseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _spouseImage = File(pickedFile.path);
        //String basename = basename(_spouseImage.path);
        spouse["image"]=_spouseImage.path;
      } else {
        //('No image selected.');
      }
    });
  }
  File _spouseDocument;
  Future getSpouseIDocument() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _spouseDocument = File(pickedFile.path);
        spouse["document_copy"]=_spouseDocument.path;
      } else {
        //('No image selected.');
      }
    });
  }
  deleteChild(int index){
    childName.removeAt(index);
    childImage.removeAt(index);
    childSchool.removeAt(index);
    childGrade.removeAt(index);
    childNationality.removeAt(index);
    childDob.removeAt(index);
    childIqama.removeAt(index);
    childDocument.removeAt(index);
    print(childDob);
  }
  File _licencePlate;
  Future getLicencePlate(int index) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _licencePlate = File(pickedFile.path);
        //String basename = basename(_spouseImage.path);
        vLicencePlate[index]=_licencePlate.path;
      } else {
        //('No image selected.');
      }
    });
  }
  File _drivingLicence;
  Future getDrivingLicence(int index) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _drivingLicence = File(pickedFile.path);
        //String basename = basename(_spouseImage.path);
        drivingLicence[index]=_drivingLicence.path;
      } else {
        //('No image selected.');
      }
    });
  }
  File _vInsurance;
  Future getVehicleInsurance(int index) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _vInsurance = File(pickedFile.path);
        //String basename = basename(_spouseImage.path);
        vInsurance[index]=_vInsurance.path;
      } else {
        //('No image selected.');
      }
    });
  }
  File _vImage;
  Future getVehicleImage(int index) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _vImage = File(pickedFile.path);
        //String basename = basename(_spouseImage.path);
        vImage[index]=_vImage.path;
      } else {
        //('No image selected.');
      }
    });
  }
  File _petImage;
  Future getPetImage(int index) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _petImage = File(pickedFile.path);
        //String basename = basename(_spouseImage.path);
        petImage[index]=_petImage.path;
      } else {
        //('No image selected.');
      }
    });
  }
  File _workerImage;
  Future getWorkerImage(int index) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _workerImage = File(pickedFile.path);
        //String basename = basename(_spouseImage.path);
        workerImage[index]=_workerImage.path;
      } else {
        //('No image selected.');
      }
    });
  }
  File _workerIq;
  Future getWorkerIq(int index) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _workerIq = File(pickedFile.path);
        //String basename = basename(_spouseImage.path);
        workerIqama[index]=_workerIq.path;
      } else {
        //('No image selected.');
      }
    });
  }
}
