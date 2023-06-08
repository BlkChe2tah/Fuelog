import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:petrol_ledger/provider/export_data_provider.dart';
import 'package:petrol_ledger/res/values.dart';
import 'package:petrol_ledger/screens/sale_data_export/sale_data_export_screen.dart';
import 'package:petrol_ledger/screens/sale_data_export/shimmer_progress.dart';
import 'package:petrol_ledger/utils/extension.dart';
import 'package:petrol_ledger/utils/ui_state.dart';
import 'package:provider/provider.dart';

class AnimatedExportProgress extends StatelessWidget {
  const AnimatedExportProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ExportDataProvider, UiState>(
      selector: (_, provider) => provider.exportState,
      builder: (context, exportState, child) {
        if (exportState is ExportingSuccessMode) {
          return const _ExportStateLayout(
            icon: Symbols.task_alt,
            message: 'File was successfully exported.',
          );
        }
        if (exportState is ExportingErrorMode) {
          return const _ExportStateLayout(
            icon: Symbols.bug_report,
            message: 'An unexcepted error occurred when exporting the file.',
          );
        }
        return child!;
      },
      child: const _ShimmerProgressLayout(),
    );
  }
}

// layout
class _ShimmerProgressLayout extends StatelessWidget {
  const _ShimmerProgressLayout();

  @override
  Widget build(BuildContext context) {
    return ShimmerProgress(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(kHuge),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius),
          color: context.loadColorScheme().surface,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Selector<ExportDataProvider, int>(
              selector: (_, provider) => provider.progress,
              builder: (context, progress, child) {
                return _AnimatedProgressText(progress: progress);
              },
            ),
            const SizedBox(height: kHuge),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: context.loadColorScheme().onSurfaceVariant,
                ),
              ),
              child: Text(
                'Cancel',
                style: context.loadTextTheme().labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: context.loadColorScheme().onSurfaceVariant,
                      letterSpacing: 1.8,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// progress text
class _AnimatedProgressText extends StatefulWidget {
  final int progress;
  const _AnimatedProgressText({required this.progress});

  @override
  State<_AnimatedProgressText> createState() => __AnimatedProgressTextState();
}

class __AnimatedProgressTextState extends State<_AnimatedProgressText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Animation<int>? _animation;
  int _prevProgress = 0;

  void _initAnimation() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    _initAnimation();
    if (widget.progress != 0) {
      _updateAnimation(widget.progress);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _AnimatedProgressText oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateAnimation(widget.progress);
  }

  void _updateAnimation(int value) {
    final tween = IntTween(begin: _prevProgress, end: value);
    _prevProgress = value;
    _animation = _controller.drive(tween);
    if (!_controller.isAnimating) {
      _refreshController();
    }
  }

  void _refreshController() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '${_animation?.value ?? 0}%',
      textAlign: TextAlign.center,
      style: context.loadTextTheme().displayLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}

// Error layout
class _ExportStateLayout extends StatelessWidget {
  final IconData icon;
  final String message;
  const _ExportStateLayout({
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(kXLarge),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: context.loadColorScheme().surface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            icon,
            size: 46.0,
            color: context.loadColorScheme().onSurface,
          ),
          const SizedBox(height: kLarge),
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.loadTextTheme().bodyLarge?.copyWith(
                  fontSize: 18.0,
                ),
          ),
          const SizedBox(height: kXLarge),
          FilledButton(
            onPressed: () {
              final type = context.read<ExportDataProvider>().exportType;
              Navigator.pop(context, type == ExportType.all);
            },
            child: const Text(
              'OK',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
