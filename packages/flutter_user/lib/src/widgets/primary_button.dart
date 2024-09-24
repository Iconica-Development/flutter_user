import "package:flutter/material.dart";

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.buttonTitle,
    required this.onPressed,
    super.key,
  });

  final String buttonTitle;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: FilledButton(
              onPressed: onPressed,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  buttonTitle,
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
            ),
          ),
        ],
      );
}
