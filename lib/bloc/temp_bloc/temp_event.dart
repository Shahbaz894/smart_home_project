import 'package:equatable/equatable.dart';
import 'package:smart_home_project/model/temp_model.dart';

import 'package:equatable/equatable.dart';

abstract class TempEvent extends Equatable {
  const TempEvent();

  @override
  List<Object?> get props => [];
}

class LoadTempData extends TempEvent {}

class AddTempEvent extends TempEvent {
  final TempData tempData;

  const AddTempEvent(this.tempData);

  @override
  List<Object?> get props => [tempData];


}

class DeleteTempEvent extends TempEvent {
  final int id;

  //const DeleteTempEvent(this.id, {required id});
  const DeleteTempEvent({required this.id, });

  @override
  List<Object?> get props => [id];
}
