import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

// --- PlayerState Class ---
class PlayerState {
  final bool isPlaying;
  final bool isPaused;
  final bool isLoaded;
  final bool isMinimized;
  final bool isHidden;
  final String songName;
  final String singerName;
  final String image;
  final Duration totalDuration;
  final Duration currentPosition;
  final double amplitude;
  final double phaseShift;
  final bool shouldRepeat;
  final bool shuffle;

  PlayerState({
    this.isPlaying = false,
    this.isPaused = true,
    this.isLoaded = false,
    this.isMinimized = false,
    this.isHidden = true,
    this.songName = '',
    this.singerName = '',
    this.image = '',
    this.totalDuration = Duration.zero,
    this.currentPosition = Duration.zero,
    this.amplitude = 0.0,
    this.phaseShift = 0.0,
    this.shouldRepeat = false,
    this.shuffle = false,
  });

  PlayerState copyWith({
    bool? isPlaying,
    bool? isPaused,
    bool? isLoaded,
    bool? isMinimized,
    bool? isHidden,
    String? songName,
    String? singerName,
    String? image,
    Duration? totalDuration,
    Duration? currentPosition,
    double? amplitude,
    double? phaseShift,
    bool? shouldRepeat,
    bool? shuffle,
  }) {
    return PlayerState(
      isPlaying: isPlaying ?? this.isPlaying,
      isPaused: isPaused ?? this.isPaused,
      isLoaded: isLoaded ?? this.isLoaded,
      isMinimized: isMinimized ?? this.isMinimized,
      isHidden: isHidden ?? this.isHidden,
      songName: songName ?? this.songName,
      singerName: singerName ?? this.singerName,
      image: image ?? this.image,
      totalDuration: totalDuration ?? this.totalDuration,
      currentPosition: currentPosition ?? this.currentPosition,
      amplitude: amplitude ?? this.amplitude,
      phaseShift: phaseShift ?? this.phaseShift,
      shouldRepeat: shouldRepeat ?? this.shouldRepeat,
      shuffle: shuffle ?? this.shuffle,
    );
  }
}

class PlayerStateNotifier extends StateNotifier<PlayerState> {
  final AudioPlayer _audioPlayer;
  List<Map<String, String>> _playlist = [];
  int _currentIndex = -1; // Current song index

  PlayerStateNotifier() : _audioPlayer = AudioPlayer(), super(PlayerState()) {
    _initialize();
  }

  void _initialize() {
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.processingState != ProcessingState.completed) {
        state = state.copyWith(
          isPlaying: _audioPlayer.playing,
          isPaused: !_audioPlayer.playing,
          isLoaded: true,
          currentPosition: _audioPlayer.position,
          totalDuration: _audioPlayer.duration ?? Duration.zero,
        );
      } else {
        _handleCompletion();
      }
    });

    _audioPlayer.positionStream.listen((position) {
      state = state.copyWith(
        currentPosition: position,
        amplitude: (position.inMilliseconds % 100) / 100,
        phaseShift: (state.phaseShift + 0.1) % (2 * pi),
      );
    });

    _audioPlayer.loopModeStream.listen((loopMode) {
      state = state.copyWith(shouldRepeat: loopMode == LoopMode.one);
    });
  }

  void _handleCompletion() {
    if (state.shuffle) {
      playShuffle();
    } else if (hasNext) {
      playNext();
    } else if (state.shouldRepeat) {
      repeat();
    } else {
      stop();
      state = state.copyWith(isHidden: true);
    }
  }

  // --- Public Methods ---
  Future<void> play(String songUrl, {String songName = '', String singer = '', String imageUrl = ''}) async {
    state = state.copyWith(songName: songName, singerName: singer, image: imageUrl);
    await _audioPlayer.setUrl(songUrl);
    await _audioPlayer.play();
    state = state.copyWith(isPlaying: true, isPaused: false);
  }

  Future<void> addSongs(List<Map<String, String>> playlist) async {
    _playlist=[];//empty playlist
    // Add new songs to the playlist
    _playlist = playlist;
    _currentIndex = _playlist.isNotEmpty ? 0 : -1; // Set the index to the first song if playlist is not empty
  }

  bool get hasNext => _currentIndex < _playlist.length - 1;
  bool get hasPrevious => _currentIndex > 0;

  Future<void> playNext() async {
    if (hasNext) {
      _currentIndex++;
      final nextSong = _playlist[_currentIndex];
      await play(
        nextSong['url']!,
        songName: nextSong['name'] ?? '',
        singer: nextSong['singer'] ?? '',
        imageUrl: nextSong['image'] ?? '',
      );
    }
  }

  Future<void> playPrevious() async {
    if (hasPrevious) {
      _currentIndex--;
      final prevSong = _playlist[_currentIndex];
      await play(
        prevSong['url']!,
        songName: prevSong['name'] ?? '',
        singer: prevSong['singer'] ?? '',
        imageUrl: prevSong['image'] ?? '',
      );
    }
  }

  void playShuffle() {
    if (_playlist.isNotEmpty) {
      _currentIndex = Random().nextInt(_playlist.length);
      final shuffledSong = _playlist[_currentIndex];
      play(
        shuffledSong['url']!,
        songName: shuffledSong['name'] ?? '',
        singer: shuffledSong['singer'] ?? '',
        imageUrl: shuffledSong['image'] ?? '',
      );
    }
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    state = state.copyWith(isPlaying: true, isPaused: true);
  }

  Future<void> resume() async {
    await _audioPlayer.play();
    state = state.copyWith(isPlaying: true, isPaused: false);
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    state = state.copyWith(isPlaying: false, isPaused: true, isLoaded: false);
  }

  void repeat() {
    _audioPlayer.setLoopMode(LoopMode.one);
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
    state = state.copyWith(currentPosition: position);
  }

  void updateCurrentPosition(Duration position) {
    state = state.copyWith(currentPosition: position);
  }

  void toggleShuffle() {
    state = state.copyWith(shuffle: !state.shuffle);
    if (state.shuffle) {
      playShuffle();
    }
  }

  void toggleRepeat() {
    state = state.copyWith(shouldRepeat: !state.shouldRepeat);
    if (state.shouldRepeat) {
      repeat();
    }
  }

  void toggleMinimize() {
    state = state.copyWith(isMinimized: !state.isMinimized);
  }

  void hide() {
    state = state.copyWith(isHidden: true);
  }

  void display() {
    state = state.copyWith(isHidden: false);
  }

  void disposePlayer() {
    _audioPlayer.dispose();
  }
}


// --- Riverpod Provider ---
final playerProvider = StateNotifierProvider<PlayerStateNotifier, PlayerState>(
      (ref) => PlayerStateNotifier(),
);
