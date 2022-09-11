class Constants {
  Constants({
    required this.endpoint,
  });

  factory Constants.of() {
    return Constants(
      endpoint: 'https://massengeschmack.tv',
    );
  }

  final String endpoint;
}
