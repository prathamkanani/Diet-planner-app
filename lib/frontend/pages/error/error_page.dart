import 'package:flutter/material.dart';
import '../../../infrastructure/extension/context_extension.dart';
import '../../config/app_spacing.dart';

class GenericErrorPage extends StatefulWidget {
  final Object? error;
  final VoidCallback? onRetry;

  const GenericErrorPage({super.key, this.error, this.onRetry});

  @override
  State<GenericErrorPage> createState() => _GenericErrorPageState();
}

class _GenericErrorPageState extends State<GenericErrorPage> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    final th = context.th;
    final cs = context.cs;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 72),
              AppSpacing.h16,

              if (widget.error != null)
                TextButton(
                  onPressed: () => setState(() => showDetails = !showDetails),
                  child: Text(showDetails ? 'Hide details' : 'Show details'),
                ),

              if (showDetails)
                Container(
                  margin: const .only(top: 12),
                  padding: const .all(12),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    borderRadius: .circular(8),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      widget.error.toString(),
                      style: th.bodySmall?.copyWith(fontFamily: 'monospace'),
                    ),
                  ),
                ),

              if (widget.onRetry != null) ...[
                AppSpacing.h24,
                ElevatedButton(
                  onPressed: widget.onRetry,
                  child: const Text('Try again'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
