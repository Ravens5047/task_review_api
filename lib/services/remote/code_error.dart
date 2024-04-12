const String wrongPassworld = 'WRONG_PASSWORD';

extension CodeExString on String? {
  String? get toLang {
    switch (this) {
      case wrongPassworld:
        return 'Password is wrong 😐';
    }
    return '$this 😐';
  }
}
