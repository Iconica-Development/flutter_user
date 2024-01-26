import 'package:flutter/material.dart';
import 'package:flutter_form_wizard/flutter_form.dart';
import 'package:flutter_stepper/stepper.dart';

class AccessPage extends StatelessWidget {
  const AccessPage({
    required this.inputControllers,
    required this.title,
    required this.description,
    required this.stepperTheme,
    this.inputs,
    super.key,
  });

  final Map<String, FlutterFormInputController<bool>> inputControllers;
  final String title;
  final String description;
  final StepperTheme stepperTheme;
  final List<Widget>? inputs;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var currentStep = 2;
    return Column(
      children: [
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
                hidden: true,
                content: Container(),
              ),
              MultiViewStep(
                content: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        description,
                        style: theme.textTheme.bodyMedium!.copyWith(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (inputs == null) ...[
                        SizedBox(
                          width: size.width * 0.7,
                          child: Row(
                            children: [
                              const Text('Voornaam'),
                              const Spacer(),
                              FlutterFormInputSwitch(
                                controller: inputControllers['firstName']!,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.7,
                          child: Row(
                            children: [
                              const Text('Achternaam'),
                              const Spacer(),
                              FlutterFormInputSwitch(
                                controller: inputControllers['lastName']!,
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        ...inputs!,
                      ],
                      const Spacer(
                        flex: 2,
                      ),
                    ],
                  ),
                ),
              ),
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
