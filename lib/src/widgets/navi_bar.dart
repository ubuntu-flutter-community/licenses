import 'package:flutter/material.dart';
import 'package:licenses/constants.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

import 'navi_button.dart';

class NaviBar extends StatelessWidget {
  const NaviBar({super.key, required this.length, required this.controller});

  final int length;
  final PageController controller;

  int get _currentPage => controller.page?.round() ?? 0;
  bool get _hasPreviousPage => _currentPage > 0;
  bool get _hasNextPage => _currentPage < length - 1;

  void _animateToPage(int page) {
    controller.animateToPage(
      page,
      duration: kSlideDuration,
      curve: kSlideCurve,
    );
  }

  void _previousPage() {
    controller.previousPage(
      duration: kSlideDuration,
      curve: kSlideCurve,
    );
  }

  void _nextPage() {
    controller.nextPage(
      duration: kSlideDuration,
      curve: kSlideCurve,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(kNaviBarPadding),
            child: NaviButton(
              onPressed: _hasPreviousPage ? _previousPage : null,
              icon: const Icon(YaruIcons.go_previous),
            ),
          ),
          Expanded(
            child: YaruPageIndicator(
              length: length,
              page: _currentPage,
              onTap: _animateToPage,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(kNaviBarPadding),
            child: NaviButton(
              onPressed: _hasNextPage ? _nextPage : null,
              icon: const Icon(YaruIcons.go_next),
            ),
          ),
        ],
      ),
    );
  }
}
