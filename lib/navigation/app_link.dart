class AppLink {
  static const String homePath = '/home';
  static const String onboardingPath = '/onboarding';
  static const String loginpath = '/login';
  static const String profilePath = '/profile';
  static const String itemPath = '/item';

  static const String tabParam = 'tab';
  static const String idParam = 'id';

  String? location;
  int? currentTab;
  String? itemId;

  AppLink({
    this.location,
    this.currentTab,
    this.itemId,
  });

  static AppLink fromLocation(String? location) {
    location = Uri.decodeFull(location ?? '');
    final uri = Uri.parse(location);
    final params = uri.queryParameters;
    final currentTab = int.tryParse(params[AppLink.idParam] ?? '');
    final itemId = params[AppLink.idParam];
    final link = AppLink(
      location: uri.path,
      currentTab: currentTab,
      itemId: itemId,
    );
    return link;
  }

  String toLocation() {
    String addKeyValPair({
      required String key,
      String? value,
    }) =>
        value == null ? '' : '$key=$value&';

    switch (location) {
      case loginpath:
        return loginpath;
      case onboardingPath:
        return onboardingPath;
      case profilePath:
        return profilePath;
      case itemPath:
        var loc = '$itemPath?';
        loc += addKeyValPair(
          key: idParam,
          value: itemId,
        );
        return Uri.encodeFull(loc);
      default:
        var loc = '$homePath?';
        loc += addKeyValPair(
          key: tabParam,
          value: currentTab.toString(),
        );
        return Uri.encodeFull(loc);
    }
  }
}
