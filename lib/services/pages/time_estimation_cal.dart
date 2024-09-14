import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/widget/text_field_widget.dart';
import 'package:gap/gap.dart';

class TimeEstimationCal extends StatefulWidget {
  const TimeEstimationCal({super.key});

  @override
  State<TimeEstimationCal> createState() => _TimeEstimationCalState();
}

class _TimeEstimationCalState extends State<TimeEstimationCal> {
  int activeStep = 0;
  final TextEditingController _goldPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Estimation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EasyStepper(
              activeStep: activeStep,
              showLoadingAnimation: true,
              steps: [
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor:
                          activeStep >= 0 ? Colors.orange : Colors.white,
                    ),
                  ),
                  title: 'Waiting',
                ),
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor:
                          activeStep >= 1 ? Colors.orange : Colors.white,
                    ),
                  ),
                  title: 'Order Received',
                ),
                EasyStep(
                  customStep: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 7,
                      backgroundColor:
                          activeStep >= 2 ? Colors.orange : Colors.white,
                    ),
                  ),
                  title: 'Completed',
                ),
              ],
              onStepReached: (index) => setState(() => activeStep = index),
            ),
            TextFieldWidget(
              controller: _goldPrice,
              inputType: TextInputType.number,
              readOnly: true,
              hintText: "Rs. 1,52,000",
              prefixIcon: Icons.payment,
            ),
            const Gap(16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFieldWidget(
                    controller: _goldPrice,
                    inputType: TextInputType.number,
                    hintText: "Product Weight",
                    prefixIcon: Icons.payment,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: TextFieldWidget(
                    controller: _goldPrice,
                    inputType: TextInputType.number,
                    readOnly: true,
                    hintText: "gm",
                    prefixIcon: Icons.scale,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
