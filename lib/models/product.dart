class Product {
  final String question;
  final List<String> answers;
  final int correct;

  Product({
    required this.question,
    required this.answers,
    required this.correct,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      question: json['question'] as String,
      answers: List<String>.from(json['answers']),
      correct: json['correct'] as int,
    );
  }
}
