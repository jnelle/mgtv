import 'package:mgtv/data/models/get_feed/ep.dart';
import 'package:mgtv/data/models/main_feed/main_feed.dart';

extension EpisodeToMainFeed on Ep {
  MainFeed toMainFeed() => MainFeed(
        identifier: identifier,
        pid: pid,
        img: img,
        desc: desc,
        duration: duration,
        contentType: contentType,
        date: date,
        episodeNumber: episodeNumber,
        pdesc: pdesc,
        subscribed: canAccess,
        teaserFile: teaserFile,
        thumbnail: thumbnail,
        title: title,
      );
}
