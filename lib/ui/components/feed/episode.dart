import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/main_feed/main_feed.dart';
import 'package:mgtv/data/provider/episode_provider.dart';
import 'package:mgtv/gen/assets.gen.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:sized_context/sized_context.dart';

class EpisodeWidget extends ConsumerWidget {
  const EpisodeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainFeed episode = ref.watch(episodeProvider);
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: ColorName.primaryColor.withOpacity(0.8),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: '${episode.img}',
                  fadeInCurve: Curves.linear,
                  errorWidget: (_, __, ___) => Assets.images.logo.svg(),
                  placeholder: (_, __) => Assets.images.logo.svg(
                    height: context.widthPct(0.1),
                    width: context.widthPct(0.1),
                  ),
                  cacheKey: '${episode.episodeNumber}',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Center(
                    child: CircleAvatar(
                  backgroundColor: ColorName.primaryColor.shade300,
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
                  '${episode.pdesc}',
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
                  '${episode.title}',
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
              '${episode.desc}',
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: context.widthPct(0.0375),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
