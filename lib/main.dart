import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_page.dart';
import 'main_menu_page.dart';
import 'spreadsheet_view_page.dart';  // Импортируйте новую страницу

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control Panel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthGate(),
      routes: {
        '/mainMenu': (context) => const MainMenuPage(),
        '/spreadsheet': (context) => SpreadsheetViewPage(),  // Добавьте новый маршрут
      },
    );
  }
}

// Новый виджет, который будет проверять состояние аутентификации
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),  // Слушаем изменения состояния аутентификации
      builder: (context, snapshot) {
        // Если аутентификация еще не завершена, показываем прогресс
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Если пользователь авторизован, переходим на главный экран
        if (snapshot.hasData) {
          return const MainMenuPage();
        }

        // Если пользователь не авторизован, показываем экран логина
        return const LoginPage();
      },
    );
  }
}
