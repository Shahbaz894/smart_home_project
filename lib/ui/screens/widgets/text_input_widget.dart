import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class TextInputWidget extends StatefulWidget {
  const TextInputWidget({super.key});

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  TextEditingController textMessageController=TextEditingController();
  TextEditingController intValueController=TextEditingController();
  final DatabaseReference _messageReference =
  FirebaseDatabase.instance.reference().child('message');
  final DatabaseReference _numberReference =
  FirebaseDatabase.instance.reference().child('number');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,

      ),
        // backgroundColor:Colors.green,
        //   title: Center(child: const Text('Send Text To Firebase',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)),),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/kids_bedroom.jpg'),
            fit: BoxFit.cover, // Adjust fit as needed
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 70,
                width: MediaQuery.of(context).size.width ,
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Subtle background color
                  borderRadius: BorderRadius.circular(30), // More rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: textMessageController,
                  decoration: InputDecoration(
                    hintText: 'Enter your message', // Placeholder text
                    prefixIcon: const Icon(Icons.message), // Relevant icon
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none, // Remove default border
                      borderRadius: BorderRadius.circular(30), // Match container's corners
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 2), // Focus indicator
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),

              ),
              SizedBox(height: 20,),

              Container(
                height: 70,
                width: MediaQuery.of(context).size.width ,
                decoration: BoxDecoration(
                  color: Colors.grey[200], // Subtle background color
                  borderRadius: BorderRadius.circular(30), // More rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: intValueController,
                  decoration: InputDecoration(
                    hintText: 'Enter your number', // Placeholder text
                    prefixIcon: Icon(Icons.abc), // Relevant icon
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none, // Remove default border
                      borderRadius: BorderRadius.circular(30), // Match container's corners
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2), // Focus indicator
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 90,),

              Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: const LinearGradient(
                    colors: [Colors.deepPurple, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(0, 5),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    sendMessageAndNumber();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    primary: Colors.transparent, // Remove default background
                    elevation: 0, // Remove default shadow
                  ),
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );

  }


  // void sendMessageAndNumber() {
  //   final message = textMessageController.text;
  //   final number = intValueController.text;
  //
  //   _messageReference.push().set({
  //     'content': message,
  //     'timestamp': DateTime.now().toString(),
  //   });
  //
  //   _numberReference.push().set({
  //     'number': number,
  //     'timestamp': DateTime.now().toString(), // Optional if needed for numbers
  //   });
  //
  //   // Clear text fields after sending
  //   textMessageController.clear();
  //   intValueController.clear();
  // }
// ... other code ...

  void sendMessageAndNumber() async {
    try {
      final message = textMessageController.text;
      final number = intValueController.text;

      if (message.isNotEmpty) {
        await _messageReference.push().set({
          'content': message,
          'timestamp': DateTime.now().toString(),
        });
      }

      if (number.isNotEmpty) {
        await _numberReference.push().set({
          'number': number,
          'timestamp': DateTime.now().toString(), // Optional for numbers
        });
      }

      // Clear all text fields after sending (optional)
      textMessageController.clear();
      intValueController.clear();

      // ... success/error handling ...
    } catch (error) {
      const SnackBar(content: Text('No Data Is send'),);
    }
  }

}
