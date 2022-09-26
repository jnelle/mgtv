import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/data/models/get_clip/file.dart';
import 'package:mgtv/data/models/get_clip/get_clip.dart';
import 'package:mgtv/data/models/main_feed/main_feed.dart';
import 'package:mgtv/foundation/extension/asyncsnapshot.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:mgtv/ui/components/video_player/video_player.dart';
import 'package:mgtv/ui/hooks/use_router.dart';
import 'package:mgtv/ui/user_view_model.dart';
import 'package:sized_context/sized_context.dart';

class ClipPage extends HookConsumerWidget {
  const ClipPage({
    Key? key,
    required this.mainFeedElement,
  }) : super(key: key);

  final MainFeed mainFeedElement;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserViewModel userViewModel = ref.read(userViewModelProvider);

    Future<GetClip> clipDetails = useMemoized(
      () => userViewModel.getClip(
        identifier: mainFeedElement.identifier!,
        cookie: userViewModel.cookie,
        action: 'getClip',
      ),
    );
    StackRouter router = useRouter();
    AsyncSnapshot<GetClip> clipDetailsSnapshot = useFuture(clipDetails);

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                  onPressed: () => router.pop(),
                  icon: const Icon(Icons.arrow_back_ios_new)),
              backgroundColor: ColorName.primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  '${mainFeedElement.pdesc}',
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: context.widthPct(0.06)),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: clipDetailsSnapshot.present(
                context: context,
                onData: (BuildContext context, GetClip data) {
                  Map<String, String> tmpMap = <String, String>{};
                  for (File element in data.files!) {
                    if (!element.desc!.contains('Audio')) {
                      tmpMap[element.desc!] = 'https:${element.url!}';
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: VideoWidget(
                        resolutions: tmpMap,
                        videoUrl: 'https:${data.files!.first.url!}',
                        cookie: userViewModel.cookie,
                        imageUrl: data.img!,
                        videoName: data.pdesc!,
                      ),
                    ),
                  );
                },
              ),
            ),
            SliverToBoxAdapter(
              child: clipDetailsSnapshot.present(
                context: context,
                onData: (BuildContext context, GetClip data) => Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          child: Text(
                            '${data.title}',
                            style: GoogleFonts.montserrat(
                              color: ColorName.black,
                              fontSize: context.widthPct(0.075),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${data.desc}',
                          style: GoogleFonts.montserrat(
                            fontSize: context.widthPct(0.045),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
