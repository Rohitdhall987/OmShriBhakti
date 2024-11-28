class QuizResult {
  QuizResult({
    required this.status,
    required this.message,
    required this.result,
  });
  late final String status;
  late final String message;
  late final Result result;

  QuizResult.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    result = Result.fromJson(json['result']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['message'] = message;
    _data['result'] = result.toJson();
    return _data;
  }
}

class Result {
  Result({
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.finalScore,
    required this.totalQuestions,
    required this.resultData,
    required this.uid,
  });
  late final int correctAnswers;
  late final int incorrectAnswers;
  late final int finalScore;
  late final int totalQuestions;
  late final List<ResultData> resultData;
  late final String uid;

  Result.fromJson(Map<String, dynamic> json){
    correctAnswers = json['correctAnswers'];
    incorrectAnswers = json['incorrectAnswers'];
    finalScore = json['finalScore'];
    totalQuestions = json['totalQuestions'];
    resultData = List.from(json['resultData']).map((e)=>ResultData.fromJson(e)).toList();
    uid = json['uid'].toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['correctAnswers'] = correctAnswers;
    _data['incorrectAnswers'] = incorrectAnswers;
    _data['finalScore'] = finalScore;
    _data['totalQuestions'] = totalQuestions;
    _data['resultData'] = resultData.map((e)=>e.toJson()).toList();
    _data['uid'] = uid;
    return _data;
  }
}

class ResultData {
  ResultData({
    required this.question,
    required this.submittedAnswer,
    required this.correctAnswer,
    required this.isCorrect,
  });
  late final String question;
  late final String submittedAnswer;
  late final String correctAnswer;
  late final bool isCorrect;

  ResultData.fromJson(Map<String, dynamic> json){
    question = json['question'];
    submittedAnswer = json['submitted_answer'];
    correctAnswer = json['correct_answer'];
    isCorrect = json['is_correct'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['question'] = question;
    _data['submitted_answer'] = submittedAnswer;
    _data['correct_answer'] = correctAnswer;
    _data['is_correct'] = isCorrect;
    return _data;
  }
}