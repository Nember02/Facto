import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CraneControlPage extends StatelessWidget {
  final String raspberryPiIP = '172.30.1.76';

  const CraneControlPage({super.key});

  Future<void> _sendCommand(String command) async {
    try {
      final response = await http.post(
        Uri.parse('http://$raspberryPiIP:5000/crane_control'),
        body: {'command': command}
      );
      
      if (response.statusCode == 200) {
        print('Команда $command отправлена успешно');
      } else {
        print('Не удалось отправить команду $command');
      }
    } catch (e) {
      print('Ошибка при отправке команды: $e');
    }
  }

  Future<void> _resetServos() async {
    try {
      final response = await http.post(
        Uri.parse('http://$raspberryPiIP:5000/crane_control'),
        body: {'command': 'reset'}
      );
      
      if (response.statusCode == 200) {
        print('Все сервоприводы сброшены');
      } else {
        print('Не удалось сбросить сервоприводы');
      }
    } catch (e) {
      print('Ошибка при сбросе сервоприводов: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('호이스트 크래인'),
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetServos,
            tooltip: 'Сбросить сервоприводы',
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/hoist_back.jpg'), // Путь к изображению
            fit: BoxFit.cover, // Масштабирование изображения на весь экран
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            // Контролы для вертикального управления (верх/низ) сверху
            Positioned(
              top: -50, // Отступ от верхней части экрана
              left: 0,
              right: 0,
              child: _buildVerticalControlPad(),
            ),
            // Контролы для горизонтального управления (стороны света) снизу
            Positioned(
              bottom: -50, // Отступ от нижней части экрана
              left: 0,
              right: 0,
              child: _buildHorizontalControlPad(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVerticalControlPad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildControlButton('위', 'up'),
            const SizedBox(width: 16),
            _buildControlButton('아래', 'down'),
          ],
        ),
      ],
    );
  }

  Widget _buildHorizontalControlPad() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      _buildControlButton('서', 'west'),
      // Уменьшаем размер SizedBox или убираем его
      const SizedBox(width: 1), // Меньше расстояние между кнопками
      Column(
        children: [
          _buildControlButton('북', 'north'),
          _buildControlButton('남', 'south'),
        ],
      ),
      // Уменьшаем размер SizedBox или убираем его
      const SizedBox(width: 1), // Меньше расстояние между кнопками
      _buildControlButton('동', 'east'),
    ],
  );
}

  Widget _buildControlButton(String label, String command) {
    return GestureDetector(
      onTapDown: (_) => _sendCommand(command),
      onTapUp: (_) => _resetServos(),
      onTapCancel: () => _resetServos(),
      child: Container(
        margin: const EdgeInsets.all(8),
        width: 100, // Увеличиваем размер кнопки
        height: 200, // Увеличиваем размер кнопки
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
            )
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 48), // Увеличиваем шрифт
          ),
        ),
      ),
    );
  }
}
