import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ShowCalender extends StatefulWidget {
  final route;
  final data;

  const ShowCalender({Key key, this.route, this.data}) : super(key: key);
  @override
  _ShowCalenderState createState() => _ShowCalenderState();
}

class _ShowCalenderState extends State<ShowCalender> {
  String _subjectText = '',
      _startTimeText = '',
      _endTimeText = '',
      _dateText = '', _endDate='', _des='',
      _timeDetails = '';
  Color _headerColor, _viewHeaderColor, _calendarColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SfCalendar(
            onTap: calendarTapped,
            view: CalendarView.month,
            dataSource: getCalendarDataSource(),
            monthViewSettings: MonthViewSettings(showAgenda: true),
          ),
        ));
  }


  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Appointment appointmentDetails = details.appointments[0];
      _subjectText = appointmentDetails.subject;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.startTime)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
      if (appointmentDetails.isAllDay) {
        _timeDetails = 'All day';
      } else {
        _timeDetails = '$_startTimeText - $_endTimeText';
      }
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Container(child: new Text('$_subjectText')),
              content: Container(
                height: 80,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          '$_dateText',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(''),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(_timeDetails??"",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15)),
                      ],
                    )
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

  _DataSource getCalendarDataSource()  {
  final List<Appointment> appointments = <Appointment>[];
  appointments.add(Appointment(
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 1)),
    subject: 'Meeting',
    color: Colors.pink,
    isAllDay: true,
  ));
  appointments.add(Appointment(
    startTime: DateTime.now().add(const Duration(hours: 4, days: -1)),
    endTime: DateTime.now().add(const Duration(hours: 5, days: -1)),
    subject: 'Release Meeting',
    color: Colors.lightBlueAccent,
  ));
  appointments.add(Appointment(
    startTime: DateTime.now().add(const Duration(hours: 2, days: -2)),
    endTime: DateTime.now().add(const Duration(hours: 4, days: -2)),
    subject: 'Performance check',
    color: Colors.amber,
  ));
  appointments.add(Appointment(
    startTime: DateTime.now().add(const Duration(hours: 6, days: -3)),
    endTime: DateTime.now().add(const Duration(hours: 7, days: -3)),
    subject: 'Support',
    color: Colors.green,
  ));
  appointments.add(Appointment(
    startTime: DateTime.now().add(const Duration(hours: 6, days: 2)),
    endTime: DateTime.now().add(const Duration(hours: 7, days: 2)),
    subject: 'Retrospective',
    color: Colors.purple,
  ));

  return _DataSource(appointments);
}


class _DataSource extends CalendarDataSource {
  _DataSource(this.source);

  List<Appointment> source;

  @override
  List<dynamic> get appointments => source;
}
