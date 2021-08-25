import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ishbilia/Auth/Login.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/DataService/IconsLocation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';


class ProfileUpdate extends StatefulWidget {
  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var profileData={};
  getProfile()async{
    final result = await APIClient().profile();
    if(mounted){
      setState(() {
        profileData=result;
        print(profileData);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getProfile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.3,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/splash.jpg'),fit: BoxFit.cover
                    )
                ),
                alignment: Alignment.topCenter,
                child: SafeArea(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                      title: Text("Profile",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                      trailing:  IconButton(
                        icon: Icon(Icons.power_settings_new,color: Colors.white,),
                        onPressed: (){
                          print("jhvfh");
                          _onBackPressed();
                        },
                      ),
                    )
                  ),
                ),
              ),

              Transform.translate(
                offset: Offset(0,-40),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [new BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0.5,
                              ),],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              controller:  TextEditingController(text: profileData["name"]),
                              onChanged: (val){
                                setState(() {
                                  profileData['name']=val;
                                });
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person_outline_outlined,color: textColor,),
                                hintText: 'Name',
                                labelStyle: TextStyle(),
                                border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [new BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0.5,
                              ),],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              controller:  TextEditingController(text: profileData["email"]),
                              onChanged: (val){
                                setState(() {
                                  profileData['email']=val;
                                });
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email_outlined,color: textColor,),
                                  hintText: 'Email',
                                  labelStyle: TextStyle(),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          decoration: BoxDecoration(
                              boxShadow: [new BoxShadow(
                                color: Colors.grey,
                                blurRadius: 0.5,
                              ),],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              controller:  TextEditingController(text: profileData["mobile"]),
                              onChanged: (val){
                                setState(() {
                                  profileData['mobile']=val;
                                });
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.phone_android,color: textColor,),
                                  hintText: 'Mobile',
                                  labelStyle: TextStyle(),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                            ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40.0, right: 40, top: 15, bottom: 15),
                            child: Text("UPDATE",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                          ),
                          onPressed: (){
                            if(profileData['name']==''){
                              _scaffoldKey.currentState.showSnackBar(APIClient.errorToast('Please enter your name'));
                            }
                            else if(profileData['email']==''){
                              _scaffoldKey.currentState.showSnackBar(APIClient.errorToast('Please enter your email'));
                            }
                            else if(profileData['mobile']==''){
                              _scaffoldKey.currentState.showSnackBar(APIClient.errorToast('Please enter your mobile number'));
                            }
                            else{
                              updateProfile();
                            }
                          },
                          color: buttonColor,
                        ),
                      ],
                    ),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
  updateProfile()async{
    final body={
      "name": profileData['name'],
      "email": profileData['email'],
      "mobile": profileData['mobile']
    };
    final result = await APIClient().updateProfile(body);
    if(result!='failed'){
      _scaffoldKey.currentState.showSnackBar(APIClient.successToast('Profile updated successfully'));
    }
  }
  logOut()async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Get.to(Login());
  }
  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.redAccent
                    ),
                    child: InkWell(
                      onTap: (){
                        logOut();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30,top: 5,bottom: 5),
                        child: Text('Log out',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: buttonColor
                    ),
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).pop(false);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30,top: 5,bottom: 5),
                        child: Text('No',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

}
