class Constants {
  Constants({
    required this.session,
    required this.httpBaseUri,
    required this.email,
    required this.password,
    required this.defaultImage,
    required this.musicType,
    required this.videoType,
  });

  factory Constants.of() {
    return Constants(
      httpBaseUri: 'https://massengeschmack.tv',
      session: 'mgtv_session',
      email: 'email',
      password: 'password',
      defaultImage: 'https://massengeschmack.tv/img/header/slider_retina.jpg',
      musicType: 'music',
      videoType: 'video',
    );
  }

  final String httpBaseUri;
  final String session;
  final String email;
  final String password;
  final String defaultImage;
  final String musicType;
  final String videoType;
}
