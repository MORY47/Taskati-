import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati_ui/core/constants/app_images.dart';
import 'package:taskati_ui/core/functions/dialouge.dart';
import 'package:taskati_ui/core/functions/navigation.dart';
import 'package:taskati_ui/core/services/local_helper.dart';
import 'package:taskati_ui/core/utils/colors.dart';
import 'package:taskati_ui/core/widgets/custom_text_field.dart';
import 'package:taskati_ui/core/widgets/main_button.dart';
import 'package:taskati_ui/features/home/page/home_screen.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  String imagePath = '';
  var nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (imagePath.isNotEmpty && nameController.text.isNotEmpty) {
                // save data to hive
                LocalHelper.putUserData(nameController.text, imagePath);
                // push to home sceen
                pushWithReplacement(context, const HomeScreen());
              } else if (imagePath.isNotEmpty && nameController.text.isEmpty) {
                showErrorDialog(context, 'Please Enter Your Name');
              } else if (imagePath.isEmpty && nameController.text.isNotEmpty) {
                showErrorDialog(context, 'Please Upload an Image');
              } else {
                showErrorDialog(
                  context,
                  'Please Enter Your Name and Upload an Image ',
                );
              }
            },
            child: Text('Done'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: AppColors.primaryColor,
                  backgroundImage: imagePath.isNotEmpty
                      ? FileImage(File(imagePath))
                      : AssetImage(AppImages.emptyUser),
                ),
                Gap(30),
                MainButton(
                  width: 300,
                  onPressed: () async {
                    await uploadImage(isCamera: true);
                  },
                  text: 'Upload From Camera',
                ),
                Gap(10),
                MainButton(
                  width: 300,
                  onPressed: () async {
                    await uploadImage(isCamera: false);
                  },
                  text: 'Upload From Gallery',
                ),
                Gap(20),
                Divider(thickness: 2),
                Gap(15),
                CustomTextField(
                  hint: 'Enter your name',
                  controller: nameController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage({required bool isCamera}) async {
    XFile? file = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (file != null) {
      setState(() {
        imagePath = file.path;
      });
    }
  }
}