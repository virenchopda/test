
class C2 extends StatefulWidget {
  @override
  _C2State createState() => _C2State();
}

class _C2State extends State<C2> {
  late final ValueNotifier<List<DateTime>> _selectedDates;
  late DateTime _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late Map<DateTime, List<Event>> _events;

  @override
  void initState() {
    super.initState();
    _selectedDates = ValueNotifier([]);
    _focusedDay = DateTime.now();
    _events = {
      DateTime.utc(2023, 9, 14): [Event('Event 1')],
      DateTime.utc(2023, 9, 18): [Event('Event 2')],
      DateTime.utc(2023, 9, 19): [Event('Event 3')],
    };
  }

  @override
  void dispose() {
    _selectedDates.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[day] ?? [];
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      if (_selectedDates.value.contains(day)) {
        _selectedDates.value = List.from(_selectedDates.value)..remove(day);
      } else {
        _selectedDates.value = List.from(_selectedDates.value)..add(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Multiple Date Selection Calendar')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            rowHeight: 70,
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return _selectedDates.value.contains(day);
            },
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              _calendarFormat = format;
              setState(() {});
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
              setState(() {});
            },
            eventLoader: _getEventsForDay,
            daysOfWeekStyle: DaysOfWeekStyle(
              dowTextFormatter: (date, locale) =>
                  DateFormat.E(locale).format(date).substring(0, 1),
            ),
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, date, _) {
                return Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey, width: 1),
                      left: BorderSide(color: Colors.grey, width: 1),
                      right: BorderSide(color: Colors.grey, width: 1),
                      bottom: BorderSide(color: Colors.grey, width: 1),
                    ),
                  ),
                  child: Text(
                    '${date.day} ₹',
                    style: const TextStyle().copyWith(color: Colors.black),
                  ),
                );
              },
              todayBuilder: (context, date, events) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.green, width: 2.0),
                  ),
                  child: Text(
                    '${date.day} ₹',
                    style: const TextStyle().copyWith(color: Colors.white),
                  ),
                );
              },
              selectedBuilder: (context, date, events) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.rectangle,
                    // borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.green, width: 2.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 5,
                            height: 5,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3),
                        child: Text(
                          date.day.toString(),
                          style:
                              const TextStyle().copyWith(color: Colors.white),
                        ),
                      ),
                      Text(
                        '\$',
                        style: const TextStyle().copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                );
              },
              outsideBuilder: (context, date, events) {
                return Container(); // Return an empty container for dates outside the current month
              },
            ),
            calendarStyle: const CalendarStyle(
              isTodayHighlighted: true,
              outsideDaysVisible: false,
              canMarkersOverflow: true,

              // markerDecoration: BoxDecoration(
              //   color: Colors.red,
              //   shape: BoxShape.circle,
              // ),
            ),
          ),
          ValueListenableBuilder<List<DateTime>>(
            valueListenable: _selectedDates,
            builder: (context, value, _) {
              return Wrap(
                children: value.map((date) {
                  return Chip(
                    label: Text(date.toString()),
                    onDeleted: () {
                      setState(() {
                        _selectedDates.value = List.from(_selectedDates.value)
                          ..remove(date);
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class Event {
  final String title;

  Event(this.title);

  @override
  String toString() => title;
}


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


class C1 extends StatefulWidget {
  const C1({super.key});

  @override
  _C1State createState() => _C1State();
}

class _C1State extends State<C1> {
  late final ValueNotifier<List<DateTime>> _selectedDates;
  late DateTime _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    _selectedDates = ValueNotifier([]);
    _focusedDay = DateTime.now();
  }

  @override
  void dispose() {
    _selectedDates.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    _focusedDay = focusedDay;
    if (_selectedDates.value.contains(day)) {
      _selectedDates.value = List.from(_selectedDates.value)..remove(day);
    } else {
      _selectedDates.value = List.from(_selectedDates.value)..add(day);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Multiple Date Selection Calendar')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return _selectedDates.value.contains(day);
            },
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: Colors.green,
                  width: 2.0,
                ),
              ),
            ),
          ),
          ValueListenableBuilder<List<DateTime>>(
            valueListenable: _selectedDates,
            builder: (context, value, _) {
              return Wrap(
                children: value.map((date) {
                  return Chip(
                    label: Text(date.toString()),
                    onDeleted: () {
                      setState(() {
                        _selectedDates.value = List.from(_selectedDates.value)
                          ..remove(date);
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}


