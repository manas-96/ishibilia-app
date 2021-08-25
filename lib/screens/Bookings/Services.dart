import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/screens/Bookings/ServiceList.dart';
import 'package:ishbilia/screens/ShowCalender.dart';

import '../../helper.dart';

class Services extends StatefulWidget {
  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
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
                child:  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,

                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                      title: Text("Services",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24,fontFamily: 'fancy'),),

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
                child: fetchService(),
              )
            )
          ],
        ),
      ),
    );
  }

  service()async{
    final result = await APIClient().services();

    return result;
  }
  fetchService(){
    return FutureBuilder(
      future: service(),
      builder: (context,snap){
        if(snap.data==null){
          return Container(
            height: 300,
            child: Center(
              child: Container(
                  height:50,width: 50,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8
            ),
            itemCount: snap.data.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: InkWell(
                  onTap: (){
                    Get.to(ServiceList(id: snap.data[index]['id'].toString(),title: snap.data[index]['name'],));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [new BoxShadow(
                        color: Colors.grey,
                        blurRadius: 0.5,
                      ),],
                    ),
                    alignment: Alignment.center,
                    child: Text(snap.data[index]['name'],style: TextStyle(fontFamily: 'fancy',fontSize: 20,fontWeight: FontWeight.bold,color: textColor),textAlign: TextAlign.center,),
                  ),
                ),
              );
            },
          ),
        );

      },
    );
  }
}
