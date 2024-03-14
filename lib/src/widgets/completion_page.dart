import 'package:flutter/material.dart';
import 'package:flutter_stepper/stepper.dart';

class CompletionPage extends StatelessWidget {
  const CompletionPage({
    required this.title,
    required this.description,
    required this.stepperTheme,
    super.key,
  });

  final String title;
  final String description;
  final StepperTheme stepperTheme;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var currentStep = 3;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 14,
          ),
          child: Column(
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
                      hidden: true,
                      content: Container(),
                    ),
                    MultiViewStep(
                      hidden: true,
                      content: Container(),
                    ),
                    MultiViewStep(
                      content: Padding(
                        padding: EdgeInsets.only(bottom: size.height * 0.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                              ),
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
                                softWrap: true,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
