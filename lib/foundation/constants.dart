class Constants {
  Constants({
    required this.session,
    required this.httpBaseUri,
    required this.email,
    required this.password,
  });

  factory Constants.of() {
    return Constants(
      httpBaseUri: 'https://massengeschmack.tv',
      session: 'mgtv_session',
      email: 'email',
      password: 'password',
    );
  }

  final String httpBaseUri;
  final String session;
  final String email;
  final String password;
}
