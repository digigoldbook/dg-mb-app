import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/utils/toast_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../bloc/feedback_bloc.dart';
import '../../components/config/app_icons.dart';
import '../../components/widget/app_bar.dart';
import '../../components/widget/btn_widget.dart';
import '../../components/widget/text_field_widget.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController _fullname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _subject = TextEditingController();
  final TextEditingController _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        context,
        title: "Feedback",
      ),
      body: BlocProvider(
        create: (_) => FeedbackBloc(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<FeedbackBloc, FeedbackState>(
            listener: (context, state) {
              if (state is FeedbackSuccess) {
                showToast("Feedback Send Successfully");
              } else if (state is FeedbackFailure) {
                showToast(state.error);
              }
            },
            builder: (context, state) {
              if (state is FeedbackLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  TextFieldWidget(
                    controller: _fullname,
                    inputType: TextInputType.text,
                    hintText: "John Doe",
                    prefixIcon: AppIcons.instance.person,
                  ),
                  const Gap(16),
                  TextFieldWidget(
                    controller: _email,
                    inputType: TextInputType.emailAddress,
                    hintText: "someone@example.com",
                    prefixIcon: AppIcons.instance.email,
                  ),
                  const Gap(16),
                  TextFieldWidget(
                    controller: _subject,
                    inputType: TextInputType.text,
                    hintText: "This is the request to ...",
                    prefixIcon: AppIcons.instance.abc,
                  ),
                  const Gap(16),
                  TextFieldWidget(
                    controller: _message,
                    inputType: TextInputType.text,
                    hintText: "Enter your message ...",
                    maxLine: 5,
                    prefixIcon: AppIcons.instance.abc,
                  ),
                  const Gap(8 * 4),
                  BtnWidget(
                    btnText: "Send Feedback",
                    onTap: () {
                      BlocProvider.of<FeedbackBloc>(context).add(
                        SendFeedbackEvent(
                          fullname: _fullname.text,
                          email: _email.text,
                          subject: _subject.text,
                          message: _message.text,
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
