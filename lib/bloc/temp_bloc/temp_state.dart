import 'package:equatable/equatable.dart';
import 'package:smart_home_project/uitils/temp_status.dart';

import '../../model/temp_model.dart';

import 'package:equatable/equatable.dart';

abstract class TempState extends Equatable {
  const TempState();
}

class TempLoading extends TempState {
  @override
  List<Object?> get props => [];
}

class TempLoaded extends TempState {
  final List<TempData> tempDataList;

  const TempLoaded(this.tempDataList);

  @override
  List<Object?> get props => [tempDataList];
}

class TempError extends TempState {
  final String errorMessage;

  const TempError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}



