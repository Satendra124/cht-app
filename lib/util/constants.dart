import 'package:cht/models/quiz.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class Constants {
  static bool IS_TRACKING = false;
  static const dynamic ISOLATE_NAME = 'LocatorIsolate';
  static UserData currentUser;
  static bool TEST_MODE = true;
}

class SuggestionModel {
  String text;
  String imageUrl;
  String knowMoreUrl;
  SuggestionModel(
      {@required this.text,
      @required this.imageUrl,
      @required this.knowMoreUrl});
}

Quiz quiz = new Quiz([
  new Question(
      "Stress refers to a situation where a person feels tense, restless, nervous, or anxious, or is unable to sleep at night because his/her mind is troubled all the time. Do you feel that kind of stress these days?",
      [
        new Option("Not at all", 1),
        new Option("Only a little", 2),
        new Option("To some extent", 3),
        new Option("Rather much", 4),
        new Option("Very much", 5),
      ]),
  new Question("In general, how satisfied are you with how today went?", [
    new Option("Very Satisfied", 1),
    new Option("Somewhat Satisfied", 2),
    new Option("Somewhat Dissatisfied", 3),
    new Option("Very Dissatisfied", 4),
  ]),
  new Question("How Productive Was today?", [
    new Option("Very Productive", 1),
    new Option("Somewhat Productive", 2),
    new Option("Somewhat unproductive", 3),
    new Option("Very unproductive", 4),
  ]),
  new Question("How Active Were You today? (physically / Mentally)", [
    new Option("Very active", 1),
    new Option("Somewhat active", 2),
    new Option("Somewhat inactive", 3),
    new Option("Not at all active", 4),
  ]),
  new Question("How tired are you right now", [
    new Option("Very Energetic", 1),
    new Option("Little Energetic", 2),
    new Option("Little Tired", 3),
    new Option("Very Tired", 4),
  ]),
]);
