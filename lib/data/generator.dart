import 'dart:math';

import 'package:cht/models/report_model.dart';

class Generator {
  String placeholderImageUrl = "https://via.placeholder.com/";
  Random random = new Random();
  Future<Report> generateReport(DateTime to, DateTime from) async {
    List<int> randamp = [];
    for (var i = 0; i < 288; i++) {
      randamp.add(random.nextInt(128));
    }
    List<LocationInfo> locs = [];
    for (var i = 0; i < 4; i++) {
      locs.add(new LocationInfo(
          "location-" + random.nextInt(100).toString(),
          placeholderImageUrl + "50",
          Duration(
            seconds: random.nextInt(10000),
          ),
          random.nextDouble()));
    }
    Map<Mood, int> moods = {
      Mood.happy: random.nextInt(10),
      Mood.angry: random.nextInt(10),
      Mood.calm: random.nextInt(10),
      Mood.sad: random.nextInt(10),
      Mood.scared: random.nextInt(10),
    };
    List<ScreenTime> sctime = [];
    for (var i = 0; i < 3; i++) {
      sctime.add(
        ScreenTime(
          "app-" + random.nextInt(10).toString(),
          placeholderImageUrl + "50",
          Duration(
            seconds: random.nextInt(10000),
          ),
          random.nextDouble(),
        ),
      );
    }

    return Future.delayed(
        Duration(seconds: 2),
        () => new Report(
              from: from,
              to: to,
              amplitudes: randamp,
              locations: locs,
              moods: moods,
              steps: random.nextInt(10000),
              sleepTime: Duration(
                  hours: random.nextInt(12), minutes: random.nextInt(60)),
              screentime: sctime,
            ));
  }
}
