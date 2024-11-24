import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omshribhakti/model/user_model.dart';
import '../services/auth_service.dart';

// AuthService Provider
final authServiceProvider = Provider<AuthService>((ref) => AuthService());

// CustomUser State Provider
final customUserProvider = StateNotifierProvider<CustomUserNotifier, CustomUser?>((ref) {
  final authService = ref.watch(authServiceProvider);
  return CustomUserNotifier(authService);
});

// Notifier for managing CustomUser state
class CustomUserNotifier extends StateNotifier<CustomUser?> {
  final AuthService _authService;

  CustomUserNotifier(this._authService) : super(null) ;

  /// Attempt to silently sign in the user.
  Future<void> signInSilently() async {
    try {
      // Attempt silent sign-in via AuthService
      final user = await _authService.signInSilently();
      if (user != null) {
        print("user not null");
        state = user; // Update state with the signed-in user
      }else{
        print("user was null login as guest");
        await signInAsGuest();
      }
    } catch (e) {
      // Handle errors during silent sign-in (e.g., log the error)
      state = null; // Ensure state is null if sign-in fails
      print('Silent Sign-In Failed: $e');
    }
  }

  Future<void> signInWithGoogle() async {
    final user = await _authService.signInWithGoogle();
    state = user;
  }

  Future<void> signInAsGuest() async {
    final guest = await _authService.guestRegisterLogin();
    state = guest;
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = null;
  }
}
