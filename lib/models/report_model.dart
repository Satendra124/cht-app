class Report {
  final DateTime from;
  final DateTime to;
  final int steps;
  final Duration sleepTime;
  final Map<Mood, int> moods;
  final List<ScreenTime> screentime;
  final List<int> amplitudes;
  final List<LocationInfo> locations;

  Report(
      {this.from,
      this.to,
      this.steps,
      this.sleepTime,
      this.moods,
      this.screentime,
      this.amplitudes,
      this.locations});
}

enum Mood { happy, calm, angry, scared, sad }

class ScreenTime {
  final String appName;
  final String appImageUrl;
  final Duration usageDuration;
  final double usageratio;

  ScreenTime(
      this.appName, this.appImageUrl, this.usageDuration, this.usageratio);
}

class LocationInfo {
  final String name;
  final String imageUrl;
  final Duration duration;
  final double ratioTime;

  LocationInfo(this.name, this.imageUrl, this.duration, this.ratioTime);
}
