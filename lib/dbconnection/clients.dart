import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<dynamic>? clientData;

  @override
  void initState() {
    super.initState();
    fetchClientData();
  }

  Future<void> fetchClientData() async {
    final url = Uri.parse('https://backend.graycorp.io:9000/mymate/api/v1/getClientDataList');
    try {
      final response = await http.get(url);

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data is List) {
          setState(() {
            clientData = data; // Assign the array directly to clientData
          });
        } else {
          throw Exception('Expected a JSON array but got: ${data.runtimeType}');
        }
      } else {
        throw Exception('Failed to load client data');
      }
    } catch (error) {
      print('Error fetching client data: $error');
      setState(() {
        clientData = []; // Set as an empty list to avoid null errors
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Client Data')),
      body: clientData == null
          ? const Center(child: CircularProgressIndicator())
          : clientData!.isEmpty
          ? const Center(child: Text('No data available'))
          : ListView.builder(
        itemCount: clientData!.length,
        itemBuilder: (context, index) {
          final client = clientData![index];

          // Handle null safety
          final fullName = client['personalDetails']?['full_name'] ;
          final mobile = client['contactInfo']?['mobile'] ?? 'N/A';
          final email = client['contactInfo']?['email'] ?? 'N/A';
          final occupation = client['career_studies']?['occupation'] ?? 'N/A';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Full Name: $fullName'),
                  Text('Mobile: $mobile'),
                  Text('Email: $email'),
                  Text('Occupation: $occupation'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



// Text('Full Name: ${userProfile?['personalDetails']['full_name'] ?? 'N/A'}'),
// Text('Mobile: ${userProfile?['contactInfo']['mobile'] ?? 'N/A'}'),
// Text('Email: ${userProfile?['contactInfo']['email'] ?? 'N/A'}'),
// Text('Occupation: ${userProfile?['career_studies']['occupation'] ?? 'N/A'}'),