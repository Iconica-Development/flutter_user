import 'package:flutter/material.dart';
import 'package:flutter_form_wizard/flutter_form.dart';
import 'package:flutter_stepper/stepper.dart';

class PersonInfoPage extends StatelessWidget {
  const PersonInfoPage({
    required this.inputController,
    required this.title,
    required this.description,
    required this.textfieldHint,
    required this.stepperTheme,
    this.inputs,
    super.key,
  });

  final FlutterFormInputPlainTextController inputController;
  final String title;
  final String description;
  final String textfieldHint;
  final StepperTheme stepperTheme;
  final List<Widget>? inputs;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    var currentStep = 0;

    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
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
                        SizedBox(
                          width: size.width * 0.7,
                          child: Text(
                            description,
                            style: theme.textTheme.bodyMedium!.copyWith(),
                            softWrap: true,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (inputs == null) ...[
                          Expanded(
                            child: FlutterFormInputPlainText(
                              textAlignVertical: TextAlignVertical.top,
                              expands: true,
                              maxLines: null,
                              controller: inputController,
                              decoration: const InputDecoration(
                                hintText: 'Iets over je zelf...',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF979797)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xFF979797)),
                                ),
                                filled: true,
                              ),
                            ),
                          ),
                        ] else ...[
                          ...inputs!,
                        ],
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                MultiViewStep(
                  hidden: true,
                  content: Container(),
                ),
                MultiViewStep(
                  hidden: true,
                  content: Container(),
                ),
                MultiViewStep(
                  hidden: true,
                  content: Container(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size.height * 0.1,
          ),
        ],
      ),
    );
  }
}
