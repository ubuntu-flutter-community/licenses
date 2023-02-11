import 'dart:async';

import 'package:flutter/material.dart';
import 'package:licenses/constants.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class NaviButton extends StatefulWidget {
  const NaviButton({
    super.key,
    this.enabled = true,
    required this.onPressed,
    required this.icon,
  });

  final bool enabled;
  final VoidCallback? onPressed;
  final Widget icon;

  @override
  State<NaviButton> createState() => _NaviButtonState();
}

class _NaviButtonState extends State<NaviButton> {
  Timer? _repeatTimer;

  void _startRepeat() {
    _repeatTimer ??= Timer.periodic(
      kSlideDuration,
      (_) => widget.onPressed?.call(),
    );
  }

  void _stopRepeat() {
    _repeatTimer?.cancel();
    _repeatTimer = null;
  }

  @override
  void didUpdateWidget(NaviButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.enabled) {
      _stopRepeat();
    }
  }

  @override
  void dispose() {
    _stopRepeat();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) => widget.enabled ? _startRepeat() : null,
      onLongPressEnd: (_) => _stopRepeat(),
      onLongPressCancel: _stopRepeat,
      child: YaruIconButton(
        onPressed: widget.enabled ? widget.onPressed : null,
        icon: widget.icon,
      ),
    );
  }
}
