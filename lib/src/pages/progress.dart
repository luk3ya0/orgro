import 'package:flutter/material.dart';
import 'package:orgro/src/temp_localizations.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({
    super.key,
    this.message,
    this.progress,
  });
  
  final String? message;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.pageTitleLoading),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (progress != null)
              SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: CircularProgressIndicator(
                        value: progress,
                        strokeWidth: 6,
                      ),
                    ),
                    Text(
                      '${(progress! * 100).toInt()}%',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              )
            else
              const SizedBox(
                width: 120,
                height: 120,
                child: CircularProgressIndicator(strokeWidth: 6),
              ),
            const SizedBox(height: 32),
            if (message != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  message!,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
