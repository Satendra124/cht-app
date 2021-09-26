class Report {
  final double score;
  final List<IndexData> indexHours;
  final List<ActivityIndexDiscriptions> activityIndexDiscriptions;
  final List<Suggestion> suggestions;
  final int steps;
  final Duration sleepTime;
  final Duration screenTime;
  final DateTime dateDay;

  Report(
      this.score,
      this.indexHours,
      this.activityIndexDiscriptions,
      this.suggestions,
      this.steps,
      this.sleepTime,
      this.screenTime,
      this.dateDay);
  factory Report.fromJson(Map<String, dynamic> json) {
    List<IndexData> indexHours = [];

    /**
     * This part Converts the string to list with regex
     */
    RegExp regex = RegExp(
        r"(?:;|^)([a-zA-Z]+),([\d.]+),{'lessThan': ([\d.]+), 'greaterThan': ([\d.]+)}");
    List<RegExpMatch> ind = regex.allMatches(json['indexHours']).toList();
    for (RegExpMatch indexData in ind) {
      indexHours.add(IndexData(
          indexData.group(1),
          Duration(minutes: double.parse(indexData.group(2)).toInt()),
          Duration(minutes: double.parse(indexData.group(3)).toInt()),
          Duration(minutes: double.parse(indexData.group(4)).toInt())));
    }

    //--------------------------------------------------

    List<ActivityIndexDiscriptions> activityIndexDiscriptions = [];
    for (Map<String, dynamic> activityText
        in json['activityIndexDiscriptions']) {
      activityIndexDiscriptions
          .add(ActivityIndexDiscriptions.fromJson(activityText));
    }
    List<Suggestion> suggestions = [];
    for (Map<String, dynamic> suggestion in json['suggestions']) {
      suggestions.add(Suggestion.fromJson(suggestion));
    }
    int steps = json['steps'];
    Duration sleepTime = Duration(seconds: json['sleepTime']);
    Duration screenTime = Duration(seconds: json['screenTime']);
    DateTime dateDay = DateTime.parse(json['dateDay']);
    return Report(
      json['score'],
      indexHours,
      activityIndexDiscriptions,
      suggestions,
      steps,
      sleepTime,
      screenTime,
      dateDay,
    );
  }
}

class IndexData {
  final String name;
  final Duration duration;
  final Duration minDur;
  final Duration maxDur;
  IndexData(this.name, this.duration, this.minDur, this.maxDur);
  factory IndexData.fromJson(Map<String, dynamic> json) {
    print(json.toString());
    return IndexData(
        json['name'],
        Duration(seconds: 0),
        Duration(minutes: json['minHours'].toInt()),
        Duration(minutes: json['maxHours'].toInt()));
  }
}

class ActivityIndexDiscriptions {
  final String text;
  final IndexData index;
  ActivityIndexDiscriptions(this.text, this.index);
  factory ActivityIndexDiscriptions.fromJson(Map<String, dynamic> json) {
    return ActivityIndexDiscriptions(
      json['text'],
      IndexData.fromJson(json['index']),
    );
  }
}

class Suggestion {
  final String title;
  final String url;
  final String location;
  final IndexData index;
  final String discription;
  final String imageUrl;
  Suggestion(this.title, this.url, this.location, this.index, this.discription,
      this.imageUrl);
  factory Suggestion.fromJson(Map<String, dynamic> json) {
    print(json);
    return Suggestion(
      json['title'],
      json['link'],
      //json['location']['name'],
      "Unknown",
      IndexData.fromJson(json['index']),
      json['description'],
      json['imageUrl'],
    );
  }
}
