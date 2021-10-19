class Quiz {
  final List<Question> questions;

  Quiz(this.questions);
}

class Question {
  final String question;
  final List<Option> options;

  Question(this.question, this.options);
}

class Option {
  final String option;
  final int code;

  Option(this.option, this.code);
}
