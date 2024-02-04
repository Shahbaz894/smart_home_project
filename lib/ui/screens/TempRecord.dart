// views/temperature_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/temp_bloc/temp_bloc.dart';
import '../../bloc/temp_bloc/temp_event.dart';
import '../../bloc/temp_bloc/temp_state.dart';
import 'package:intl/intl.dart';

class TemperatureView extends StatefulWidget {
  const TemperatureView({super.key});

  @override
  State<TemperatureView> createState() => _TemperatureViewState();
}

class _TemperatureViewState extends State<TemperatureView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Center(child: Text('Temperature'),

      ),
        backgroundColor: Colors.green,

      ),
      body: BlocBuilder<TempBloc, TempState>(
        builder: (context, state) {
          if (state is TempLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TempLoaded) {
            return ListView.builder(
              itemCount: state.tempDataList.length,
              itemBuilder: (context, index) {
                final tempData = state.tempDataList[index];
                return
                  Container(
                    child: Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      child: ListTile(
                        title: Text(
                          '${tempData.tempValue.toString()} °C',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Recorded on ${DateFormat.yMMMd().add_jm().format(tempData.timestamp)}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<TempBloc>().add(DeleteTempEvent(id: tempData.id));
                                                    },

                        ),
                      ),
                    ),
                  );


              },
            );
          } else if (state is TempError) {
            return Center(child: Text(state.errorMessage));
          } else {
            return Container(); // Handle unexpected states
          }
        },
      ),
    );
  }
}
