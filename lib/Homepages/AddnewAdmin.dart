import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:io';

import '../MymateThemes.dart';
import '../widgets/sidebar_layout.dart';

class AddnewadminPage extends StatefulWidget {
  @override
  _AddnewadminPageState createState() => _AddnewadminPageState();
}

class _AddnewadminPageState extends State<AddnewadminPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedOperatorType = 'Admin';
  File? _imageFile;

  void _chooseImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        compressQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000,
        compressFormat: ImageCompressFormat.jpg,
      );

      if (croppedFile != null) {
        setState(() {
          _imageFile = File(croppedFile.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth > 800;
    final sidebarWidth = isWideScreen ? 250.0 : screenWidth * 0.3;

    // Adjust container width responsively with a max width constraint.
    double formWidth = screenWidth * 0.9;
    if (formWidth > 600) formWidth = 600;

    return Scaffold(
      backgroundColor: Mymatethemes.backgroundColor,
      body: Row(
        children: [
          Container(
            width: sidebarWidth,
            color: Colors.grey.shade200,
            child: SidebarLayout(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Divider placed outside of the form container
                  Text(
                    "Operators",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(thickness: 1),
                  SizedBox(height: 10),
                  // Centered Form Container
                  Center(
                    child: Container(
                      width: formWidth,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Photo Upload Section
                            Center(
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      _imageFile != null
                                          ? CircleAvatar(
                                        radius: 40,
                                        backgroundImage: FileImage(_imageFile!),
                                      )
                                          : SvgPicture.asset(
                                        'images/circle.svg',
                                        height: 70,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: () => _chooseImage(ImageSource.gallery),
                                    child: SvgPicture.asset('images/choose.svg',height: 50,),

                                  ),
                                  SizedBox(height: 5),
                                  SvgPicture.asset('images/orr.svg'),
                                  SizedBox(height: 5),
                                  GestureDetector(
                                    onTap: () => _chooseImage(ImageSource.camera),
                                    child: SvgPicture.asset('images/take.svg',height: 50,),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            // Row based form fields
                            _buildRowFormField("Name", "26 years"),
                            SizedBox(height: 10),
                            _buildRowFormField("Operation ID", "@123HJK"),
                            SizedBox(height: 10),
                            _buildRowPasswordField("Password", "@*k8oidLK"),
                            SizedBox(height: 10),
                            _buildRowDropdownField(),
                            SizedBox(height: 10),
                            _buildRowFormField("Address", "Jaffna"),
                            SizedBox(height: 10),
                            _buildRowFormField("Contact Number", "0761692028"),
                            SizedBox(height: 10),
                            // Aligned Create Button at the end of the container/row
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Mymatethemes.tabclr,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "Create",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper method to build a row-based form field.
  Widget _buildRowFormField(String label, String hint) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }

  /// Helper method to build a row-based password field.
  Widget _buildRowPasswordField(String label, String hint) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              suffixIcon: Icon(Icons.remove_red_eye),
            ),
          ),
        ),
      ],
    );
  }

  /// Helper method to build a row-based dropdown field.
  Widget _buildRowDropdownField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 100,
          child: Text(
            "Operator Type",
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _selectedOperatorType,
            items: ['Admin', 'Super Admin', 'Manager']
                .map((type) => DropdownMenuItem(
              value: type,
              child: Text(type),
            ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedOperatorType = value;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            ),
          ),
        ),
      ],
    );
  }
}
