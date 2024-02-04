

import 'package:equatable/equatable.dart';

abstract class SwitchEvent extends Equatable {
  const SwitchEvent();

  @override
  List<Object> get props => [];
}

// class SwitchOnOffEvent extends SwitchEvent {}



class SliderEvent extends SwitchEvent {
  final double slider;

  SliderEvent({required this.slider});

  @override
  List<Object> get props => [slider];
}

class UpdateSwitch1Event extends SwitchEvent {
  final bool newSwitchValue1;

  const UpdateSwitch1Event({required this.newSwitchValue1});

  @override
  List<Object> get props => [newSwitchValue1];
}

class UpdateSwitch2Event extends SwitchEvent {
  final bool newSwitchValue2;

  const UpdateSwitch2Event({required this.newSwitchValue2});

  @override
  List<Object> get props => [newSwitchValue2];
}

class UpdateSwitch3Event extends SwitchEvent {
  final bool newSwitchValue3;

  const UpdateSwitch3Event({required this.newSwitchValue3});

  @override
  List<Object> get props => [newSwitchValue3];
}

class UpdateSwitch4Event extends SwitchEvent {
  final bool newSwitchValue4;

  const UpdateSwitch4Event({required this.newSwitchValue4});

  @override
  List<Object> get props => [newSwitchValue4];
}
