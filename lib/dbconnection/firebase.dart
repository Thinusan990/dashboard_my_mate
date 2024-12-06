import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch all users from the `clients` collection
  // Future<List<Map<String, dynamic>>> fetchUsers() async {
  //   try {
  //     QuerySnapshot snapshot = await _firestore.collection('client').get();
  //     return snapshot.docs.map((doc) {
  //       final data = doc.data() as Map<String, dynamic>;
  //       final personalDetails = data['personalDetails'] ?? {};
  //
  //       return {
  //         'id': doc.id,
  //         'full_name': personalDetails['full_name'] ?? 'N/A',
  //         'user_type': personalDetails['user_type'] ?? 'N/A',
  //         'rank_no': personalDetails['rank_no']?.toString() ?? 'N/A',
  //         'rank_type': personalDetails['rank_type'] ?? 'N/A',
  //         'active': data['Active'] ?? false,
  //
  //       };
  //     }).toList();
  //   } catch (e) {
  //     print('Error fetching users: $e');
  //     return [];
  //   }
  // }

  /// Add a new user to the `clients` collection
  Future<void> addUser(Map<String, dynamic> userData) async {
    try {
      await _firestore.collection('client').add(userData);
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  /// Update a user's data by ID
  Future<void> updateUser(
      String userId, Map<String, dynamic> updatedData) async {
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
      final users = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      int activeCount = 0;
      int inactiveCount = 0;
      int subscribedCount = 0;

      for (var user in users) {
        final userType = user['user_type'] ?? {};
        final status = userType['status'] ?? '';
        final type = userType['user_type'] ?? '';

        // Count active and inactive users
        if (status == 'Active') {
          activeCount++;
        } else if (status == 'Inactive') {
          inactiveCount++;
        }

        // Count subscribed users
        if (type == 'Premium' || type == 'Basic' || type == 'Standard') {
          subscribedCount++;
        }
      }

      // Calculate unsubscribed count
      int unsubscribedCount = users.length - subscribedCount;

      // Return the results
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
      DocumentSnapshot doc =
          await _firestore.collection('client').doc(userId).get();
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        final personalDetails = data['personalDetails'] ?? {};

        final career_studies = data['career_studies'] ?? {};
        final contactinfo = data['contactInfo'] ?? {};

        final countryCode = contactinfo['mobile_country_code'] ??
            ''; // Default to empty string if no country code
        final mobileNumber = contactinfo['mobile'] ??
            ''; // Default to empty string if no mobile number
        final address = contactinfo['address'] ?? '';
        final house_number = address['house_number'] ?? '';
        final home = address['home'] ?? '';
        final lane = address['lane'] ?? '';
        final city = address['city'] ?? '';
        final country = address['country'] ?? '';
        final lifestyle = data['lifestyle'] ?? {};
        final profileImages = data['profileImages'] ?? {};

        final imageGallery =
            profileImages['images']?['gallery_image_urls'] ?? [];
        final userImages = (imageGallery as List).take(3).toList();

        // Format the contact number as "country code + mobile number"
        final formattedContact =
            countryCode.isNotEmpty && mobileNumber.isNotEmpty
                ? '$countryCode$mobileNumber'
                : 'N/A'; // If either is missing, return 'N/A'

        final formattedAddress = house_number.isNotEmpty &&
                home.isNotEmpty &&
                lane.isNotEmpty &&
                city.isNotEmpty
            ? '$house_number, $home,$lane,$city,$country.'
            : 'N/A';

        return {
          'id': doc.id,
          'full_name': personalDetails['full_name'] ?? 'N/A',
          'age': personalDetails['age'] ?? 'N/A',
          'date_of_birth': data['dob'] ?? 'N/A',
          'occupation': career_studies['occupation'] ?? 'N/A',
          'address': formattedAddress,
          'education': career_studies['higher_studies'] ?? 'N/A',
          'height': personalDetails['height'] ?? 'N/A',
          'religion': personalDetails['religion'] ?? 'N/A',
          'caste': personalDetails['caste'] ?? 'N/A',
          'mothers_name': data['mothers_name'] ?? 'N/A',
          'contact': formattedContact, // Use the formatted contact number
          'no_of_siblings': data['no_of_siblings'] ?? 0,
          'hobbies': lifestyle['hobbies'] ?? 'N/A',
          'Favorites': lifestyle['personal_interest'] ?? 'N/A',
          'Alcohol': lifestyle['habbits'] ?? 'N/A',
          'sports': data['sports'] ?? 'N/A',
          'cooking': data['cooking'] ?? 'N/A',
          'Bio': personalDetails['bio'] ?? 'N/A',
          'images': userImages,
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
