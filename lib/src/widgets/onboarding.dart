// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter_user/flutter_user.dart';
import 'package:flutter_user/src/default_configs/image_picker_configuration.dart';
import 'package:flutter_user/src/widgets/image_picker_input.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({
    required this.onboardingFinished,
    required this.onboardingOnNext,
    super.key,
  });
  final Function(Map<int, Map<String, dynamic>> results) onboardingFinished;
  final Function(int pageNumber, Map<String, dynamic> results) onboardingOnNext;

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  var formController = FlutterFormController();
  var personAbout = FlutterFormInputPlainTextController(id: 'about');

  @override
  Widget build(BuildContext context) {
    var imageController =
        FlutterFormInputImageController(id: 'image', mandatory: false);
    var personalInfoControllers = <String, FlutterFormInputController<String>>{
      'firstName': FlutterFormInputPlainTextController(
        id: 'visible_first_name',
        mandatory: true,
      ),
      'bio': FlutterFormInputPlainTextController(
        id: 'bio',
        mandatory: true,
      ),
    };

    return Scaffold(
      body: SafeArea(
        child: FlutterForm(
          formController: formController,
          options: FlutterFormOptions(
            scrollDirection: Axis.vertical,
            onFinished: (results) {
              widget.onboardingFinished.call(results);
            },
            onNext: (pageNumber, results) async {
              widget.onboardingOnNext.call(pageNumber, results);
            },
            pages: [
              FlutterFormPage(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 160,
                      ),
                      const Text(
                        'create your profile',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 24,
                          color: Color(0xff71C6D1),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FlutterFormInputImage(
                        firstName: 'mike',
                        lastName: 'van der velden',
                        controller: imageController,
                        imagePickerConfig: getImagePickerConfig(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      FlutterFormInputPlainText(
                        controller: personalInfoControllers['firstName']!,
                        decoration: const InputDecoration(
                          hintText: 'First name',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 200,
                        child: FlutterFormInputPlainText(
                          controller: personalInfoControllers['bio']!,
                          expands: true,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                            hintText: 'Bio',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            nextButton: (pageNumber, checkingPages) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(260, 0),
                    backgroundColor: const Color(0xff71C6D1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    await formController.autoNextStep();
                  },
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
