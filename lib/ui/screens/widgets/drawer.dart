import 'package:flutter/material.dart';
import 'package:smart_home_project/ui/screens/TempRecord.dart';
import 'package:smart_home_project/ui/screens/widgets/text_input_widget.dart';


import '../../auth_screen/login_screen.dart';
import '../../chartsa/bme_sensor_chart.dart';
import '../../chartsa/line_chart.dart';
import '../automation_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  // You can add your user profile image here
                  // backgroundImage: NetworkImage('https://example.com/your_image.jpg'),
                ),
                SizedBox(height: 10),
                Text(
                  'Shahbaz Zulfiqar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                // Text(
                //   'Shahbaz@gmail.com',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 12,
                //   ),
                // ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              // Navigate to the home screen
              Navigator.pop(context); // Close the drawer
              // Add your navigation logic here
            },
          ),

          ListTile(
            leading: Icon(Icons.stacked_line_chart),
            title: const Text('Line Charts'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LineChart()));
            },
          ),
          ListTile(
            leading: Icon(Icons.stacked_line_chart),
            title: const Text('Message'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> TextInputWidget()));
            },

          ),
          ListTile(
            leading: Icon(Icons.stacked_line_chart),
            title: const Text('BME Sensor'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const BmeSensorChart()));
            },

          ),
          ListTile(
            leading: Icon(Icons.auto_awesome_motion),
            title: const Text('Automation'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  AutomationScreen()));
            },


          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('TempRecord'),
            onTap: () {
              // Navigate to the settings screen
              Navigator.pop(context); // Close the drawer
              // Add your navigation logic here
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TemperatureView()));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Implement your logout logic
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));// Close the drawer
              // Add your logout logic here
            },
          ),
        ],
      ),
    );
  }
}
