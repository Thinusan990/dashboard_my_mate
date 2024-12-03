import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch all users from the `clients` collection
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('client').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final personalDetails = data['personalDetails'] ?? {};

        return {
          'id': doc.id,
          'full_name': personalDetails['full_name'] ?? 'N/A',
          'user_type': personalDetails['user_type'] ?? 'N/A',
          'rank_no': personalDetails['rank_no']?.toString() ?? 'N/A',
          'rank_type': personalDetails['rank_type'] ?? 'N/A',
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
      await _firestore.collection('client').add(userData);
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
      await _firestore.collection('client').doc(userId).delete();
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  /// Fetch counts for active, inactive, subscribed, and unsubscribed users
  Future<Map<String, int>> fetchCounts() async {
    try {
      // Fetch documents from the 'client' collection
      QuerySnapshot snapshot = await _firestore.collection('client').get();

      // Extract and process data from the documents
      final users = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

      // Count users based on their 'status' inside 'user_type'
      int activeCount = users.where((user) {
        final userType = user['user_type'] ?? {};  // Access 'user_type' map
        return userType['status'] == 'Active';  // Check if 'status' is Active
      }).length;

      int inactiveCount = users.where((user) {
        final userType = user['user_type'] ?? {};  // Access 'user_type' map
        return userType['status'] == 'Inactive';  // Check if 'status' is Inactive
      }).length;

      // Count users based on 'user_type' for subscribed and unsubscribed
      int subscribedCount = users.where((user) {
        final userType = user['user_type'] ?? {};  // Access 'user_type' map
        final type = userType['user_type'] ?? '';  // Get the specific user type ('Premium', etc.)
        return type == 'Premium' || type == 'Basic' || type == 'Standard';  // Check if user is subscribed
      }).length;

      int unsubscribedCount = users.length - subscribedCount;  // The rest are unsubscribed

      // Return the computed counts
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
    DocumentSnapshot doc = await _firestore.collection('client').doc(userId).get();
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
        'hobbies' : data['hobbies'] ?? 'N/A',
        'Favorites' : data['favorites'] ?? 'N/A',
        'Alcohol' : data['alcohol'] ?? 'N/A',
        'sports' : data['sports'] ?? 'N/A',
        'cooking' :data['cooking'] ?? 'N/A',
        'Bio' : data['bio'] ?? 'N/A'
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