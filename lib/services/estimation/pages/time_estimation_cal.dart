import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../cubit/estimation_step_cubit.dart';
import '../widgets/deposit_time_estimation.dart';
import '../widgets/deposite_price_estimation.dart';
import '../widgets/gold_price_widget.dart';

class TimeEstimationCal extends StatelessWidget {
  const TimeEstimationCal({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the steps in a list
    final List<String> stepTitles = ['Waiting', 'Order Received', 'Completed'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Estimation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BlocBuilder<EstimationStepCubit, EstimationStepState>(
              builder: (context, state) {
                final currentStep = (state as EstimationStepInitial).newStep;

                return EasyStepper(
                  activeStep: currentStep,
                  showLoadingAnimation: true,
                  steps: stepTitles.asMap().entries.map((entry) {
                    int index = entry.key;
                    String title = entry.value;

                    return EasyStep(
                      enabled: currentStep >= index ? true : false,
                      customStep: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 7,
                          backgroundColor: currentStep >= index
                              ? Colors.orange
                              : Colors.white,
                        ),
                      ),
                      title: title,
                    );
                  }).toList(),
                  onStepReached: (index) {
                    // Update the step using the Cubit
                    context.read<EstimationStepCubit>().updateStep(index);
                  },
                );
              },
            ),
            const Gap(16),
            // Display widgets based on the active step
            BlocBuilder<EstimationStepCubit, EstimationStepState>(
              builder: (context, state) {
                final int currentStep =
                    (state as EstimationStepInitial).newStep;

                if (currentStep == 0) {
                  return const GoldPriceWidget();
                } else if (currentStep == 1) {
                  return const DepositePriceEstimation();
                } else {
                  return const DepositTimeEstimation();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
