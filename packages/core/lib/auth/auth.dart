abstract class Auth {
  Future<bool> hasRefreshToken();

  Future<String> getAccessToken();

  Future<void> login(String patientCode, String birthdate);

  Future<void> logout();
}
