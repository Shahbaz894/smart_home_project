


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_project/bloc/switch_events.dart';
import 'package:smart_home_project/bloc/switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super(const SwitchState(switchValue1: false, switchValue2: false)) {
    on<UpdateSwitch1Event>((event, emit) {
      emit(state.copyWith(switchValue1: event.newSwitchValue1));
    });
    on<UpdateSwitch2Event>((event, emit) {
      emit(state.copyWith(switchValue2: event.newSwitchValue2)); // Update switchValue2
    });
    on<UpdateSwitch3Event>((event, emit) {
      emit(state.copyWith(switchValue3: event.newSwitchValue3)); // Update switchValue2
    });
    on<UpdateSwitch4Event>((event, emit) {
      emit(state.copyWith(switchValue4: event.newSwitchValue4)); // Update switchValue2
    });
    on<SliderEvent>((event, emit) {
      emit(state.copyWith(slider: event.slider));
    });
  }
}
