import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/switch_bloc.dart';
import '../../bloc/switch_events.dart';
import '../../bloc/switch_state.dart';

class SliderBlocWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DatabaseReference _ledRef2 =
    FirebaseDatabase.instance.reference().child('board1/outputs/digital/2');
    final DatabaseReference _slider =
    FirebaseDatabase.instance.reference().child('brightness');
    final SwitchBloc switchBloc = BlocProvider.of<SwitchBloc>(context);

    // Set the increment value for the slider
    final double incrementValue = 1.0;

    return Center(
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 20.0,right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: Slider(
                        value: state.slider.clamp(0.0, 100.0), // Ensure slider value is between 0.0 and 100.0
                        onChanged: (value) {
                          // Update the Firebase value when the slider is changed
                          _slider.set(value);

                          // Dispatch the Bloc event
                          context.read<SwitchBloc>().add(SliderEvent(slider: value));
                        },
                        min: 0.0, // Set the minimum value of the slider
                        max: 100.0, // Set the maximum value of the slider
                      ),
                    ),

                    Positioned(

                     right: 0, // Adjust the position of the IconButton as needed
                      top: 0.0, // Adjust the position of the IconButton as needed
                      child: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          if (state.slider < 100.0) {
                            // Increment the slider value by the specified increment value
                            double newValue =
                            (state.slider + incrementValue).clamp(0.0, 100.0);

                            // Update the Firebase value
                            _slider.set(newValue);

                            // Dispatch the Bloc event
                            context
                                .read<SwitchBloc>()
                                .add(SliderEvent(slider: newValue));
                          }
                        },
                      ),
                    ),
                  ],
                ),

                Text('Slider Value: ${state.slider.toStringAsFixed(2)}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

// Slider(
// value: _brightness,
// onChanged: (newValue) {
// setState(() {
// _brightness = newValue;
// });
// _updateBrightness(newValue);
// },
// min: 0,
// max: 100,
// divisions: 100, // Added divisions to show tick marks
// label: '$_brightness', // Added a label
// ),