import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _Calendar createState() => _Calendar();
}

class _Calendar extends State<Calendar> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;
  late String _currentTime;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _currentTime = _formatTime(DateTime.now());
    _updateTime();
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss a').format(dateTime);
  }

  void _updateTime() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _currentTime = _formatTime(DateTime.now());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 500,
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[600],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                onPageChanged: (focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                  });
                },

                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontSize: 8,
                    color: Colors.black,
                  ),
                  weekendStyle: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),

                calendarStyle: CalendarStyle(
                  defaultTextStyle: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                  weekendTextStyle: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                  todayTextStyle: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  selectedTextStyle: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
                headerStyle: HeaderStyle(
                  titleTextStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _currentTime,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
