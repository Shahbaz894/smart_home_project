import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../bloc/switch_bloc.dart';
import '../../bloc/switch_events.dart';
import '../../bloc/switch_state.dart';

class SwitchBlocWidget extends StatelessWidget {
  final DatabaseReference ledRef;
  final int switchNumber; // 1 or 2 for identifying the switch

  const SwitchBlocWidget({Key? key, required this.ledRef, required this.switchNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SwitchBloc switchBloc = BlocProvider.of<SwitchBloc>(context);

    return Center(
      child: BlocBuilder<SwitchBloc, SwitchState>(
        builder: (context, state) {
          bool currentSwitchValue;

          switch (switchNumber) {
            case 1:
              currentSwitchValue = state.switchValue1;
              break;
            case 2:
              currentSwitchValue = state.switchValue2;
              break;
            case 3:
              currentSwitchValue = state.switchValue3; // Assuming you've added switchValue3 in the state
              break;
            case 4:
              currentSwitchValue = state.switchValue4; // Assuming you've added switchValue4 in the state
              break;
            default:
              currentSwitchValue = false; // Handle any unexpected switch numbers
          }

          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Add a Text widget to display the switch status
                Text(
                  'Switch $switchNumber is ${currentSwitchValue ? 'ON' : 'OFF'}',
                  style: TextStyle(
                      fontSize: 20,
                      color: currentSwitchValue ? Colors.red : Colors.green),
                ),
                const SizedBox(height: 20),
                // Use FlutterSwitch instead of the default Switch widget
                FlutterSwitch(
                  width: 150.0,
                  height: 80,
                  valueFontSize: 25.0,
                  toggleSize: 70,
                  toggleColor: Colors.black,
                  value: currentSwitchValue,
                  borderRadius: 40,
                  padding: 8,
                  showOnOff: true,
                  activeColor: Colors.green,
                  inactiveColor: Colors.red,
                  activeText: "ON",
                  inactiveText: "OFF",
                  activeTextColor: Colors.white,
                  inactiveTextColor: Colors.white,
                  activeToggleColor: Colors.white,
                  inactiveToggleColor: Colors.white,
                  onToggle: (value) {
                    ledRef.set(value ? 1 : 0); // Update Firebase value
                    // Dispatch the appropriate event based on the switch number
                    switch (switchNumber) {
                      case 1:
                        context.read<SwitchBloc>().add(UpdateSwitch1Event(newSwitchValue1: value));
                        break;
                      case 2:
                        context.read<SwitchBloc>().add(UpdateSwitch2Event(newSwitchValue2: value));
                        break;
                      case 3:
                        context.read<SwitchBloc>().add(UpdateSwitch3Event(newSwitchValue3: value));
                        break;
                      case 4:
                        context.read<SwitchBloc>().add(UpdateSwitch4Event(newSwitchValue4: value));
                        break;
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
