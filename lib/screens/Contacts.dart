import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/screens/ViewContacts.dart';

import '../helper.dart';

class Contacts extends StatefulWidget {
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.black54),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: Text('List of Contacts',style: TextStyle(color: textColor),),
      // ),
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
                        title: Text("Contacts",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 24,fontFamily: 'fancy'),),

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
                  child: displayContact(),
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  getContact()async{
    final result = await APIClient().contacts();

    return result;
  }
  displayContact(){
    return FutureBuilder(
      future: getContact(),
      builder: (context,snap){
        if(snap.data==null){
          return Center(
            child: Container(
              width: 50,height: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8
          ),
          itemCount: snap.data.length,
          itemBuilder: (context,index){
            return Padding(
              padding: EdgeInsets.all(10),
              child: InkWell(
                onTap: (){
                  Get.to(ViewContacts(
                    data: snap.data[index]["contacts"],
                    title: snap.data[index]["name"]??'Details',
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
                    title: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        height: 100,
                        child: Image.network(snap.data[index]["image"],
                          fit: BoxFit.fill,),
                      ),
                    ),
                    subtitle: Padding(
                        padding: const EdgeInsets.only(bottom: 5.0,top: 8),
                        child: Container(
                          height: 30,
                          alignment: Alignment.bottomCenter,
                          child: Text(snap.data[index]["name"],style: TextStyle(color: textColor,fontSize: 20,fontWeight: FontWeight.bold,
                          fontFamily: 'fancy'),textAlign: TextAlign.center,),
                        )
                    ),
                  )
                ),
              )
            );
          },
        );
      },
    );
  }


}
