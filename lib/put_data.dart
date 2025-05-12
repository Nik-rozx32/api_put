import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PutData extends StatefulWidget {
  const PutData({Key? key}) : super(key: key);

  @override
  State<PutData> createState() => _PutDataState();
}

class _PutDataState extends State<PutData> {
  String responseMessage = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> putData() async {
    final url = Uri.parse('https://eo2nzlcrlpp5fp7.m.pipedream.net');
    final String name = nameController.text.trim();
    final String email = emailController.text.trim();

    final response = await http.put(url,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email}));

    if (response.statusCode == 200) {
      setState(() {
        responseMessage = 'Data updated successfully';
      });
    } else {
      setState(() {
        responseMessage = 'Failed to update. Status: ${response.statusCode}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Put data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Enter Name'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  labelText: 'Enter Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white),
                  onPressed: putData,
                  child: Text('Update Data')),
            ),
            SizedBox(
              height: 20,
            ),
            Text(responseMessage)
          ],
        ),
      ),
    );
  }
}
