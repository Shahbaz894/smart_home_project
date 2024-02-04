// import 'package:firebase_database/firebase_database.dart';
//
// import '../model/temp_model.dart';
//
// class TempFirebase {
//
//   final DatabaseReference _temperatureRef =
//   FirebaseDatabase.instance.reference().child('UsersData');
//
//
//   Future<List<TempModel>> tempFirebaseValue() async {
//     try {
//       // Use .once() to get a DatabaseEvent
//       DatabaseEvent event = await _temperatureRef.once();
//      // print(_temperatureRef);
//
//       // Extract data from DatabaseEvent
//       Map<dynamic, dynamic>? data =
//       event.snapshot.value as Map<dynamic, dynamic>?;
//
//       List<TempModel> tempList = [];
//
//       // Ensure data is not null before iterating
//       if (data != null) {
//         data.forEach((key, value) {
//           // Convert timestamp string to DateTime
//           DateTime timestamp = DateTime.parse(value['timestamp']);
//
//           // Create TempModel objects
//           TempModel tempModel = TempModel(
//             id: key,
//             tempValue: value['tempValue'],
//             timestamp: timestamp,
//           );
//
//           tempList.add(tempModel);
//         });
//       }
//
//       return tempList;
//     } catch (error) {
//       // Handle error, log, or report as needed
//       print('Error fetching temperature data: $error');
//       return [];
//     }
//   }
// }
//
