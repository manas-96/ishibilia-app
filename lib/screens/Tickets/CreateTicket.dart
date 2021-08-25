import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/screens/Tickets/SubCategory.dart';

import '../../helper.dart';


class CreateTicket extends StatefulWidget {
  @override
  _CreateTicketState createState() => _CreateTicketState();
}

class _CreateTicketState extends State<CreateTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/splash.jpg'),fit: BoxFit.cover
                    )
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: SafeArea(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back_ios_sharp,color: Colors.white,),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                    title: Text("Deficiency",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 150,
              child: Container(
                height: MediaQuery.of(context).size.height-150,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )
                ),

                child: fetch(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  getData()async{
    final result = await APIClient().deficiencies();
    return result;
  }
  fetch(){
    return FutureBuilder(
      future: getData(),
      builder: (context,snap){
        if(snap.data==null){
          return Center(
            child: Container(
              height: 50,width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 5,mainAxisSpacing: 5),
            itemCount: snap.data.length,
            itemBuilder: (context,index){
              return box(index, snap.data);
            },
          ),
        );
      },
    );
  }
  box(int index,data){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          Get.to(SubCategory(
            data: data[index]["children"],
            id: data[index]["id"].toString(),
            title: data[index]["name"]
          ));
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(data[index]["image"]),fit: BoxFit.cover,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [new BoxShadow(
              color: Colors.grey,
              blurRadius: 0.5,
            ),],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${data[index]["name"]} ',style: TextStyle(color: textColor,fontWeight: FontWeight.bold,
                      fontFamily: 'regular',fontSize: 17),textAlign: TextAlign.start,),
                ),
              )
            ],
          ),

        ),
      ),
    );
  }
}
