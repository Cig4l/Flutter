abstract interface class AuthRepository {
  Future<void> ensureSignedIn();  // login only if no existing session

  String? get currentUserId;
}