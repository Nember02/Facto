import 'package:flutter/material.dart'; // Это главный импорт для работы с материалами и цветами
import 'order_view_page.dart'; // Подключаем страницу для просмотра заказов
import 'report_submit_page.dart'; // Подключаем страницу для отправки отчетов

class ReportPage extends StatelessWidget {
  final String group;

  const ReportPage({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    // Выбираем фоновое изображение в зависимости от группы
    String backgroundImage = group == 'PIR' ? 'assets/images/pir_back.jpg' : 'assets/images/cg_back.jpg';

    return Scaffold(
      appBar: AppBar(
        title: Text('${group.toUpperCase()}'),
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
                image: AssetImage(backgroundImage), // Устанавливаем картинку в качестве фона
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Кнопка "물량"
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8, // 80% от ширины экрана
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderViewPage(group: group),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15), // Убираем горизонтальные отступы
                      ),
                      child: const Text('물량'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Кнопка "실적"
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8, // 80% от ширины экрана
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReportSubmitPage(group: group),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15), // Убираем горизонтальные отступы
                      ),
                      child: const Text('실적'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
