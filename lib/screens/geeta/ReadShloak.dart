import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/provider/shloak_provider.dart';
import 'package:omshribhakti/utils/Colors.dart';

class ReadShloak extends ConsumerStatefulWidget {
  final int adhyaya;
  final int shlokaNumber;

  const ReadShloak({super.key, required this.adhyaya, required this.shlokaNumber});

  @override
  ConsumerState<ReadShloak> createState() => _ReadShloakState();
}

class _ReadShloakState extends ConsumerState<ReadShloak> {

  @override
  void initState() {
    super.initState();
    // Trigger the loadShloka only once during initialization
    Future.microtask(() =>
        ref.read(shlokaProvider.notifier).loadShloka(widget.adhyaya, widget.shlokaNumber));
  }

  @override
  Widget build(BuildContext context) {
    final shlokaState = ref.watch(shlokaProvider);


    return Scaffold(
      appBar: AppBar(
        title: Text('Adhyaya ${widget.adhyaya} - Shloka ${widget.shlokaNumber}'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.6,
            colors: [
              AppTheme.background,
              AppTheme.primary.shade200,
              AppTheme.background,
            ],
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: shlokaState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data: (shloka) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'English',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                shloka.englishTitle?? 'No English text available',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 20),
              Divider(color: AppTheme.primary, thickness: 1),
              const SizedBox(height: 20),
              const Text(
                'Hindi',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                shloka.hindiTitle ?? 'No Hindi text available',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const SizedBox(height: 20),
              Divider(color: AppTheme.primary, thickness: 1),
              const SizedBox(height: 20),
              const Text(
                'Sanskrit',
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                shloka.sanskritTitle ?? 'No Sanskrit text available',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
