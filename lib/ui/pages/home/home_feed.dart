import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/main_feed/main_feed.dart';
import 'package:mgtv/gen/assets.gen.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:mgtv/ui/user_view_model.dart';
import 'package:sized_context/sized_context.dart';

class HomeFeed extends HookConsumerWidget {
  const HomeFeed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserViewModel userViewModel = ref.read(userViewModelProvider);

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
          SliverAppBar(
            leading: const SizedBox.shrink(),
            expandedHeight: context.heightPct(0.3),
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              centerTitle: true,
              title: title.hasData
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.only(left: context.widthPct(0.0001)),
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorName.primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              '${title.data!.first}',
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decorationColor: Colors.orange,
                                fontSize: context.widthPct(0.035),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: context.widthPct(0.07), top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorName.primaryColor,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              '${title.data!.last}',
                              overflow: TextOverflow.clip,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: context.widthPct(0.035),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              background: imageUrl.hasData
                  ? CachedNetworkImage(
                      imageUrl: imageUrl.data!,
                      fadeInCurve: Curves.linear,
                      placeholder: (_, __) =>
                          const Center(child: CircularProgressIndicator()),
                      cacheKey: 'title',
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              mainFeed.hasData
                  ? <Widget>[
                      ...mainFeed.data!.map(
                        (MainFeed e) => Card(
                          margin: const EdgeInsets.all(8.0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: ColorName.primaryColor.withOpacity(0.8),
                          child: Column(
                            children: <Widget>[
                              Stack(
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
