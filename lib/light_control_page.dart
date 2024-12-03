import 'package:flutter/material.dart';

class LightControlPage extends StatefulWidget {
  const LightControlPage({super.key});

  @override
  _LightControlPageState createState() => _LightControlPageState();
}

class _LightControlPageState extends State<LightControlPage> {
  bool isLightOn = false; // Статус света (вкл/выкл)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('조명'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white, // Цвет фона для AppBar
      ),
      body: Stack(
        fit: StackFit.expand, // Заполнение всего экрана
        children: [
          // Фоновое изображение
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/lamp_back.jpg'), // Путь к изображению
                fit: BoxFit.cover, // Масштабирование изображения на весь экран
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
                // Подпись
                Text(
                  isLightOn ? '켜짐' : '꺼짐',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                // Переключатель
                Switch(
                  value: isLightOn,
                  onChanged: (value) {
                    setState(() {
                      isLightOn = value;
                    });
                  },
                  activeColor: Colors.yellow,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey[700],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
