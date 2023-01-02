import 'package:flutter/material.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidget();
}

class _SliderWidget extends State<SliderWidget> {
  double _currentSliderValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Slider(
        value: _currentSliderValue,
        max: 100,
        divisions: 100,
        label: _currentSliderValue.round().toString(),
        activeColor: Colors.yellowAccent,
        inactiveColor: Colors.grey,
        onChanged: (double value) {
          setState(() {
            _currentSliderValue = value;
          });
        },
      ),
    );
  }
}
