import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final String leadingTxt;
  final String trailingTxt;
  final Function() path;
  const AuthFooter({
    super.key,
    required this.leadingTxt,
    required this.trailingTxt,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Center(
        child: InkWell(
          onTap: path,
          child: RichText(
            text: TextSpan(
              text: leadingTxt,
              style: const TextStyle(
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: trailingTxt,
                  style: const TextStyle(
                    color: Colors.blue,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
