library generic;

class User<C> {
  List<C> credentials;

  User() {
    credentials = <C>[];
  }
  User<C> operator +(C credential) {
    credentials.add(credential);
    return this;
  }

  void addCredential(C credential) {
    credentials.add(credential);
  }

  bool containsCredential(C credential) {
    return credentials.any((item) => item == credential);
  }

  List<C> getCredentialsList() {
    return List<C>.from(credentials);
  }
}
