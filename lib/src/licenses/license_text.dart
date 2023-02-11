import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:licenses/constants.dart';

class LicenseText extends StatelessWidget {
  const LicenseText({super.key, required this.license});

  final LicenseEntry license;

  @override
  Widget build(BuildContext context) {
    final paragraphs = license.paragraphs.toList();
    const padding = EdgeInsetsDirectional.all(kLicensePadding);
    return ListView.builder(
      padding: padding,
      itemCount: paragraphs.length,
      itemBuilder: (context, index) {
        final paragraph = paragraphs[index];
        final indent = paragraph.indent * kLicenseIndent;
        return Padding(
          padding: padding + EdgeInsetsDirectional.only(start: indent),
          child: Text(
            paragraph.text,
            textAlign: paragraph.indent == LicenseParagraph.centeredIndent
                ? TextAlign.center
                : TextAlign.left,
          ),
        );
      },
    );
  }
}
