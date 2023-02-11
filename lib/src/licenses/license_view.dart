import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:licenses/widgets.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'license_text.dart';

class LicenseView extends StatefulWidget {
  const LicenseView({super.key, required this.licenses});

  final List<LicenseEntry> licenses;

  @override
  State<LicenseView> createState() => _LicenseViewState();
}

class _LicenseViewState extends State<LicenseView> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YaruDetailPage(
      appBar: YaruWindowTitleBar(
        leading: Visibility(
          visible: Navigator.of(context).canPop(),
          child: const YaruBackButton(),
        ),
        title: Text(widget.licenses.first.packages.first),
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.licenses.length,
        itemBuilder: (context, index) => LicenseText(
          license: widget.licenses[index],
        ),
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Visibility(
        visible: widget.licenses.length > 1,
        child: NaviBar(
          controller: _controller,
          length: widget.licenses.length,
        ),
      ),
    );
  }
}
