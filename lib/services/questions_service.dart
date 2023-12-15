import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart' show rootBundle;
import 'package:myapp/model/questions_model.dart';

class QuestionService{
  Future<List<Question>> fetchQuestions(String filePath) async {
    final String jsonStr = await rootBundle.loadString(filePath);

    List<dynamic> jsonData = json.decode(jsonStr);

    List<Question> questions = jsonData.map((data) => Question.fromJson(data)).toList();

    return questions;
  }

  Future<Question> getRandomQuestion(String filePath) async{
    final List<Question> questions = await fetchQuestions(filePath);
    final int randomIndex = Random().nextInt(questions.length);
    return questions[randomIndex];
  }

}