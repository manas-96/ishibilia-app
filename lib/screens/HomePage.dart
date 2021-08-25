
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/DataService/IconsLocation.dart';
import 'package:ishbilia/screens/Application/Application.dart';
import 'package:ishbilia/screens/Bookings/Services.dart';
import 'package:ishbilia/screens/ChangePassword.dart';
import 'package:ishbilia/screens/Contacts.dart';
import 'package:ishbilia/screens/Announcement/Announcement.dart';
import 'package:ishbilia/screens/Documents/Documents.dart';
import 'package:ishbilia/screens/Events/EventCategories.dart';
import 'package:ishbilia/screens/Faqs.dart';
import 'package:ishbilia/screens/Feedback.dart';
import 'package:ishbilia/screens/ProfileUpdate.dart';
import 'package:ishbilia/screens/Tickets/Ticket.dart';
import 'package:ishbilia/screens/VisitorPass/VisitorPassList.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper.dart';
import 'package:ishbilia/screens/Feedback.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    getSevilla();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/splash.jpg'),fit: BoxFit.fill
                )
              ),
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage('images/logo.jpg'),fit: BoxFit.fill
                        )
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.1,
              alignment: Alignment.center,
              child: Text("Coming home is one of the most beautiful feelings!",
                  style: TextStyle(color: textColor,fontSize: 20,fontFamily: 'fancy',fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.6,
              width:  MediaQuery.of(context).size.width,
              child: GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  crossAxisCount: 3,
                ),
                itemCount: iconList.length,
                itemBuilder: (context,index){
                  return box(iconList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  box(data){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
            boxShadow: [new BoxShadow(
              color: Colors.grey,
              blurRadius: 0.5,
            ),],
        ),
        child: ListTile(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: Image.network(APIClient().baseUrl+data["image"]),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              height: 30,
              alignment: Alignment.bottomCenter,
              child: Text(data["name"],style: TextStyle(color: textColor,fontSize: 13),textAlign: TextAlign.center,),
            )
          ),
          onTap: (){
            if(data['route']=='Announcement')
            Get.to(Announcement());
            else if(data['route']=='Profile')
              Get.to(ProfileUpdate());
            else if(data['route']=='ChangePassword')
              Get.to(ChangePassword());
            else if(data['route']=='Contacts')
              Get.to(Contacts());
            else if(data['route']=='Bookings')
              Get.to(Services());
            else if(data['route']=='Documents')
              Get.to(Documents());
            else if(data['route']=='Application')
              Get.to(Application());
            else if(data['route']=='Faq')
              Get.to(Faqs());
            else if(data['route']=='Feedback')
              Get.to(FeedBack());
            else if(data['route']=='Ticket')
              Get.to(Ticket());
            else if(data['route']=='Calender')
              Get.to(EventCategories());
            else if(data['route']=='Visitor')
              Get.to(VisitorPassList());
            else if(data['route']=='Sevilla')
              _launchInWebViewWithJavaScript();

          },
        ),

      ),
    );
  }
  Future<void> _launchInWebViewWithJavaScript() async {
    try{
      if (await canLaunch(url)) {
        await launch(
          url,
          forceSafariVC: true,
          forceWebView: true,
          enableJavaScript: true,
        );
      } else {
        throw 'Could not launch $url';
      }
    }catch(e){
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Not a valid link"));
    }
  }
  var url;
  getSevilla()async{
    final result = await APIClient().sevilla();
    if(mounted){
      setState(() {
        url=result["sevilla"];
      });
    }
  }

}
