import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch all users from the `clients` collection
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('clients').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return {
          'id': doc.id,
          'full_name': data['full_name'] ?? 'N/A',
          'user_type': data['user type'] ?? 'N/A',
          'rank_no': data['Rank no']?.toString() ?? 'N/A',
          'rank_type': data['Rank type'] ?? 'N/A',
          'active': data['Active'] ?? false,

        };
      }).toList();
    } catch (e) {
      print('Error fetching users: $e');
      return [];
    }
  }

  /// Add a new user to the `clients` collection
  Future<void> addUser(Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('clients').add(userData);
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  /// Update a user's data by ID
  Future<void> updateUser(String userId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('clients').doc(userId).update(updatedData);
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  /// Delete a user by ID
  Future<void> deleteUser(String userId) async {
    try {
      await _firestore.collection('clients').doc(userId).delete();
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  /// Fetch counts for active, inactive, subscribed, and unsubscribed users
  Future<Map<String, int>> fetchCounts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('clients').get();
      final users = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

      int activeCount = users.where((user) => user['Active'] == true).length;
      int inactiveCount = users.where((user) => user['Active'] == false).length;
      int subscribedCount = users
          .where((user) =>
      user['user type'] == 'premium' ||
          user['user type'] == 'basic' ||
          user['user type'] == 'standard')
          .length;
      int unsubscribedCount = users.length - subscribedCount;

      return {
        'active': activeCount,
        'inactive': inactiveCount,
        'subscribed': subscribedCount,
        'unsubscribed': unsubscribedCount,
      };
    } catch (e) {
      print('Error fetching counts: $e');
      return {};
    }
  }


Future<Map<String, dynamic>> fetchUserById(String userId) async {
  try {
    DocumentSnapshot doc = await _firestore.collection('clients').doc(userId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      return {
        'id': doc.id,
        'full_name': data['full_name'] ?? 'N/A',
        'age': data['age'] ?? 'N/A',
        'date_of_birth': data['dob'] ?? 'N/A',
        'occupation': data['occupation'] ?? 'N/A',
        'address': data['address'] ?? 'N/A',
        'education': data['education'] ?? 'N/A',
        'height': data['height'] ?? 'N/A',
        'religion': data['religion'] ?? 'N/A',
        'caste': data['caste'] ?? 'N/A',
        'mothers_name': data['mothers_name'] ?? 'N/A',
        'contact': data['contact'] ?? 'N/A',
        'no_of_siblings': data['no_of_siblings'] ?? 0,
      };
    } else {
      return {};
    }
  } catch (e) {
    print('Error fetching user by ID: $e');
    return {};
  }
}
}