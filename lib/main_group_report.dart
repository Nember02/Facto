import 'package:flutter/material.dart';
import 'report_page.dart';

// Основное меню для выбора группы (PIR или CG)
class MainGroupReport extends StatelessWidget {
  const MainGroupReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('품목'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      body: Stack(
        fit: StackFit.expand, // Заполняет весь экран
        children: [
          // Фоновое изображение
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/main_back.jpg'), // Устанавливаем картинку в качестве фона
                fit: BoxFit.cover, // Чтобы картинка растягивалась на весь экран
              ),
            ),
          ),
          // Полупрозрачное затемнение
          Container(
            color: Colors.black.withOpacity(0.5), // 50% затемнение
          ),
          // Содержимое страницы
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Кнопка PIR
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8, // 80% от ширины экрана
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportPage(group: 'PIR'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15), // Убираем горизонтальные отступы
                    ),
                    child: const Text('PIR'),
                  ),
                ),
                const SizedBox(height: 20),
                // Кнопка CG
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8, // 80% от ширины экрана
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReportPage(group: 'CG'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15), // Убираем горизонтальные отступы
                    ),
                    child: const Text('CG'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[850],
    );
  }
}
