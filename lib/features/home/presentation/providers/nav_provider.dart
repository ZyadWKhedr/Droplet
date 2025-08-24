import 'package:flutter_riverpod/flutter_riverpod.dart';

final navIndexProvider = StateNotifierProvider<NavNotifier, int>((ref) {
  return NavNotifier();
});

class NavNotifier extends StateNotifier<int> {
  NavNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }

  void toggleIndex(int index) {
    if (state == index) {
      return;
    } else {
      setIndex(index);
    }
  }
}
