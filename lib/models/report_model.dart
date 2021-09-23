class Report {
  final DateTime from;
  final DateTime to;
  final int steps;
  final Duration sleepTime;
  final List<MoodInfo> moods;
  final List<ScreenTime> screentime;
  final List<double> amplitudes;
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

class MoodInfo {
  final Mood mood;
  final int count;

  MoodInfo(this.mood, this.count);
}

enum Mood { happy, calm, angry, scared, sad }

class ScreenTime {
  final String appName;
  final String appImageUrl;
  final Duration usageDuration;

  ScreenTime(this.appName, this.appImageUrl, this.usageDuration);
}

class LocationInfo {
  final String name;
  final String imageUrl;
  final Duration duration;

  LocationInfo(this.name, this.imageUrl, this.duration);
}
