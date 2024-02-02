// ignore_for_file: avoid_positional_boolean_parameters

import 'package:flutter/material.dart';
import 'package:flutter_form_wizard/flutter_form.dart';
import 'package:flutter_image_picker/flutter_image_picker.dart';
import 'package:flutter_stepper/stepper.dart';
import 'package:flutter_user/src/models/onboarding_configuration.dart';
import 'package:flutter_user/src/widgets/access_page.dart';
import 'package:flutter_user/src/widgets/completion_page.dart';
import 'package:flutter_user/src/widgets/image_picker_input.dart';
import 'package:flutter_user/src/widgets/personal_info_page.dart';
import 'package:flutter_user/src/widgets/photo_page.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({
    required this.onboardingFinished,
    required this.onboardingOnNext,
    required this.configuration,
    required this.stepperTheme,
    required this.imagePickerConfig,
    this.personalInputs,
    this.accessInputs,
    this.nextButton,
    this.backButton,
    super.key,
  });
  final Function(Map<int, Map<String, dynamic>> results) onboardingFinished;
  final Function(int pageNumber, Map<String, dynamic> results) onboardingOnNext;
  final OnboardingConfiguration configuration;
  final StepperTheme stepperTheme;
  final ImagePickerConfig imagePickerConfig;
  final List<Widget>? personalInputs;
  final List<Widget>? accessInputs;
  final Widget Function(int, FlutterFormController, bool)? nextButton;
  final Widget Function(int, bool, int, FlutterFormController)? backButton;

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  var formController = FlutterFormController();
  var personAbout = FlutterFormInputPlainTextController(id: 'about');

  @override
  Widget build(BuildContext context) {
    var imageController = FlutterFormInputImageController(id: 'image');
    var accessPageControllers = <String, FlutterFormInputController<bool>>{
      'firstName': FlutterFormInputSwitchController(
        id: 'visible_first_name',
        value: true,
      ),
      'lastName': FlutterFormInputSwitchController(
        id: 'visible_last_name',
        value: true,
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
                  padding: const EdgeInsets.only(left: 20, right: 14),
                  child: PersonInfoPage(
                    inputController: personAbout,
                    title: widget.configuration.personalInfoTitle,
                    description: widget.configuration.personalInfoDescription,
                    textfieldHint:
                        widget.configuration.personalInfoTextfieldHint,
                    stepperTheme: widget.stepperTheme,
                    inputs: widget.personalInputs,
                  ),
                ),
              ),
              FlutterFormPage(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 14),
                  child: PhotoPage(
                    imageController: imageController,
                    title: widget.configuration.photoTitle,
                    description: widget.configuration.photoDescription,
                    stepperTheme: widget.stepperTheme,
                    imagePickerConfig: widget.imagePickerConfig,
                  ),
                ),
              ),
              FlutterFormPage(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 14),
                  child: AccessPage(
                    inputControllers: accessPageControllers,
                    title: widget.configuration.accessPageTitle,
                    description: widget.configuration.accessPageDescription,
                    stepperTheme: widget.stepperTheme,
                    inputs: widget.accessInputs,
                  ),
                ),
              ),
              FlutterFormPage(
                child: CompletionPage(
                  title: widget.configuration.completionTitle,
                  description: widget.configuration.completionDescription,
                  stepperTheme: widget.stepperTheme,
                ),
              ),
            ],
            backButton: (pageNumber, checkingPages, pageAmount) =>
                widget.backButton != null
                    ? widget.backButton!.call(
                        pageNumber,
                        checkingPages,
                        pageAmount,
                        formController,
                      )
                    : const SizedBox.shrink(),
            nextButton: (pageNumber, checkingPages) => widget.nextButton != null
                ? widget.nextButton!.call(
                    pageNumber,
                    formController,
                    checkingPages,
                  )
                : Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
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
                        'Next',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
