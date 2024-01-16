import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef TypedOnPicked = Function(DateTime);

class DateAndTimePicker extends StatefulWidget {
  DateAndTimePicker({Key? key,
    required this.onPicked,
    this.initialDay,
    this.initialMonth,
    this.initialYear,
    this.initialHour,
    this.initialMin})
      : super(key: key);
  TypedOnPicked onPicked;
  int? initialYear;
  int? initialMonth;
  int? initialDay;
  int? initialHour;
  int? initialMin;

  @override
  _DateAndTimePickerState createState() => _DateAndTimePickerState();
}

class _DateAndTimePickerState extends State<DateAndTimePicker> {
  final List<int> years = [for (int i = DateTime
      .now()
      .year; i <= 2050; i++) i
  ];
  final List<int> hours = List.generate(24, (index) => index);
  final List<int> minutes = List.generate(60, (index) => index);
  List<int> days = [1, 2, 3];
  int selectedYear = DateTime
      .now()
      .year;
  int selectedMonth = DateTime
      .now()
      .month;
  int selectedDay = DateTime
      .now()
      .day;
  int selectedHour = DateTime
      .now()
      .hour;
  int selectedMin = DateTime
      .now()
      .minute;

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  setData() {
    selectedYear = widget.initialYear ?? DateTime
        .now()
        .year;
    selectedMonth = widget.initialMonth ?? DateTime
        .now()
        .month;
    selectedDay = widget.initialDay ?? DateTime
        .now()
        .day;
    selectedHour = widget.initialHour ?? DateTime
        .now()
        .hour;
    selectedMin = widget.initialMin ?? DateTime
        .now()
        .minute;
  }

  @override
  void initState() {
    setData();
    print("selectedYear$selectedYear");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _showYears(),
          _showMonth(),
          _showDay(),
          Container(
            width: 2,
            color: MyTheme.app_accent_color,
            height: 80,
            // child: Column(),
          ),
          _showHour(),
          _showMin(),
        ],
      ),
    );
  }

  Widget _showYears() {
    // initialYear ??= DateTime.now().year;
    // selectedYear = initialYear;
    return Container(
      width: 40,
      height: 100,
      // color: Colors.red,
      child: Column(
        children: [
          Text(
            "YEAR",
            style: _titleStyle(),
          ),
          SizedBox(
            height: 60,
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(
                  initialItem: years.indexOf(selectedYear)),
              //backgroundColor: Colors.red,
              itemExtent: 25,
              // useMagnifier: false,
              magnification: 1,
              selectionOverlay: Container(
                // color: Colors.red,
              ),
              // diameterRatio: 1.1,
              onSelectedItemChanged: (selected) {
                selectedYear = years[selected];
                _makeDays(setState, selectedYear, selectedMonth);
                _onChanged();
                setState(() {});
              },
              children: List.generate(
                years.length,
                    (index) =>
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Text(
                        "${years[index]}",
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showMonth() {
    // initialMonth ??= DateTime.now().month;

    return Container(
      width: 70,
      height: 100,
      // color: Colors.red,
      child: Column(
        children: [
          Text(
            "MONTH",
            style: _titleStyle(),
          ),
          SizedBox(
            height: 60,
            child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                    initialItem: (selectedMonth - 1)),
                //backgroundColor: Colors.red,
                itemExtent: 25,
                // useMagnifier: false,
                magnification: 1,
                selectionOverlay: Container(
                  // color: Colors.red,
                ),
                // diameterRatio: 1.1,
                onSelectedItemChanged: (selected) {
                  selectedMonth = selected + 1;
                  //print(selectedMonth);
                  _makeDays(setState, selectedYear, selectedMonth);
                  _onChanged();

                  setState(() {});
                },
                children: List.generate(
                    months.length,
                        (index) =>
                        Text(
                          "${months[index]}",
                          style: TextStyle(fontSize: 15),
                        ))),
          ),
        ],
      ),
    );
  }

  Widget _showDay() {
    _makeDays(setState, selectedYear, selectedMonth);

    return SizedBox(
      width: 40,
      height: 100,
      // color: Colors.red,
      child: Column(
        children: [
          Text(
            "DAY",
            style: _titleStyle(),
          ),
          SizedBox(
            height: 60,
            child: CupertinoPicker(
                scrollController: FixedExtentScrollController(
                    initialItem: days.indexOf(selectedDay)),
                //backgroundColor: Colors.red,
                itemExtent: 25,
                // useMagnifier: false,
                magnification: 1,
                selectionOverlay: Container(
                  // color: Colors.red,
                ),
                // diameterRatio: 1.1,
                onSelectedItemChanged: (selected) {
                  selectedDay = days[selected];
                  _onChanged();
                },
                children: List.generate(
                    days.length,
                        (index) =>
                        Text(
                          "${days[index] < 10 ? '0' : ''}${days[index]}",
                          style: const TextStyle(fontSize: 15),
                        ))),
          ),
        ],
      ),
    );
  }

  _makeDays(state, year, month) {
    int i = 1;
    days.clear();
    while (i <= DateUtils.getDaysInMonth(selectedYear, selectedMonth)) {
      days.add(i);
      i++;
    }
    state(() {});
  }

  Widget _showHour() {
    return SizedBox(
      width: 50,
      height: 100,
      // color: Colors.red,
      child: Column(
        children: [
          Text(
            "HOUR",
            style: _titleStyle(),
          ),
          Container(
            alignment: Alignment.center,
            height: 60,
            child: CupertinoPicker(
              looping: true,
              //backgroundColor: Colors.red,
              itemExtent: 25,
              scrollController:
              FixedExtentScrollController(initialItem: (selectedHour)),
              magnification: 1,
              selectionOverlay: Container(
                // color: Colors.red,
              ),
              // diameterRatio: 1.1,
              onSelectedItemChanged: (selected) {
                selectedHour = selected;
                _onChanged();
                setState(() {});
              },
              children: List.generate(
                hours.length,
                    (index) =>
                    Text(
                      "${hours[index] < 10 ? '0' : ''}${hours[index]}",
                      style: const TextStyle(fontSize: 15),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showMin() {
    return SizedBox(
      width: 50,
      height: 100,
      // color: Colors.red,
      child: Column(
        children: [
          Text(
            "MIN",
            style: _titleStyle(),
          ),
          Container(
            alignment: Alignment.center,
            height: 60,
            child: CupertinoPicker(
                looping: true,
                scrollController:
                FixedExtentScrollController(initialItem: (selectedMin)),
                itemExtent: 25,
                // useMagnifier: false,
                magnification: 1,
                selectionOverlay: Container(
                  // color: Colors.red,
                ),
                // diameterRatio: 1.1,
                onSelectedItemChanged: (selected) {
                  selectedMin = selected;
                  _onChanged();
                  setState(() {});
                },
                children: List.generate(
                    minutes.length,
                        (index) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "${minutes[index] < 10
                                ? '0'
                                : ''}${minutes[index]}",
                            style: const TextStyle(fontSize: 15),
                          ),
                        ))),
          ),
        ],
      ),
    );
  }

  _onChanged() {
    DateTime dateTime = DateTime(
        selectedYear, selectedMonth, selectedDay, selectedHour, selectedMin);
    widget.onPicked(dateTime);
  }

  TextStyle _titleStyle() {
    return const TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, color: MyTheme.font_grey);
  }
}
