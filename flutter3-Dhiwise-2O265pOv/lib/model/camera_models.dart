// lib/models/camera.dart

class StaticCamera {
  final String ipAddress;
  final String username;
  final String password;

  StaticCamera({
    required this.ipAddress,
    required this.username,
    required this.password,
  });
}

class DDNSCamera {
  final String ddnsHostname;
  final String username;
  final String password;

  DDNSCamera({
    required this.ddnsHostname,
    required this.username,
    required this.password,
  });
}
