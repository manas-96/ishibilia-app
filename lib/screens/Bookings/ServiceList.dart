import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ishbilia/DataService/APIClient.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../helper.dart';

class ServiceList extends StatefulWidget {
  final id;
  final title;

  const ServiceList({Key key, this.id, this.title}) : super(key: key);
  @override
  _ServiceListState createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/splash.jpg'),fit: BoxFit.cover
            )
        ),
        child: Stack(
          children: [
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
                    title: Text(widget.title,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 60,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,

                child: fetchServiceList(),
              ),
            ),
          ],
        )
      ),
    );
  }
  bool check=false;
  Future<List<Meeting>>service()async{
    final data = await APIClient().serviceList(widget.id);
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
          subject: data['title'],
          startTime: _convertDatestartTimeString(
            data['start_at'],
          ),
          des: data["description"],
          endTime: _convertDatestartTimeString(data['end_at']),
          color: Colors.blue[900],
          allDay: data['is_full_day']==1?true:false);
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
             'Data not available',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,fontFamily: 'fancy',color: Colors.white),
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
      _timeDetails = '$_startTimeText - $_endTimeText';
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Container(child: new Text('$_subjectText',style: TextStyle(fontFamily: 'fancy'),)),
              content: Container(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Start: $_startTimeText',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                              fontFamily: 'regular'
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: <Widget>[
                        Text(
                          'End: $_endTimeText',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,fontFamily: 'regular'
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10,),
                    Text("Description :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'regular'),),
                    SizedBox(height: 10,),
                    Text(des??""),

                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: new Text('close'))
              ],
            );
          });
    }
  }
}
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments[index].subject;
  }

  @override
  Color getColor(int index) {
    return appointments[index].color;
  }
  @override
  String getdes(int index) {
    return appointments[index].des;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].allDay;
  }
}

class Meeting {
  Meeting(
      {this.subject,
        this.startTime,
        this.endTime,
        this.color,
        this.des,this.allDay});

  String subject;
  DateTime startTime;
  DateTime endTime;
  Color color;
  String des;
  bool allDay;
}
