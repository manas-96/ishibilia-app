import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/screens/HomePage.dart';

import '../helper.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String email='';
  String pass='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/splash.jpg'),fit: BoxFit.cover
          )
        ),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white.withOpacity(0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      onChanged: (val){
                        email=val;
                      },
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.only(left: 10),
                    child: TextFormField(
                      obscureText: true,
                      onChanged: (val){
                        pass=val;
                      },
                      decoration: InputDecoration(
                          hintText: 'Password',
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, right: 40, top: 15, bottom: 15),
                    child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                  ),
                  onPressed: (){
                    if(email==''){
                      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast('Please enter email'));
                    }
                    else if(pass==''){
                      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast('Please enter password'));
                    }
                    else{
                      logIn();
                    }
                  },
                  color: buttonColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  logIn()async{
    final body={
      "email": email,
      "password": pass,
      "device_name": "mobile"
    };
    final response = await APIClient().login(body);
    if(response!='failed'){
      Get.to(HomePage());
    }
    else{
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast('Please valid credential'));
    }
  }
}
