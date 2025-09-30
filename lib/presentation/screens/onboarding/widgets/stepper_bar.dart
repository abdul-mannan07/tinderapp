import 'package:flutter/material.dart';
import 'package:tinderapp/presentation/theme/app_theme.dart';


class StepProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate progress ratio
    double progress = currentStep / totalSteps;

    return Container(
      height: 8,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300], // Background of stepper
        borderRadius: BorderRadius.circular(10),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Gradient progress bar
              Container(
                width: constraints.maxWidth * progress,
                decoration: BoxDecoration(
                  gradient: AppTheme.tinderGradient,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
