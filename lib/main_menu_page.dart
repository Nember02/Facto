import 'package:factory_solution/google_maps_page.dart';
import 'package:factory_solution/main_group_report.dart';
import 'package:flutter/material.dart';
import 'control_page.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Заполнение всего экрана
        children: [
          // Фоновое изображение
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/main_back.jpg'), // Укажите путь к вашему изображению
                fit: BoxFit.cover, // Масштабирование изображения на весь экран
              ),
            ),
          ),
          // Полупрозрачное затемнение
          Container(
            color: Colors.black.withOpacity(0.5), // 50% затемнение
          ),
          // Содержимое страницы
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Центрируем все элементы
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Текст "SMART FACTORY"
                Center(
                  child: Text(
                    'SMART FACTORY',
                    style: TextStyle(
                      fontSize: 40, // Размер текста
                      fontWeight: FontWeight.bold, // Жирный шрифт
                      color: Colors.yellow,
                      // Цвет текста
                    ),
                  ),
                ),
                const SizedBox(height: 70), // Разделитель между текстом и кнопками
                // Кнопка "Control"
                Builder(
                  builder: (context) {
                    double screenWidth = MediaQuery.of(context).size.width;
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ControlPage()), // Переход на страницу управления
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black, // Цвет текста на кнопке
                        padding: EdgeInsets.symmetric(vertical: 15), // Убираем фиксированную ширину
                      ),
                      child: Container(
                        width: screenWidth * 0.8, // 80% от ширины экрана
                        alignment: Alignment.center,
                        child: const Text('원격제어'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                // Кнопка "Reports"
                Builder(
                  builder: (context) {
                    double screenWidth = MediaQuery.of(context).size.width;
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const MainGroupReport()), // Переход на страницу отчетов
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black, // Цвет текста на кнопке
                        padding: EdgeInsets.symmetric(vertical: 15), // Убираем фиксированную ширину
                      ),
                      child: Container(
                        width: screenWidth * 0.8, // 80% от ширины экрана
                        alignment: Alignment.center,
                        child: const Text('실적 리포트'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                // Кнопка "Map"
                Builder(
                  builder: (context) {
                    double screenWidth = MediaQuery.of(context).size.width;
                    return ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GoogleMapsPage()), // Переход на страницу с картой
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black, // Цвет текста на кнопке
                        padding: EdgeInsets.symmetric(vertical: 15), // Убираем фиксированную ширину
                      ),
                      child: Container(
                        width: screenWidth * 0.8, // 80% от ширины экрана
                        alignment: Alignment.center,
                        child: const Text('GPS'),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
