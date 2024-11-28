class Quiz {
  Quiz({
    required this.message,
    required this.singleCategory,
    required this.quizQuestion,
  });
  late final String message;
  late final SingleCategory singleCategory;
  late final List<QuizQuestion> quizQuestion;

  Quiz.fromJson(Map<String, dynamic> json){
    message = json['message'];
    singleCategory = SingleCategory.fromJson(json['SingleCategory']);
    quizQuestion = List.from(json['QuizQuestion']).map((e)=>QuizQuestion.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['SingleCategory'] = singleCategory.toJson();
    _data['QuizQuestion'] = quizQuestion.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class SingleCategory {
  SingleCategory({
    required this.id,
    required this.title,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String title;
  late final String image;
  late final int status;
  late final String createdAt;
  late final String updatedAt;

  SingleCategory.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['image'] = image;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class QuizQuestion {
  QuizQuestion({
    required this.id,
    required this.question,
    required this.opt_1,
    required this.opt_2,
    required this.opt_3,
    required this.opt_4,
    required this.categoryId,
  });
  late final int id;
  late final String question;
  late final String opt_1;
  late final String opt_2;
  late final String opt_3;
  late final String opt_4;
  late final int categoryId;

  QuizQuestion.fromJson(Map<String, dynamic> json){
    id = json['id'];
    question = json['question'];
    opt_1 = json['opt_1'];
    opt_2 = json['opt_2'];
    opt_3 = json['opt_3'];
    opt_4 = json['opt_4'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['question'] = question;
    _data['opt_1'] = opt_1;
    _data['opt_2'] = opt_2;
    _data['opt_3'] = opt_3;
    _data['opt_4'] = opt_4;
    _data['category_id'] = categoryId;
    return _data;
  }
}