import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:ishbilia/screens/Bookings/ServiceList.dart';
import 'package:ishbilia/screens/Events/EventDetails.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../helper.dart';


class EventCalender extends StatefulWidget {
  final title;
  final id;

  const EventCalender({Key key, this.title, this.id}) : super(key: key);
  @override
  _EventCalenderState createState() => _EventCalenderState();
}

class _EventCalenderState extends State<EventCalender> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.title,style: TextStyle(color: textColor),),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/splash.jpg'),fit: BoxFit.cover
            )
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white.withOpacity(0.6),
          child: fetchServiceList(),
        ),
      ),
    );
  }
  bool check=false;
  Future<List<Meeting>>service()async{
    final data = await APIClient().eventSubCategory(widget.id);
    if(data.isEmpty){
      if(mounted){
        setState(() {
          check=true;
        });
      }
    }
    print(data);
    final List<Meeting> appointmentData = [];
    for(var data in data){
      Meeting meetingData = Meeting(
          subject: data['subcategory']["name"],
          startTime: _convertDatestartTimeString(
            data['start_at'],
          ),
          des: data["description"],
          endTime: _convertDatestartTimeString(data['end_at']),
          color: Colors.blue[900],
          allDay: false);
      appointmentData.add(meetingData);
    }
    print('done' +appointmentData.toString());
    print(appointmentData);
    return appointmentData;
  }
  DateTime _convertDatestartTimeString(String date) {
    return DateTime.parse(date);
  }
  fetchServiceList(){
    return FutureBuilder(
      future: service(),
      builder: (context,snap){
        if(check){
          return Center(
            child: Text(
              'Data not available',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,fontFamily: 'fancy',color: textColor),
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
        return SafeArea(
          child: SfCalendar(
            onTap: calendarTapped,
            view: CalendarView.month,
            dataSource: MeetingDataSource(snap.data),
            monthViewSettings: MonthViewSettings(showAgenda: true),
          ),
        );
      },
    );
  }
  String _subjectText='',_dateText='',_startTimeText='',_endTimeText='',_timeDetails='',des='';
  void calendarTapped(CalendarTapDetails details,) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Meeting appointmentDetails = details.appointments[0];
      _subjectText = appointmentDetails.subject;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.startTime)
          .toString();
      _startTimeText =
          DateFormat('MMMM dd, yyyy hh:mm a').format(appointmentDetails.startTime).toString();
      _endTimeText =
          DateFormat('MMMM dd, yyyy hh:mm a').format(appointmentDetails.endTime).toString();
      des=appointmentDetails.des;
      Get.to(EventDetails(id: widget.id,));
      // _timeDetails = '$_startTimeText - $_endTimeText';
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         title: Container(child: new Text('$_subjectText',style: TextStyle(fontFamily: 'fancy'),)),
      //         content: Container(
      //
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: <Widget>[
      //               Row(
      //                 children: <Widget>[
      //                   Text(
      //                     'Start: $_startTimeText',
      //                     style: TextStyle(
      //                         fontWeight: FontWeight.w400,
      //                         fontSize: 18,
      //                         fontFamily: 'regular'
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               SizedBox(height: 2,),
      //               Row(
      //                 children: <Widget>[
      //                   Text(
      //                     'End: $_endTimeText',
      //                     style: TextStyle(
      //                         fontWeight: FontWeight.w400,
      //                         fontSize: 18,fontFamily: 'regular'
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //
      //               SizedBox(height: 10,),
      //               Text("Description :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'regular'),),
      //               SizedBox(height: 10,),
      //               Text(des??""),
      //
      //             ],
      //           ),
      //         ),
      //         actions: <Widget>[
      //           new FlatButton(
      //               onPressed: () {
      //                 Navigator.of(context).pop();
      //               },
      //               child: new Text('Close')),
      //           new FlatButton(
      //               onPressed: () {
      //                 Get.to(EventDetails(id: widget.id,));
      //               },
      //               child: new Text('View'))
      //         ],
      //       );
      //     });
    }
  }
}

