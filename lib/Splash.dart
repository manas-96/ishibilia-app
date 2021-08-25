import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ishbilia/Auth/Login.dart';
import 'package:ishbilia/helper.dart';
import 'package:ishbilia/screens/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash>  with SingleTickerProviderStateMixin{
  AnimationController animationController;
  Animation<double> animation;
  bool isCompleted=false;
  isLogIn()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString('token')!=null){
      Get.to(HomePage());
    }
    if(mounted){
      setState(() {
        isCompleted=true;
      });
    }
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController=AnimationController(duration: Duration(seconds: 2),vsync: this);
    animation=Tween<double>(
      begin: 0,
      end: 0,
    ).animate(animationController)
      ..addListener((){
        setState(() {

        });
      })
      ..addStatusListener((status){
        if(animationController.isCompleted){
          setState(() {
            isLogIn();
          });
        }
        else if(animationController.isDismissed){
          animationController.forward();
        }
      });
    animationController.forward();
    //checkLoginStatus();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isCompleted?Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/splash.jpg'),fit: BoxFit.cover,
          )
        ),
        child: Stack(
          children: [
            Positioned(
              left: 30,right: 30,
              top: MediaQuery.of(context).size.height*0.4,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  RaisedButton(elevation: 0,
                    child: Text("Log In",style: TextStyle(color: Colors.white),),
                    onPressed: (){
                    Get.to(Login());
                    },
                    color: buttonColor,
                  ),

                  RaisedButton(
                    child: Text("View Website",style: TextStyle(color: Colors.white),),
                    onPressed: (){

                    },
                    color: Colors.black.withOpacity(0.2),
                  ),

                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("You want enquiry ? ",style: TextStyle(color: Colors.white,),),
                    Text("Call Us !",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                  ],
                ),
              )
            )
          ],
        ),
      ):
      Transform.rotate(
        angle: animation.value,
        child: Center(
          child: Container(

              alignment: Alignment.center,
              padding: EdgeInsets.all(30),
              child: Image.asset("images/logo.png",fit: BoxFit.cover,)
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }
}
