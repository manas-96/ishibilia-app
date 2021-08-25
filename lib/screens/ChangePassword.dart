import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ishbilia/DataService/APIClient.dart';

import '../helper.dart';


class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String oldPass='';
  String newPass='';
  String confirmPass='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.35,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    image: DecorationImage(
                        image: AssetImage('images/splash.jpg'),fit: BoxFit.fill
                    )
                ),
                alignment: Alignment.topLeft,
                child: SafeArea(
                  child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,

                      child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                        title: Text("Change Password",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22,fontFamily: 'fancy'),),

                      )
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(0,-20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [new BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                            ),],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8),
                            child: TextFormField(
                              obscureText: true,
                              onChanged: (val){
                                oldPass=val;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Old Password',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [new BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                            ),],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8),
                            child: TextFormField(
                              obscureText: true,
                              onChanged: (val){
                                newPass=val;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'New Password',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [new BoxShadow(
                              color: Colors.grey,
                              blurRadius: 0.5,
                            ),],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0,right: 8),
                            child: TextFormField(
                              obscureText: true,
                              onChanged: (val){
                                confirmPass=val;
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Confirm Password',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40,),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40.0, right: 40, top: 15, bottom: 15),
                            child: Text("SUBMIT",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,fontFamily: 'regular'),),
                          ),
                          onPressed: (){
                            if(oldPass==''){
                              _scaffoldKey.currentState.showSnackBar(APIClient.errorToast('Please enter your current password'));
                            }
                            else if(newPass==''){
                              _scaffoldKey.currentState.showSnackBar(APIClient.errorToast('Please enter your new password'));
                            }
                            else if(confirmPass==''){
                              _scaffoldKey.currentState.showSnackBar(APIClient.errorToast('Confirm your password'));
                            }
                            else{
                              changePassword();
                            }
                          },
                          color: buttonColor,
                        ),
                      ],
                    )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  changePassword()async{
    final body={
      "old_password": oldPass,
      "password": newPass,
      "password_confirmation": confirmPass
    };
    final result = await APIClient().changePass(body);
    if(result!='failed'){
      _scaffoldKey.currentState.showSnackBar(APIClient.successToast('Password changed successfully'));
    }
  }
}
