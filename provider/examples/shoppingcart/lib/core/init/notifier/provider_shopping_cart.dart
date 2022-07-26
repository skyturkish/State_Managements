class ShoppingCardProvider {
  static ShoppingCardProvider? _instance;
  static ShoppingCardProvider get instance {
    _instance ??= ShoppingCardProvider._init();
    return _instance!;
  }

  ShoppingCardProvider._init();
}
