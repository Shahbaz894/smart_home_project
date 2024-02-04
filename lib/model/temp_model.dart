// class TempModel {
//   final int? id;
//   final double? tempValue;
//   final DateTime? timestamp;
//
//   TempModel({required this.id, required this.tempValue, required this.timestamp});
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'tempValue': tempValue,
//       'timestamp': timestamp.toString(),
//     };
//   }
// }
class TempData {
  final int id;
  final double tempValue;
  final DateTime timestamp;

  TempData({required this.tempValue, required this.timestamp, required this.id});

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'tempValue': tempValue,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  factory TempData.fromMap(Map<String, dynamic> map) {
    return TempData(
      id: map['id'] ,
      tempValue: map['tempValue'] as double,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }
}
