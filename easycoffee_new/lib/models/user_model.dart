class LocalUser {
  final String uid;
  final String email;

  LocalUser({required this.uid, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  factory LocalUser.fromMap(Map<String, dynamic> map) {
    return LocalUser(
      uid: map['uid'],
      email: map['email'],
    );
  }
}
