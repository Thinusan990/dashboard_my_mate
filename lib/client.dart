import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClientPage extends StatefulWidget {
  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clients List"),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('clients').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final clients = snapshot.data?.docs ?? [];

          if (clients.isEmpty) {
            return Center(child: Text("No clients found."));
          }

          return ListView.builder(
            itemCount: clients.length,
            itemBuilder: (context, index) {
              final client = clients[index];

              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  title: Text(client['full_name'] ?? 'No Name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone: ${client['mobile'] ?? 'No Phone'}'),
                      Text('Age: ${client['age'] ?? 'No Age'}'),
                      Text('Caste: ${client['caste'] ?? 'No Caste'}'),
                      Text('Civil Status: ${client['civil_status'] ?? 'No Status'}'),
                      Text('Country: ${client['country'] ?? 'No Country'}'),
                      Text('District: ${client['district'] ?? 'No District'}'),
                      Text('DOB: ${client['dob'] ?? 'No DOB'}'),
                      Text('Education: ${client['education'] ?? 'No Education'}'),
                      Text('Employment Type: ${client['employment_type'] ?? 'No Employment Type'}'),
                      Text('Height: ${client['height'] ?? 'No Height'}'),
                      Text('Language: ${client['language'] ?? 'No Language'}'),
                      Text('No. of Siblings: ${client['no_of_siblings'] ?? 'No Siblings'}'),
                      Text('Occupation: ${client['occupation'] ?? 'No Occupation'}'),
                      Text('Religion: ${client['religion'] ?? 'No Religion'}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
