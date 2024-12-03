import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'crane_control_page.dart'; // Подключение страницы управления краном
import 'light_control_page.dart'; // Подключение страницы управления светом
import 'lane_control_page.dart'; // Подключение страницы управления линией

class ControlPage extends StatelessWidget {
  const ControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('원격제어'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
      ),
      body: Stack(
        fit: StackFit.expand, // Чтобы элементы Stack заполнили весь экран
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              children: <Widget>[
                // Кнопка для управления краном
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.orange, // Оранжевый цвет для кнопок
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CraneControlPage()), // Переход на страницу управления краном
                    );
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.precision_manufacturing, size: 50, color: Colors.white),
                      SizedBox(height: 8),
                      Text('크레인', style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                // Кнопка для управления светом
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.orange, // Оранжевый цвет для кнопок
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LightControlPage()), // Переход на страницу управления светом
                    );
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lightbulb, size: 50, color: Colors.white),
                      SizedBox(height: 8),
                      Text('조명', style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                // Кнопка для управления конвейером
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.orange, // Оранжевый цвет для кнопок
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LaneControlPage()), // Переход на страницу управления линией
                    );
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.conveyor_belt, size: 50, color: Colors.white),
                      SizedBox(height: 8),
                      Text('컨베이어', style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                // Кнопка для управления дверью
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    backgroundColor: Colors.orange, // Оранжевый цвет для кнопок
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    LaunchApp.openApp(
                      androidPackageName: 'com.okampro.oksmart',
                    );
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, size: 50, color: Colors.white),
                      SizedBox(height: 8),
                      Text('카매라', style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
