import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:sized_context/sized_context.dart';

SliverAppBar homeAppBar({
  required AsyncSnapshot<List<String?>> title,
  required AsyncSnapshot<String> imageUrl,
}) {
  BuildContext context = useContext();
  return SliverAppBar(
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
                  padding: EdgeInsets.only(left: context.widthPct(0.0001)),
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
                  padding:
                      EdgeInsets.only(left: context.widthPct(0.07), top: 10),
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
  );
}
