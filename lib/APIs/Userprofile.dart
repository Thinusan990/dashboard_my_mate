
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map<String, dynamic>>> fetchUserProfile() async {
  final url = Uri.parse('https://backend.graycorp.io:9000/mymate/api/v1/getClientDataList');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((user) {
        return {
          'id': user['id'] ?? 'N/A',
          'full_name': user['personalDetails']?['full_name'] ?? 'N/A',
          'user_type': user['userInfo']?['user_type'] ?? 'N/A',
          'rank_no': user['Rank no']?.toString() ?? 'N/A',
          'rank_type': user['Rank type'] ?? 'N/A',
          'active': user['userInfo']?['status'] ?? 'Inactive',
        };
      }).toList();
    } else {
      throw Exception('Failed to load user profile');
    }
  } catch (error) {
    print('Error fetching user profile: $error');
    return [];
  }
}


Future<Map<String, dynamic>> fetchUserById(String docId) async {
  final String apiUrl = 'http://192.168.1.6:9000/mymate/api/v1/getClientDataByDocId';

  try {
    if (docId.isEmpty) {
      print('Error: userId is empty');
      return {};
    }
    final Uri url = Uri.parse('$apiUrl?docId=$docId');


    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final personalDetails = data['personalDetails'] ?? {};
      final careerStudies = data['careerStudies'] ?? {};
      final contactInfo = data['contactInfo'] ?? {};
      final astrology = data['astrology'] ?? {};
      final countryCode = contactInfo['mobile_country_code'] ?? '';
        final mobileNumber = contactInfo['mobile'] ?? '';
      final address = contactInfo['address'] ?? {};
      final houseNumber = address['house_number'] ?? '';
      final home = address['home'] ?? '';
      final lane = address['lane'] ?? '';
      final city = address['city'] ?? '';
      final country = address['country'] ?? '';
      final lifestyle = data['lifestyle'] ?? {};
      final profileImages = data['profileImages'] ?? {};

      // final imageGallery =
      //     profileImages['profile_pic_url'] ?? [];
      // final userImages = (imageGallery as List).take(3).toList();

      final imageGalleryRaw = profileImages['gallery_image_urls'];
      List<dynamic>  imageGallery;
      if(imageGalleryRaw is String) {
        imageGallery = [imageGalleryRaw];
      } else if (imageGalleryRaw is List) {
        imageGallery = imageGalleryRaw;
      }else {
        imageGallery= [];
      }
      final userImages = imageGallery.take(3).toList();

      final formattedContact = countryCode.isNotEmpty && mobileNumber.isNotEmpty
          ? '$countryCode$mobileNumber'
          : 'N/A';

      final formattedAddress = houseNumber.isNotEmpty &&
          home.isNotEmpty &&
          lane.isNotEmpty &&
          city.isNotEmpty
          ? '$houseNumber, $home, $lane, $city, $country.'
          : 'N/A';

      return {
        'id': docId,

        'full_name': personalDetails['full_name'] ?? 'N/A',
        'age': personalDetails['age'] ?? 'N/A',
        'date_of_birth': astrology['dob'] ?? 'N/A',
        'occupation': careerStudies['occupation'] ?? 'N/A',
        'address': formattedAddress,
        'education': careerStudies['higher_studies'] ?? 'N/A',
        'height': personalDetails['height'] ?? 'N/A',
        'religion': personalDetails['religion'] ?? 'N/A',
        'caste': personalDetails['caste'] ?? 'N/A',
        'mothers_name': data['mothers_name'] ?? 'N/A',
        'contact': mobileNumber,
        'no_of_siblings': data['no_of_siblings'] ?? 0,
        'hobbies': lifestyle['hobbies'] ?? 'N/A',
        'favorites': lifestyle['personal_interest'] ?? 'N/A',
        'alcohol': lifestyle['alcoholIntake'] ?? 'N/A',
        'sports': data['sports'] ?? 'N/A',
        'cooking': lifestyle['cooking'] ?? 'N/A',
        'bio': personalDetails['bio'] ?? 'N/A',
        'images': userImages,
        'expectation' :lifestyle['expectations'] ?? 'N/A',

      };
    } else {
      print('Failed to fetch user details. Status code: ${response.statusCode}');
      return {};
    }
  } catch (e) {
    print('Error fetching user by ID: $e');
    return {};
  }
}