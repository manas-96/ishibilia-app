import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/screens/Tickets/CreateTicket.dart';
import 'package:ishbilia/screens/Tickets/TicketDetails.dart';

import '../../helper.dart';


class Ticket extends StatefulWidget {
  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
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
                    title: Text("Work Order",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                    trailing: FlatButton(
                      child: Text("Create work order",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      onPressed: (){
                        Get.to(CreateTicket());
                      },
                    ),
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

                child: fetchTicket(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  getTicket()async{
    final result = await APIClient().getTicket();
    return result;
  }
  fetchTicket(){
    return FutureBuilder(
      future: getTicket(),
      builder: (context,snap){
        if(snap.data==null){
          return Center(
            child: Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,mainAxisSpacing: 8
            ),
            itemCount: snap.data.length,
            itemBuilder: (context,index){
              return InkWell(
                onTap: (){
                  Get.to(TicketDetails(
                    id: snap.data[index]["id"].toString(),
                    name: snap.data[index]["villa"]["name"],
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(APIClient().baseUrl+"/${snap.data[index]["villa"]["image"]}"),fit: BoxFit.cover
                    ),
                    color: Colors.white,
                    boxShadow: [new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 0.5,
                    ),],
                    borderRadius: BorderRadius.circular(10),
                    //border: Border.all(color: Theme.of(context).primaryColor,width: 0.5)
                  ),
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white.withOpacity(0.7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Ticket No : ${snap.data[index]["ticket_no"]}",style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 2,),
                          Text("Villa : ${snap.data[index]["villa"]["name"]}",style: TextStyle(fontWeight: FontWeight.bold),),

                        ],
                      ),
                    ),
                  )
                ),
              );
            },
          ),
        );
      },
    );
  }

}
