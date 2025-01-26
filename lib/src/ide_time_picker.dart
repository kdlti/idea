import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class IdeTimePicker extends StatefulWidget {
  final String label;
  final TimeOfDay time;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const IdeTimePicker({
    super.key,
    required this.label,
    required this.time,
    required this.onTimeChanged,
  });

  @override
  State<IdeTimePicker> createState() => _TimePickerFixedScreenState();
}

class _TimePickerFixedScreenState extends State<IdeTimePicker> {
  late TimeOfDay _selectedTime;
  final TextEditingController _controller = TextEditingController();
  bool _isTimeVisible = false;

  var maskFormatter = new MaskTextInputFormatter(mask: '##:##', filter: {"#": RegExp(r'[0-9]')}, type: MaskAutoCompletionType.lazy);

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.time;
    _controller.text = '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 132,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(widget.label, style: const TextStyle(fontSize: 12)),
          ),
          if (!_isTimeVisible)
            SizedBox(
              width: 130,
              child: TextFormField(
                inputFormatters: [maskFormatter],
                controller: _controller,
                decoration: InputDecoration(
                  //contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  isDense: true,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isTimeVisible = true;
                      });
                    },
                    child: const Icon(Icons.access_time),
                  ),
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  if (value.length == 5) {
                    final parts = value.split(':');
                    final newTime = TimeOfDay(
                      hour: int.parse(parts[0]),
                      minute: int.parse(parts[1]),
                    );
                    setState(() {
                      _selectedTime = newTime;
                    });
                  }
                  widget.onTimeChanged(_selectedTime);
                },
              ),
            ),
          if (_isTimeVisible)
            TimePickerWidget(
              initialTime: _selectedTime,
              onTimeChanged: (TimeOfDay newTime) {
                setState(() {
                  _selectedTime = newTime;
                  _controller.text = '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}';
                  widget.onTimeChanged(_selectedTime);
                });
              },
              onClose: (newTime) {
                _isTimeVisible = false;
              },
            ),
        ],
      ),
    );
  }
}

class TimePickerWidget extends StatelessWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;
  final ValueChanged<TimeOfDay> onClose;

  const TimePickerWidget({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.3), // Defina a cor e a largura da borda
            borderRadius: BorderRadius.circular(5), // Defina o raio da borda
          ),
          padding: const EdgeInsets.all(3),
          child: DropdownButton<int>(
            isDense: true,
            borderRadius: BorderRadius.circular(5),
            padding: const EdgeInsets.all(3),
            underline: const SizedBox(),
            value: initialTime.hour,
            onChanged: (int? newHour) {
              if (newHour != null) {
                onTimeChanged(TimeOfDay(hour: newHour, minute: initialTime.minute));
              }
            },
            items: List.generate(24, (index) {
              return DropdownMenuItem<int>(
                value: index,
                child: Text(index.toString().padLeft(2, '0')),
              );
            }),
          ),
        ),
        const Text(
          ' : ',
          style: TextStyle(fontSize: 22),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 1.3), // Defina a cor e a largura da borda
            borderRadius: BorderRadius.circular(5), // Defina o raio da borda
          ),
          padding: const EdgeInsets.all(3),
          child: DropdownButton<int>(
            isDense: true,
            borderRadius: BorderRadius.circular(5),
            padding: const EdgeInsets.all(3),
            underline: const SizedBox(),
            value: initialTime.minute,
            onChanged: (int? newMinute) {
              if (newMinute != null) {
                onTimeChanged(TimeOfDay(hour: initialTime.hour, minute: newMinute));
                onClose(TimeOfDay(hour: initialTime.hour, minute: newMinute));
              }
            },
            items: List.generate(60, (index) {
              return DropdownMenuItem<int>(
                value: index,
                child: Text(index.toString().padLeft(2, '0')),
              );
            }),
          ),
        ),
      ],
    );
  }
}
