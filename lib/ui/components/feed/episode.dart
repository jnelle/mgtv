import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgtv/gen/assets.gen.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:sized_context/sized_context.dart';

class EpisodeWidget extends StatelessWidget {
  const EpisodeWidget({
    Key? key,
    required this.episodeDescription,
    required this.episodeName,
    required this.imageUrl,
    required this.magazineName,
  }) : super(key: key);

  final String imageUrl;
  final String episodeName;
  final String magazineName;
  final String episodeDescription;
  @override
  Widget build(BuildContext context) {
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
                  imageUrl: imageUrl,
                  fadeInCurve: Curves.linear,
                  errorWidget: (_, __, ___) => Assets.images.logo.svg(),
                  placeholder: (_, __) => Assets.images.logo.svg(
                    height: context.widthPct(0.1),
                    width: context.widthPct(0.1),
                  ),
                  cacheKey: episodeName,
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
                  magazineName,
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
                  episodeName,
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
              episodeDescription,
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
