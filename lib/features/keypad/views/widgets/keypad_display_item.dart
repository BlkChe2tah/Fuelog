import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:petrol_ledger/core/utils/extension.dart';

// ignore: must_be_immutable
class KeypadDisplayItem extends StatefulWidget {
  final String label;
  final String value;
  final bool enable;
  bool _isAnimated = false;

  KeypadDisplayItem({
    super.key,
    required this.label,
    required this.value,
    this.enable = false,
  });

  factory KeypadDisplayItem.animate(
      {required String label,
      required String value,
      required bool isAnimated}) {
    return KeypadDisplayItem(label: label, value: value)
      .._isAnimated = isAnimated;
  }

  @override
  State<KeypadDisplayItem> createState() => _KeypadDisplayItemState();
}

class _KeypadDisplayItemState extends State<KeypadDisplayItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<String> _loadingAnimation;
  String? _stateText;

  void _setupAnimation() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    var loadingTextTween = TweenSequence<String>([
      TweenSequenceItem(tween: ConstantTween<String>('.'), weight: 1),
      TweenSequenceItem(tween: ConstantTween<String>('..'), weight: 1),
      TweenSequenceItem(tween: ConstantTween<String>('...'), weight: 1),
    ]);
    _loadingAnimation = _controller.drive(loadingTextTween);
    _controller.addListener(() {
      if (_stateText == null || _stateText != _loadingAnimation.value) {
        setState(() {
          _stateText = _loadingAnimation.value;
        });
      }
    });
  }

  void _updateAnimationState() {
    if (widget._isAnimated) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _updateAnimationState();
  }

  @override
  void didUpdateWidget(covariant KeypadDisplayItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateAnimationState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var checkColor = widget.enable
        ? context.loadColorScheme().onSurface
        : context.loadColorScheme().onSurfaceVariant;
    return SizedBox(
      height: 52.0,
      child: Row(
        children: [
          SizedBox(
            width: 102.0,
            child: Text(
              widget.label,
              maxLines: 1,
              textAlign: TextAlign.start,
              style: context.loadTextTheme().titleLarge?.copyWith(
                    color: checkColor,
                  ),
            ),
          ),
          Expanded(
            child: AutoSizeText(
              widget._isAnimated ? _loadingAnimation.value : widget.value,
              maxLines: 1,
              textAlign: TextAlign.end,
              minFontSize: 24.0,
              style: context.loadTextTheme().displayMedium?.copyWith(
                    fontFamily: 'anonymous pro',
                    color: checkColor,
                    letterSpacing: 1.6,
                    fontSize: widget._isAnimated ? 32.0 : 45.0,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
