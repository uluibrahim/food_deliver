class DefaultSize {
  static DefaultSize? _instance;
  static DefaultSize get instance => _instance ??= DefaultSize._();
  DefaultSize._();

  final double defaultHeight50 = 50.0;
}
