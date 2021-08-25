import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../DataService/APIClient.dart';
import '../../helper.dart';
import 'DocumentDetails.dart';

class Documents extends StatefulWidget {
  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(//backgroundColor: Colors.white,
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height*0.7,
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
                          title: Text("Documents",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24,fontFamily: 'fancy'),),

                        )
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 200,
                child: Container(
                  height: MediaQuery.of(context).size.height-201,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: fetch(),
                  ),
                ),
              )
            ],
          )
      ),
    );
  }
  bool check=false;
  documents()async{
    final result = await APIClient().documents();
    print(result);
    if(result.isEmpty||result=="failed"){
      if(mounted){
        setState(() {
          check=true;
        });
      }
    }
    return result;
  }
  fetch(){
    return FutureBuilder(
      future: documents(),
      builder: (context,snap){
        if(check){
          return Center(
            child: Text(
              'Empty Data',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,fontFamily: 'fancy',color: textColor),
            ),
          );
        }
        if(snap.data==null){
          return Center(
            child: Container(
              height:50,width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        return ListView.builder(

          itemCount: snap.data.length,
          itemBuilder: (context,index){
            return Padding(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: (){
                    Get.to(DocumentDeatils(
                      title: snap.data[index]["name"],
                      data: snap.data[index]["documents"],
                    ));
                  },
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
                     // leading: Text("${index+1}"),
                      title: Text(snap.data[index]["name"],style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'fancy',fontSize: 20,color: textColor)),
                      subtitle: Text(snap.data[index]["description"],style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'regular',fontSize: 16,color: Colors.black54)),
                      trailing: Icon(Icons.arrow_forward_ios_sharp),
                    ),
                  )
                )
            );
          },
        );
      },
    );
  }

}
