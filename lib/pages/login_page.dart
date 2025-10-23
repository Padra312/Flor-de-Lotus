import 'package:flutter/material.dart';

// Definição das cores para manter a consistência com o estilo Flor de Lótus
const Color primaryColor = Color(0xFF333333); // Preto/Cinza Escuro para o AppBar/Header
const Color accentColor = Color(0xFFFDD835); // Amarelo/Dourado para o Lótus e botões

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flor de Lótus Login',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'Roboto',
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 60, bottom: 40, left: 20, right: 20),
              width: double.infinity,
              color:  Color(0xFF1C1C1C),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo2.png', 
                    height: 80.0,
                    width: 80.0,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Flor de Lótus',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Acesse sua conta',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Bem-vindo(a) de volta',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),

                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                      labelStyle: TextStyle(color: primaryColor),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: accentColor, width: 2.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),

                  // Campo de Senha
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(color: primaryColor),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(196, 164, 132, 1), width: 2.0),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        print('Botão Entrar pressionado');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(196, 164, 132, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'ENTRAR',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        print('Esqueceu a senha?');
                      },
                      child: const Text(
                        'Esqueceu a senha?',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  Center(
                    child: OutlinedButton(
                      onPressed: () {
                        print('Criar nova conta');
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: primaryColor, width: 1),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'CRIAR NOVA CONTA',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}