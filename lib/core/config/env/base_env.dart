abstract class BaseEnv{
  String get baseUrl;
}

enum Flavor{
  prod('Bundlegram Production'),
  dev('Bundlegram Development'),
  staging('Bundlegram Staging');

  const Flavor(this.title);
  final String title;
}

class F{
  static Flavor appFlavor = Flavor.dev;
}
