// ignore: implementation_imports
import 'package:auto_route/src/router/controller/routing_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/main_feed/main_feed.dart';
import 'package:mgtv/gen/assets.gen.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:mgtv/ui/components/appbar/home_appbar.dart';
import 'package:mgtv/ui/hook/use_router.dart';
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
                        (MainFeed e) => Card(
                          elevation: 3.0,
                          margin: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: ColorName.primaryColor.withOpacity(0.8),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () =>
                                    router.push(Clip(mainFeedElement: e)),
                                child: Stack(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: e.img!,
                                        fadeInCurve: Curves.linear,
                                        errorWidget: (_, __, ___) =>
                                            Assets.images.logo.svg(),
                                        placeholder: (_, __) =>
                                            Assets.images.logo.svg(
                                          height: context.widthPct(0.1),
                                          width: context.widthPct(0.1),
                                        ),
                                        cacheKey: e.title,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 100),
                                      child: Center(
                                          child: CircleAvatar(
                                        backgroundColor:
                                            ColorName.primaryColor.shade300,
                                        minRadius: 10,
                                        child: Icon(
                                          Icons.play_arrow_outlined,
                                          size: context.widthPct(0.15),
                                          color: ColorName.white,
                                        ),
                                      )),
                                    )
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    child: Text(
                                      e.pdesc!,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: context.widthPct(0.045),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    child: Text(
                                      e.title!,
                                      style: GoogleFonts.montserrat(
                                        color: Colors.black,
                                        fontSize: context.widthPct(0.04),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  e.desc!,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: context.widthPct(0.0375),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
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
