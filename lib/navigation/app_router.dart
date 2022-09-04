import 'package:flutter/material.dart';
import 'package:recipes_of_the_day/models/models.dart';
import 'package:recipes_of_the_day/navigation/app_link.dart';
import 'package:recipes_of_the_day/screens/screens.dart';

class AppRouter extends RouterDelegate<AppLink>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final AppStateManager appStateManager;
  final GroceryManager groceryManager;
  final ProfileManager profileManager;

  AppRouter(
      {required this.appStateManager,
      required this.groceryManager,
      required this.profileManager})
      : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
    groceryManager.addListener(notifyListeners);
    profileManager.addListener(notifyListeners);
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    profileManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePopPage,
      pages: [
        if (!appStateManager.isInitialized) ...[
          SplashScreen.page(),
        ] else if (!appStateManager.isLoggedIn) ...[
          LoginScreen.page(),
        ] else if (!appStateManager.isOnboardingComplete) ...[
          OnboardingScreen.page(),
        ] else ...[
          Home.page(appStateManager.getSelectedTab),
          if (groceryManager.isCreatingNewItem)
            GroceryItemScreen.page(
              onCreate: (item) {
                groceryManager.addItem(item);
              },
              onUpdate: (item, index) {
                // No Update
              },
            ),
          if (groceryManager.selectedIndex != -1)
            GroceryItemScreen.page(
              onCreate: (_) {},
              onUpdate: (item, index) {
                groceryManager.updateItem(item, index);
              },
              item: groceryManager.selectedGroceryItem,
              index: groceryManager.selectedIndex,
            ),
          if (profileManager.didSelectUser)
            ProfileScreen.page(profileManager.getUser),
          if (profileManager.didTapOnRaywenderlich) WebViewScreen.page(),
        ],
      ],
    );
  }

  bool _handlePopPage(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == FooderPages.onboardingPath) {
      appStateManager.logout();
    }
    if (route.settings.name == FooderPages.groceryItemDetails) {
      groceryManager.groceryItemTapped(-1);
    }
    if (route.settings.name == FooderPages.profilePath) {
      profileManager.tapOnProfile(false);
    }
    if (route.settings.name == FooderPages.raywenderlich) {
      profileManager.tapOnRaywenderlich(false);
    }

    return true;
  }

  @override
  AppLink get currentConfiguration => getCurrentPath();

  AppLink getCurrentPath() {
    if (!appStateManager.isLoggedIn) {
      return AppLink(location: AppLink.loginpath);
    } else if (!appStateManager.isOnboardingComplete) {
      return AppLink(location: AppLink.onboardingPath);
    } else if (profileManager.didSelectUser) {
      return AppLink(location: AppLink.profilePath);
    } else if (groceryManager.isCreatingNewItem) {
      return AppLink(location: AppLink.itemPath);
    } else if (groceryManager.selectedGroceryItem != null) {
      final id = groceryManager.selectedGroceryItem?.id;
      return AppLink(location: AppLink.itemPath, itemId: id);
    } else {
      return AppLink(
          location: AppLink.homePath,
          currentTab: appStateManager.getSelectedTab);
    }
  }

  @override
  Future<void> setNewRoutePath(AppLink configuration) async {
    switch (configuration.location) {
      case AppLink.profilePath:
        profileManager.tapOnProfile(true);
        break;
      case AppLink.itemPath:
        final itemId = configuration.itemId;
        if (itemId != null) {
          groceryManager.setSelectedGroceryItem(itemId);
        } else {
          groceryManager.createNewItem();
        }
        profileManager.tapOnProfile(false);
        break;
      case AppLink.homePath:
        appStateManager.goToTab(configuration.currentTab ?? 0);
        profileManager.tapOnProfile(false);
        groceryManager.groceryItemTapped(-1);
        break;
      default:
        break;
    }
  }
}
