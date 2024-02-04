

import 'package:equatable/equatable.dart';

class SwitchState extends Equatable {
  final bool switchValue1;
  final bool switchValue2;
  final bool switchValue3;
  final bool switchValue4;

  final double slider;

  const SwitchState({
    this.switchValue1 = false,
    this.switchValue2 = false,
    this.switchValue3 = false,
    this.switchValue4 = false,
    this.slider = 1,
  });

  SwitchState copyWith({
    bool? switchValue1,
    bool? switchValue2,
    bool? switchValue3,
    bool? switchValue4,
    double? slider,
  }) {
    return SwitchState(
      switchValue1: switchValue1 ?? this.switchValue1,
      switchValue2: switchValue2 ?? this.switchValue2,
      switchValue3: switchValue3 ?? this.switchValue3,
      switchValue4: switchValue4 ?? this.switchValue4,
      slider: slider ?? this.slider,
    );
  }

  @override
  List<Object?> get props => [switchValue1, switchValue2, switchValue3, switchValue4, slider];
}
