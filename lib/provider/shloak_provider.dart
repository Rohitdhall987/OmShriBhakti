import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/ShalokModel.dart';
import 'package:omshribhakti/services/shloak_Services.dart';

final shlokaProvider = StateNotifierProvider<ShlokaNotifier, AsyncValue<Shalok>>(
      (ref) => ShlokaNotifier(),
);

class ShlokaNotifier extends StateNotifier<AsyncValue<Shalok>> {
  ShlokaNotifier() : super(const AsyncValue.loading());

  final ShlokaService _service = ShlokaService();

  Future<void> loadShloka(int adhyaya, int shloka) async {
    state = const AsyncValue.loading();
    final shalokModel = await _service.fetchShloka(adhyaya, shloka);
    if (shalokModel != null) {
      state = AsyncValue.data(shalokModel.shalok);
    } else {
      state =  AsyncValue.error('Failed to load shloka',StackTrace.current);
    }
  }
}
