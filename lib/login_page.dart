import 'package:flutter/material.dart';
import 'main_menu_page.dart'; // Экран основного меню

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Контроллеры для текстовых полей
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Заполнение всего экрана
        children: [
          // Фоновое изображение
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/main_back.jpg'), // Путь к вашему изображению
                fit: BoxFit.cover, // Масштабирование изображения на весь экран
              ),
            ),
          ),
          // Полупрозрачное затемнение
          Container(
            color: Colors.black.withOpacity(0.5), // 50% затемнение
          ),
          // Содержимое страницы
          Scaffold(
            backgroundColor: Colors.transparent, // Сделать фон Scaffold прозрачным
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Icon(
                        Icons.account_circle,
                        size: 100,
                        color: Colors.orange, // Цвет иконки
                      ),
                      const SizedBox(height: 20),
                      // Текстовое поле для имени пользователя
                      TextField(
                        controller: usernameController,
                        style: const TextStyle(color: Colors.white), // Цвет текста
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle: const TextStyle(color: Colors.orange), // Цвет текста метки
                          hintText: 'Enter your username',
                          hintStyle: const TextStyle(color: Colors.grey), // Цвет подсказки
                          filled: true,
                          fillColor: Colors.grey[800], // Цвет фона текстового поля
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.person, color: Colors.orange),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Текстовое поле для пароля
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.orange),
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[800],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: const Icon(Icons.lock, color: Colors.orange),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Кнопка входа
                      ElevatedButton(
                        onPressed: () {
                          if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const MainMenuPage()),
                            );
                          } else {
                            // Простая проверка на пустые поля
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Please enter both username and password')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white, // Цвет кнопки
                          padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 50.0),
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
