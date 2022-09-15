// ignore: implementation_imports
import 'package:auto_route/src/router/controller/routing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/main_feed/main_feed.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:mgtv/ui/components/appbar/home_appbar.dart';
import 'package:mgtv/ui/components/feed/episode.dart';
import 'package:mgtv/ui/hook/use_router.dart';
import 'package:mgtv/ui/route/app_route.dart';
import 'package:mgtv/ui/user_view_model.dart';

class HomeFeed extends HookConsumerWidget {
  const HomeFeed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserViewModel userViewModel = ref.read(userViewModelProvider);
    StackRouter router = useRouter();
    Future<String> imageUrlSnapshot = useMemoized(() =>
        userViewModel.getWebsiteHeaderPicture(cookie: userViewModel.cookie));
    Future<List<String?>> titleSnapshot = useMemoized(() =>
        userViewModel.getWebsiteHeaderTitle(cookie: userViewModel.cookie));
    Future<List<MainFeed>> mainFeedSnapshot = useMemoized(
        () => userViewModel.getMainFeed(cookie: userViewModel.cookie));

    AsyncSnapshot<List<String?>> title = useFuture(titleSnapshot);
    AsyncSnapshot<String> imageUrl = useFuture(imageUrlSnapshot);
    AsyncSnapshot<List<MainFeed>> mainFeed = useFuture(mainFeedSnapshot);

    useEffect(() {
      if (mainFeed.hasError) {
        userViewModel.refreshCookie();
      }
      return () {};
    }, <Object>[mainFeed.hasError]);

    return SizedBox(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          homeAppBar(title: title, imageUrl: imageUrl),
          SliverList(
            delegate: SliverChildListDelegate(
              mainFeed.hasData
                  ? <Widget>[
                      ...mainFeed.data!.map(
                        (MainFeed e) => GestureDetector(
                          onTap: () => router.push(Clip(mainFeedElement: e)),
                          child: EpisodeWidget(
                            key: Key('${e.hashCode}'),
                            episodeDescription: '${e.desc}',
                            episodeName: '${e.title}',
                            imageUrl: '${e.img}',
                            magazineName: '${e.pdesc}',
                          ),
                        ),
                      ),
                    ]
                  : <Widget>[
                      const Center(
                        child: CircularProgressIndicator(
                          color: ColorName.primaryColor,
                        ),
                      )
                    ],
            ),
          )
        ],
      ),
    );
  }
}
