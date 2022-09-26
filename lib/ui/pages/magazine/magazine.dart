import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/get_feed/ep.dart';
import 'package:mgtv/data/models/get_feed/get_feed.dart';
import 'package:mgtv/data/models/magazine/magazine.dart';
import 'package:mgtv/data/provider/episode_provider.dart';
import 'package:mgtv/foundation/extension/episode.dart';
import 'package:mgtv/gen/assets.gen.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:mgtv/ui/components/feed/episode.dart';
import 'package:mgtv/ui/hooks/use_router.dart';
import 'package:mgtv/ui/user_view_model.dart';
import 'package:sized_context/sized_context.dart';
import 'package:mgtv/ui/route/app_route.dart' as route;

class MagazinePage extends HookConsumerWidget {
  const MagazinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserViewModel userViewModel = ref.read(userViewModelProvider);
    ValueNotifier<Magazine> currentMagazine = useState(Magazine());
    StackRouter router = useRouter();

    Future<List<Magazine>> magazinesFuture = useMemoized(
        () => userViewModel.getMagazines(cookie: userViewModel.cookie));
    Future<GetFeed> feedFuture = useMemoized(
        () => userViewModel.getFeed(
              action: 'getFeed',
              from: <String>['${currentMagazine.value.pid ?? 17}'],
              limit: 10,
              page: 1,
              cookie: userViewModel.cookie,
            ),
        <Object>[currentMagazine.value]);
    Future<String> magazinePictureFuture = useMemoized(
        () => userViewModel.getMagazineHeadPictures(
            cookie: userViewModel.cookie,
            magazine: currentMagazine.value.title ?? 'comictalk'),
        <Object>[currentMagazine.value]);

    AsyncSnapshot<GetFeed> feedSnapshot = useFuture(feedFuture);
    AsyncSnapshot<List<Magazine>> magazineSnapshot = useFuture(magazinesFuture);
    AsyncSnapshot<String> magazinePictureSnapshot =
        useFuture(magazinePictureFuture);

    useEffect(() {
      if (feedSnapshot.hasError ||
          magazineSnapshot.hasError ||
          magazinePictureSnapshot.hasData) {
        userViewModel.refreshCookie();
      }
      return () {};
    }, <Object>[
      feedSnapshot.hasError,
      magazineSnapshot.hasError,
      magazinePictureSnapshot.hasData
    ]);

    return Scaffold(
      body: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: ColorName.primaryColor,
            title: Text(
              'Magazine',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: context.widthPct(0.055),
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                if (magazinePictureSnapshot.hasData)
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: magazinePictureSnapshot.data!,
                        fadeInCurve: Curves.linear,
                        errorWidget: (_, __, ___) => Assets.images.logo.svg(),
                        placeholder: (_, __) => Assets.images.logo.svg(
                          height: context.widthPct(0.1),
                          width: context.widthPct(0.1),
                        ),
                        cacheKey: magazinePictureSnapshot.data,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (magazineSnapshot.hasData)
                  DropdownButton<dynamic>(
                    enableFeedback: true,
                    alignment: Alignment.center,
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: context.widthPct(0.045),
                      fontWeight: FontWeight.w600,
                    ),
                    value: currentMagazine.value.title ??
                        magazineSnapshot.data!.first.title,
                    items: magazineSnapshot.data!
                        .where((Magazine element) => element.pid != null)
                        .map(
                          (Magazine e) => DropdownMenuItem<dynamic>(
                            alignment: Alignment.center,
                            value: e.title!,
                            onTap: () => currentMagazine.value = e,
                            child: Text(
                              e.title!,
                              style: GoogleFonts.montserrat(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (dynamic _) {},
                  ),
                if (feedSnapshot.hasData &&
                    feedSnapshot.connectionState == ConnectionState.done)
                  ...feedSnapshot.data!.eps!.map((Ep e) => GestureDetector(
                        onTap: () => router.push(
                          route.Clip(
                            mainFeedElement: e.toMainFeed(),
                          ),
                        ),
                        child: ProviderScope(
                          overrides: <Override>[
                            episodeProvider.overrideWithValue(e.toMainFeed())
                          ],
                          child: const EpisodeWidget(),
                        ),
                      )),
                if (!feedSnapshot.hasData &&
                    feedSnapshot.connectionState == ConnectionState.waiting)
                  const Center(
                    child: CircularProgressIndicator(
                      color: ColorName.primaryColor,
                    ),
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
