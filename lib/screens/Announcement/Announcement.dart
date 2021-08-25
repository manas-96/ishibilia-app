import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/DataService/IconsLocation.dart';
import 'package:ishbilia/screens/Announcement/AnnouncementDetails.dart';


import '../../helper.dart';


class Announcement extends StatefulWidget {
  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  ScrollController _controller;
  bool _scroll=false;
  _scrollListener() {
    setState(() {
      _scroll=true;
    });
  }
  @override
  void initState() {
    getData();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: check?Center(
          child: Container(height: 50,width: 50,
            child: CircularProgressIndicator(

            ),
          ),
        ):ListView(
          controller: _controller,
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
                    title: Text("Announcement",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24,fontFamily: 'fancy'),),
                    trailing:  IconButton(
                      icon: Icon(Icons.notifications,color: Colors.white,),
                      onPressed: (){

                      },
                    ),
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
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context,index){
                      return box(index);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  bool check=false;
  var data=[];
  getData()async{
    final result = await APIClient().announcements();
    if(result=='failed'){
      if(mounted){
        setState(() {
          check=true;
        });
      }
    }
    else if(result.isEmpty){
      if(mounted){
        setState(() {
          check=true;
        });
      }
    }
    else{
      setState(() {
        data=result;
      });
    }
  }
  box(int index){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: (){
          Get.to(AnnouncementDetails(
            url: data[index]["image"],
            text: data[index]["name"],
          ));
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [new BoxShadow(
              color: Colors.grey,
              blurRadius: 0.5,
            ),],
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data[index]["image"]),fit: BoxFit.cover,
                  )
                ),
              ),
              SizedBox(width: 10,),
              Container(
                width: MediaQuery.of(context).size.width-120-10-40,
                child: Text('\n ${data[index]["name"]} ',style: TextStyle(color: textColor,fontWeight: FontWeight.bold,
                fontFamily: 'regular',fontSize: 17),),
              )
            ],
          ),

        ),
      ),
    );
  }
}
