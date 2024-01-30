import 'package:flutter/material.dart';
import 'package:flutter_user/src/widgets/image_picker_input.dart';
import 'package:flutter_image_picker/flutter_image_picker.dart';
import 'package:flutter_stepper/stepper.dart';

class PhotoPage extends StatelessWidget {
  const PhotoPage({
    required this.imageController,
    required this.title,
    required this.description,
    required this.stepperTheme,
    required this.imagePickerConfig,
    super.key,
  });

  final FlutterFormInputImageController imageController;
  final String title;
  final String description;
  final StepperTheme stepperTheme;
  final ImagePickerConfig imagePickerConfig;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    var currentStep = 1;

    return Column(
      children: [
        const SizedBox(height: 35),
        Expanded(
          child: MultiStepperView(
            showOnlyCurrentStep: true,
            paddingRight: 10,
            theme: stepperTheme,
            showAllSteps: true,
            currentStep: currentStep,
            zeroIndexed: false,
            steps: [
              MultiViewStep(
                hidden: true,
                content: Container(),
              ),
              MultiViewStep(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        title,
                        style: theme.textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        description,
                        style: theme.textTheme.bodyMedium!.copyWith(),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: size.width * 0.75,
                      child: Center(
                        child: SizedBox(
                          height: 94,
                          width: 94,
                          child: FlutterFormInputImage(
                            firstName: 'mike',
                            lastName: 'van der velden',
                            controller: imageController,
                            imagePickerConfig: imagePickerConfig,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
              MultiViewStep(hidden: true, content: Container()),
              MultiViewStep(hidden: true, content: Container()),
            ],
          ),
        ),
        SizedBox(
          height: size.height * 0.1,
        ),
      ],
    );
  }
}
