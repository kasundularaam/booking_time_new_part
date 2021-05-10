import 'package:booking_time/constants.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class RoundedDateField extends StatelessWidget {
  // const RoundedDateField({Key key}) : super(key: key);
  final format = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateTimeField(
            decoration: kTextFieldDecoration.copyWith(
                labelText: "Date (${format.pattern})"),
            format: format,
            onShowPicker: (context, currentValue) {
              return showDatePicker(
                context: context,
                initialDate: currentValue ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
            })
      ],
    );
  }
}

class RoundedTimeField extends StatelessWidget {
  final format = DateFormat("HH:mm");
  // const RoundedTimeField({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DateTimeField(
            decoration: kTextFieldDecoration.copyWith(
                labelText: "Time (${format.pattern})"),
            format: format,
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            })
      ],
    );
  }
}
