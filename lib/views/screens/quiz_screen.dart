import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app_with_animation/controllers/product_controller.dart';
import 'package:quiz_app_with_animation/models/product.dart';
import 'package:quiz_app_with_animation/views/widgets/pageviewbuilder_widget.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final PageController pageController = PageController();

  void _nextQuestion() {
    pageController.nextPage(
        duration: const Duration(seconds: 3), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ProductController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Colors.deepPurple.shade300,
      body: SafeArea(
        child: StreamBuilder(
          stream: controller.list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("Mahsulotlar mavjud emas"),
              );
            }
            final products = snapshot.data!.docs;

            return PageView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: products.length,
              controller: pageController,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final productData =
                    products[index].data() as Map<String, dynamic>;
                final product = Product.fromJson(productData);
                return PageviewBuilder(
                  answers: product.answers,
                  question: product.question,
                  index: index,
                  correct: product.correct,
                  nextQuestion: _nextQuestion,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
