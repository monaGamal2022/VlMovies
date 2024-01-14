bool productionEnvironment = AppFlavor.appFlavor == Flavor.production;

enum Flavor { qc, production, dev }

class AppFlavor {
  static Flavor appFlavor = Flavor.production;

  static String get title {
    switch (appFlavor) {
      case Flavor.production:
        return 'VL Movies Production' ;

      case Flavor.qc:
        return 'VL Movies QC';
      case Flavor.dev:
        return 'VL Movies DEV';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.production:
        return "https://api.themoviedb.org/3/";
      case Flavor.qc:
        return "https://api.themoviedb.org/3/";
      case Flavor.dev:
        return "https://api.themoviedb.org/3/";
    }
  }
}
