import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;

import 'package:gap/gap.dart';

import '../../components/widget/app_bar.dart';
import '../../components/widget/txt_widget.dart';

class NewsDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const NewsDetailPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    var document = html_parser.parse(data['content']['rendered']);
    String parsedString = document.body?.text ?? '';

    return Scaffold(
      appBar: customAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Image.network(
                data['jetpack_featured_media_url'],
                width: double.infinity,
                height: 300,
                fit: BoxFit.fill,
              ),
            ),
            const Gap(16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TxtWidget(
                strText: data['title']['rendered'],
                style: TxtStyle.mdb,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TxtWidget(
                strText: parsedString,
                style: TxtStyle.rg,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
