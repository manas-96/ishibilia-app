import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/screens/Events/BookEvent.dart';

import '../../helper.dart';

class EventDetails extends StatefulWidget {
  final id;

  const EventDetails({Key key, this.id}) : super(key: key);
  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: fetchDetails(),
      ),
    );
  }

  getDetails()async{
    final result = await APIClient().eventDetails(widget.id);
    return result;
  }
  fetchDetails(){
    return FutureBuilder(
      future: getDetails(),
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
        return ListView(
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  image: DecorationImage(
                      image: NetworkImage(snap.data["images"][0]["image"]),fit: BoxFit.contain
                  )
              ),
              alignment: Alignment.topLeft,
              child: SafeArea(
                child: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0,-20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)
                  ),
                  color: Colors.white
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Text(snap.data["subcategory"]["name"],style: TextStyle(fontFamily: 'fancy',fontSize: 19,fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      RatingBarIndicator(
                        rating: snap.data["average_rating"]==null?0:double.parse(snap.data["average_rating"].toString()),
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                      SizedBox(height: 20,),
                      Text("Start : ${DateFormat('MMMM dd, yyyy hh:mm a').format(DateTime.parse(snap.data["start_at"])).toString()}",style: TextStyle(fontFamily: 'regular',fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text("End : ${DateFormat('MMMM dd, yyyy hh:mm a').format(DateTime.parse(snap.data["end_at"])).toString()}",style: TextStyle(fontFamily: 'regular',fontWeight: FontWeight.bold),),
                      SizedBox(height: 5,),
                      Text("Description: ",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "fancy",fontSize: 19),),
                      SizedBox(height: 5,),
                      Text(snap.data["description"],style: TextStyle(fontFamily: 'regular',fontSize: 18,fontWeight: FontWeight.w500,),textAlign: TextAlign.justify,),
                      SizedBox(height: 20,),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 40, top: 15, bottom: 15),
                          child: Text("BOOK",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        onPressed: (){
                          Get.to(BookEvent(
                            id: widget.id,
                          ));
                        },
                        color: Colors.amber,
                      ),
                      SizedBox(height: 25,),
                      takeReview(),
                      SizedBox(height: 8,),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey,width: 0.5)
                        ),
                        padding: EdgeInsets.only(left: 10),
                        child: TextFormField(
                          maxLines: 5,
                          onChanged: (val){
                            _review=val;
                          },
                          decoration: InputDecoration(
                              hintText: snap.data["feedback"]!=null?snap.data["feedback"]["review"]:'Enter Review',
                              border: InputBorder.none
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15, bottom: 15),
                                child: Text("Rate Now",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                              ),
                              onPressed: (){
                                if(_review==""){
                                  _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Please enter review"));
                                }
                                else{
                                  rateNow();
                                }
                              },
                              color: buttonColor,
                            ),
                            SizedBox(width: 20,),
                            RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 15, bottom: 15),
                                child: Text("Remove Rating",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                              ),
                              onPressed: (){
                                delete();
                              },
                              color: Colors.redAccent,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 100,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  String _review="";
  int _rating = 0;


  void rate(int rating) {
    //Other actions based on rating such as api calls.
    setState(() {
      _rating = rating;
    });
  }
  bool checkReview=false;
  takeReview(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // width: 500.0,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new GestureDetector(
              child: new Icon(
                Icons.star,
                color: _rating >= 1 ? Colors.orange : Colors.grey,
              ),
              onTap: () => rate(1),
            ),
            new GestureDetector(
              child: new Icon(
                Icons.star,
                color: _rating >= 2 ? Colors.orange : Colors.grey,
              ),
              onTap: () => rate(2),
            ),
            new GestureDetector(
              child: new Icon(
                Icons.star,
                color: _rating >= 3 ? Colors.orange : Colors.grey,
              ),
              onTap: () => rate(3),
            ),
            new GestureDetector(
              child: new Icon(
                Icons.star,
                color: _rating >= 4 ? Colors.orange : Colors.grey,
              ),
              onTap: () => rate(4),
            ),
            new GestureDetector(
              child: new Icon(
                Icons.star,
                color: _rating >= 5 ? Colors.orange : Colors.grey,
              ),
              onTap: () => rate(5),
            )
          ],
        ),
      ),
    );
  }
  rateNow()async{
    final body={
      "rating": _rating.toString(),
      "review": _review
    };
    final result = await APIClient().eventRating(widget.id, body);
    if(result=="success"){
      _scaffoldKey.currentState.showSnackBar(APIClient.successToast("Successful"));
    }
    else{
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Failed"));
    }
  }
  delete()async{
    final result = await APIClient().deleteEventRating(widget.id);
    if(result=="success"){
      _scaffoldKey.currentState.showSnackBar(APIClient.successToast("Successful"));
    }
    else{
      _scaffoldKey.currentState.showSnackBar(APIClient.errorToast("Failed"));
    }
  }
}
