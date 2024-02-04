import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_home_project/bloc/temp_bloc/temp_event.dart';
import 'package:smart_home_project/bloc/temp_bloc/temp_state.dart';
import '../../model/temp_model.dart';
import '../../repository/temp_repository.dart';

class TempBloc extends Bloc<TempEvent, TempState> {
  final DatabaseReference _temperatureRef =
  FirebaseDatabase.instance.reference().child('UsersData');

  TempBloc() : super(TempLoading()) {
    // Initialize streams within the constructor
    _temperatureRef.onValue.listen((event) {
      final dynamic data = event.snapshot.value;

      if (data is Map<Object?, Object?>) {
        // Check if 'temperature' is present in the map
        if (data.containsKey('temperature')) {
          // Attempt to extract 'temperature' and cast it to a double
          final tempValue = data['temperature'];
          if (tempValue is double) {
            // 'temperature' is a double, proceed with adding to bloc
            add(AddTempEvent(TempData(
              //This should help in generating a unique ID for each entry.
              id: DateTime.now().millisecondsSinceEpoch,
              //id: 3  ,
              tempValue: tempValue,
              timestamp: DateTime.now(),
            )));
          } else {
            // Handle the case where 'temperature' is not a double
            print('Invalid temperature format: $tempValue');
          }
        } else {
          // Handle the case where 'temperature' is not present in the map
          print('temperature not found in data: $data');
        }
      } else {
        // Handle the case where the data is not a map
        print('Invalid data format: $data');
      }
    });

    on<LoadTempData>((event, emit) async {
      try {
        final tempData = await DatabaseHelper.getAllTempData();
        emit(TempLoaded(tempData));
      } catch (e) {
        emit(TempError(e.toString()));
      }
    });

    on<AddTempEvent>((event, emit) async {
      try {
        await DatabaseHelper.insertTempData(event.tempData);
        final tempData = await DatabaseHelper.getAllTempData();
        emit(TempLoaded(tempData));
      } catch (e) {
        emit(TempError(e.toString()));
      }
    });

    on<DeleteTempEvent>((event, emit) async {
      if (event.id != null) {
        try {
          await DatabaseHelper.deleteTempData(event.id!);
          final tempData = await DatabaseHelper.getAllTempData();
          emit(TempLoaded(tempData));
        } catch (e) {
          emit(TempError(e.toString()));
        }
      } else {
        emit(TempError("Invalid ID"));
      }
    });
  }
}
