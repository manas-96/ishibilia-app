import 'dart:convert';
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ishbilia/DataService/APIClient.dart';

import '../../helper.dart';
import 'package:http/http.dart'as http;

class CreateWorkOrder extends StatefulWidget {
  final id;
  final other;
  final title;
  final subtitle;

  const CreateWorkOrder({Key key, this.id,this.other, this.title, this.subtitle}) : super(key: key);
  @override
  _CreateWorkOrderState createState() => _CreateWorkOrderState();
}

class _CreateWorkOrderState extends State<CreateWorkOrder> {
  String other='';
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String date,time;
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("Create Work Order",style: TextStyle(color: textColor),),

      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/splash.jpg"),fit: BoxFit.cover
          )
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white.withOpacity(0.6),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white,
                          border: Border.all(color: Colors.black54)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextFormField(
                          readOnly: true,
                          initialValue: widget.title,
                          onChanged: (val){

                          },
                          decoration: InputDecoration(
                              hintText: widget.title,
                              border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
                  ),
                  widget.other?Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white,
                          border: Border.all(color: Colors.black54)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextFormField(
                          onChanged: (val){
                            other=val;
                          },
                          decoration: InputDecoration(
                            hintText: 'Specify others'
                          ),
                        ),
                      ),
                    ),
                  ):Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white,
                          border: Border.all(color: Colors.black54)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextFormField(
                          readOnly: true,
                          initialValue: widget.subtitle,
                          onChanged: (val){

                          },
                          decoration: InputDecoration(
                              hintText: widget.subtitle,
                            border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white,
                          border: Border.all(color: Colors.black54)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: DateTimePicker(
                          type: DateTimePickerType.date,
                          dateMask: 'yyyy/MM/dd',
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                          icon: Icon(Icons.event,color: textColor,),
                          dateLabelText: 'Date',
                          onChanged: (val) => setState(() => date = val),
                          decoration: InputDecoration(
                              icon: Icon(Icons.event,color: textColor,),
                            border: InputBorder.none,
                            labelText: 'Date',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white,
                          border: Border.all(color: Colors.black54)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: DateTimePicker(
                          type: DateTimePickerType.time,
                          icon: Icon(Icons.access_time,color: textColor,),
                          timeLabelText: "Time",
                          onChanged: (val) => setState(() => time = val),
                          decoration: InputDecoration(
                            icon: Icon(Icons.access_time,color: textColor,),
                            border: InputBorder.none,
                            labelText: 'Time',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: InkWell(
                      onTap: (){
                        getFile();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 54,
                        decoration: BoxDecoration(color: Colors.white,
                            border: Border.all(color: Colors.black54)
                        ),
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Text("Choose image",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 17),),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,),
                  file!=null?Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.file(file,height: 200,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                  ):Container(),
                  SizedBox(height: 30,),
                  RaisedButton(
                    color: buttonColor,
                    onPressed: (){
                      print(date);print(time);getImage();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0, right: 40, top: 15, bottom: 15),
                      child: task?CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ):Text("Create work order",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  bool task=false;
  var _image;
  File file;
  final picker = ImagePicker();
  Future getFile() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
         file = File(pickedFile.path);
        _image=file.path;
      } else {
        //('No image selected.');
      }
    });
  }
  getImage()async{
    if(date==null){
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Please select date"));
    }
    else if(time==null){
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Please select time"));
    }
    else if(_image==null){
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Please choose image"));
    }
    else{
      if(mounted){
        setState(() {
          task=true;
        });
      }
      if(_image!=null){
        final header= await APIClient().buildHeaderWithToken();
        var request = http.MultipartRequest('post', Uri.parse(APIClient().apiUrl+"tickets"),);
        print("req");
        print(request);
        _scaffoldKey.currentState.showSnackBar(APIClient.successToast("Request submitted"));
        if(mounted){
          setState(() {
            task=false;
          });
        }
        request.headers.addAll(header);
        request.files.add(await http.MultipartFile.fromPath("image", _image,),);
        request.files.add(await http.MultipartFile.fromPath("appointment_at", "$date $time",),);
        request.files.add(await http.MultipartFile.fromPath("deficiency", widget.id,),);
        var res = await request.send();
        print(res.statusCode);
        if(res.statusCode==201){
          var response= await http.Response.fromStream(res);
          print('printing...');
          var result=await json.decode(response.body);
          if(mounted){
            setState(() {
              task=false;
            });
          }
          print(result);
          _scaffoldKey.currentState.showSnackBar(APIClient.successToast("Image Uploaded"));
        }else{
          _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Failed"));
        }
      }
    }

  }
}


