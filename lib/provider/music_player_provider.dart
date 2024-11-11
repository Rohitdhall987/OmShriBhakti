import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MusicPlayerProvider with ChangeNotifier {
  // Properties for song, playback state, and UI mode
  bool _isPlaying = false;
  bool _isMinimized = false;
  bool _isHidden = true;
  String? _currentSong;

  // Getters
  bool get isPlaying => _isPlaying;
  bool get isMinimized => _isMinimized;
  bool get isHidden => _isHidden;
  String? get currentSong => _currentSong;

  // Methods to control playback
  void play(String song) {
    _currentSong = song;
    _isPlaying = true;
    _isMinimized = false;
    notifyListeners();
  }

  void pause() {
    _isPlaying = false;
    notifyListeners();
  }

  void toggleMinimize() {
    _isMinimized = !_isMinimized;
    notifyListeners();
  }

  void hide(){
    _isHidden = true;
    notifyListeners();
  }
  void display(){
    _isHidden = false;
    notifyListeners();
  }

// Add other controls as needed
}

final playerProvider = ChangeNotifierProvider<MusicPlayerProvider>((ref) {
  return MusicPlayerProvider();
});
