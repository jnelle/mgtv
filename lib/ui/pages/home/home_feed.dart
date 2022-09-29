// ignore: implementation_imports
import 'package:auto_route/src/router/controller/routing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/main_feed/main_feed.dart';
import 'package:mgtv/data/provider/episode_provider.dart';
import 'package:mgtv/data/provider/mainfeed_provider.dart';
import 'package:mgtv/foundation/extension/asyncsnapshot.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:mgtv/ui/components/appbar/home_appbar.dart';
import 'package:mgtv/ui/components/feed/episode.dart';
import 'package:mgtv/ui/hooks/use_router.dart';
import 'package:mgtv/ui/route/app_route.dart';
import 'package:mgtv/ui/user_view_model.dart';
import 'package:sized_context/sized_context.dart';

class HomeFeed extends HookConsumerWidget {
  const HomeFeed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserViewModel userViewModel = ref.read(userViewModelProvider);
    StackRouter router = useRouter();
    bool rebuild = false;

    Future<String> imageUrlSnapshot = useMemoized(
        () =>
            userViewModel.getWebsiteHeaderPicture(cookie: userViewModel.cookie),
        <Object>[rebuild]);
    Future<List<String?>> titleSnapshot = useMemoized(
        () => userViewModel.getWebsiteHeaderTitle(cookie: userViewModel.cookie),
        <Object>[rebuild]);
    Future<List<MainFeed>> mainFeedSnapshot = useMemoized(
        () => userViewModel.getMainFeed(cookie: userViewModel.cookie),
        <Object>[rebuild]);

    AsyncSnapshot<List<String?>> title = useFuture(titleSnapshot);
    AsyncSnapshot<String> imageUrl = useFuture(imageUrlSnapshot);
    AsyncSnapshot<List<MainFeed>> mainFeed = useFuture(mainFeedSnapshot);

    return SizedBox(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          homeAppBar(title: title, imageUrl: imageUrl),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: mainFeed.data?.length,
              (BuildContext _, int index) => mainFeed.present(
                context: context,
                onData: (BuildContext _, List<MainFeed> feed) =>
                    GestureDetector(
                  onTap: () {
                    ref.read(mainFeedProvider.notifier).state = feed[index];
                    router.push(
                      const Clip(),
                    );
                  },
                  child: ProviderScope(
                    overrides: <Override>[
                      episodeProvider.overrideWithValue(feed[index])
                    ],
                    child: const EpisodeWidget(),
                  ),
                ),
                onError: (BuildContext _, Object __, StackTrace ___) => Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Ein Fehler ist aufgetreten',
                        style: GoogleFonts.montserrat(
                          color: Colors.red,
                          fontSize: context.widthPct(0.075),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await userViewModel.refreshCookie();
                          rebuild = rebuild ? false : true;
                        },
                        child: Text(
                          'Seite neu laden',
                          style: GoogleFonts.montserrat(
                            color: ColorName.black,
                            fontSize: context.widthPct(0.075),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
