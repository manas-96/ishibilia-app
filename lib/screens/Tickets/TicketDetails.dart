import 'package:flutter/material.dart';
import 'package:ishbilia/DataService/APIClient.dart';

import '../../helper.dart';


class TicketDetails extends StatefulWidget {
  final id;
  final name;

  const TicketDetails({Key key, this.id, this.name}) : super(key: key);
  @override
  _TicketDetailsState createState() => _TicketDetailsState();
}

class _TicketDetailsState extends State<TicketDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    title: Text(widget.name,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
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

                child: fetchDetails(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  getDetails()async{
    final result = await APIClient().ticketDetails(widget.id);
    return result;
  }
  fetchDetails(){
    return FutureBuilder(
      future: getDetails(),
      builder: (context,snap){
        if(snap.data==null){
          return Center(
            child: Container(
              height: 50,width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        }
        return ListView(

          padding: EdgeInsets.all(15),
          children: [
            Column( crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text("Ticket No :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'fancy'),),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xffe9ecef),
                    border: Border.all(width: 0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snap.data["ticket_no"],style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Column( crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text("Villa No :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'fancy'),),
                SizedBox(height: 5,),
                Container(width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xffe9ecef),
                      border: Border.all(width: 0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snap.data["villa"]["villa_no"],style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
                  ),
                )

              ],
            ),
            SizedBox(height: 10,),
            Column( crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text("Villa Name :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'fancy'),),
                SizedBox(height: 5,),
                Container(width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xffe9ecef),
                      border: Border.all(width: 0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snap.data["villa"]["name"],style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Column( crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text("Name :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'fancy'),),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xffe9ecef),
                      border: Border.all(width: 0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snap.data["user_id"]["name"],style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),

            Column( crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text("Mobile :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'fancy'),),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xffe9ecef),
                      border: Border.all(width: 0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snap.data["user_id"]["mobile"],style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
                  ),
                )
                //Text(snap.data["user_id"]["mobile"],style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
              ],
            ),
            SizedBox(height: 10,),
            Column( crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text("Deficiency :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'fancy'),),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xffe9ecef),
                      border: Border.all(width: 0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snap.data["deficiency"]["parent"]["name"],style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
                  ),
                )
               // Text(snap.data["deficiency"]["name"],style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
              ],
            ),
            SizedBox(height: 10,),
            Column( crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text("Sub-deficiency :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'fancy'),),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xffe9ecef),
                      border: Border.all(width: 0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snap.data["deficiency"]["name"],style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
                  ),
                )
                //Text(snap.data["deficiency"]["name"],style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
              ],
            ),
            SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text("Priority :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'fancy'),),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xffe9ecef),
                      border: Border.all(width: 0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snap.data["priority"]==1?"Low":snap.data["priority"]==2?"Medium":"High",style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
                  ),
                )
               // Text(snap.data["priority"]==1?"Low":snap.data["priority"]==2?"Medium":"High",style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
              ],
            ),
            SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text("Remarks :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'fancy'),),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xffe9ecef),
                      border: Border.all(width: 0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snap.data["remarks"]??"",style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
                  ),
                )
                // Text(snap.data["priority"]==1?"Low":snap.data["priority"]==2?"Medium":"High",style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
              ],
            ),
            SizedBox(height: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10,),
                Text("Material used :",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'fancy'),),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xffe9ecef),
                      border: Border.all(width: 0.5)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snap.data["material_used"]??"",style: TextStyle(fontSize: 18,fontFamily: 'regular',fontWeight: FontWeight.w500),),
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("Villa access allowed in absence ? ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,fontFamily: 'fancy'),),
                  Checkbox(
                    value: snap.data["is_access_allowed"]==1?true:false,
                    onChanged: (bool value) {
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 70,),
          ],
        );
      },
    );
  }
}
