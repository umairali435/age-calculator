import 'package:agecalculate/constants/colors.dart';
import 'package:agecalculate/logics/comparison_date_logic.dart';
import 'package:agecalculate/provider/update_inital_time_provider.dart';
import 'package:agecalculate/provider/update_time_provider.dart';
import 'package:agecalculate/screens/custom_drawer.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AgeAndBirthdayCalculator extends StatefulWidget {
  const AgeAndBirthdayCalculator({super.key});

  @override
  State<AgeAndBirthdayCalculator> createState() => _AgeAndBirthdayCalculatorState();
}

class _AgeAndBirthdayCalculatorState extends State<AgeAndBirthdayCalculator> {
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('d MMMM yyyy');
    return formatter.format(date);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   Provider.of<UpdateTimeProvider>(context, listen: false).updateTime();
  // }

  @override
  Widget build(BuildContext context) {
    final dateProvider = Provider.of<UpdateInitialDateTimeProvider>(context);
    return Scaffold(
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xFFF2F1EB),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        title: const Text(
          "Age & Birthday Calculator",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0),
            child: Row(
              children: [
                Text(
                  "Today: ${formatDate(DateTime.now())}",
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          AgeContainer(
            dateTime: ComparisonDateLogic.calculateDateDifference(
              dateProvider.initialDate,
              DateTime.now(),
            ),
          ),
          FutureTile(
            title: "Next",
            initialDateTime: dateProvider.initialDate,
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              border: Border.all(width: 1.0, color: Colors.grey.withOpacity(0.2)),
            ),
            child: Calender(
              value: dateProvider.initialDate,
              onValueChanged: (dates) {
                setState(() {
                  dateProvider.initialDate = dates[0];
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Calender extends StatelessWidget {
  final DateTime value;
  final Function(List<DateTime>)? onValueChanged;
  const Calender({super.key, required this.value, this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        firstDate: DateTime(1970),
        lastDate: DateTime.now(),
      ),
      value: [value],
      onValueChanged: onValueChanged,
    );
  }
}

class AgeContainer extends StatelessWidget {
  final DateTime dateTime;
  const AgeContainer({super.key, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          BirthdayTile(
            title: "Years",
            subtitle: dateTime.year.toString(),
          ),
          BirthdayTile(
            title: "Months",
            subtitle: dateTime.month.toString(),
          ),
          BirthdayTile(
            title: "Days",
            subtitle: dateTime.day.toString(),
          ),
        ],
      ),
    );
  }
}

class BirthdayTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const BirthdayTile({super.key, required this.subtitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            color: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            color: AppColors.whiteColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  subtitle,
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w800,
                    fontSize: 28.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FutureTile extends StatefulWidget {
  final String title;
  final DateTime initialDateTime;
  const FutureTile({
    super.key,
    required this.title,
    required this.initialDateTime,
  });

  @override
  State<FutureTile> createState() => _FutureTileState();
}

class _FutureTileState extends State<FutureTile> {
  @override
  Widget build(BuildContext context) {
    Provider.of<UpdateTimeProvider>(context).updateTime(context);
    return Consumer<UpdateTimeProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      color: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title,
                            style: const TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      color: AppColors.whiteColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            value.days.toString(),
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w800,
                              fontSize: 28.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              ":",
                              style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.w800,
                                fontSize: 28.0,
                              ),
                            ),
                          ),
                          Text(
                            value.hours.toString(),
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w800,
                              fontSize: 28.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              ":",
                              style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.w800,
                                fontSize: 28.0,
                              ),
                            ),
                          ),
                          Text(
                            value.minutes.toString(),
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w800,
                              fontSize: 28.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              ":",
                              style: GoogleFonts.notoSans(
                                fontWeight: FontWeight.w800,
                                fontSize: 28.0,
                              ),
                            ),
                          ),
                          Text(
                            value.seconds.toString(),
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w800,
                              fontSize: 28.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
