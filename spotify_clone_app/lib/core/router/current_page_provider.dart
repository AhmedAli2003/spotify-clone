import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify_clone_app/core/router/app_router.dart';

part 'current_page_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentPage extends _$CurrentPage {
  @override
  String build() {
    final router = ref.watch(appRouterProvider);

    // The current page name will not be null because we ensure that it's provided in the router configuration
    String current() => router.routerDelegate.currentConfiguration.last.route.name!;

    state = current();

    void listener() => state = current();

    router.routeInformationProvider.addListener(listener);

    return state;
  }

  void setCurrentPage(String page) => state = page;
}
