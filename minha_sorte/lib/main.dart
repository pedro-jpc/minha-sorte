import 'package:flutter/material.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minha Sorte',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 38, 126, 0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Minha Sorte'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _sorteados = []; // Variável para armazenar os números sorteados

  void _numeros() {
    setState(() {
      // Criando uma lista com os números de 1 a 25
      List<int> numeros = List.generate(25, (index) => index + 1);

      // Embaralhando os números
      numeros.shuffle();

      // Selecionando os 15 primeiros números
      _sorteados = numeros.sublist(0, 15);

      // Ordenando os números sorteados (opcional)
      _sorteados.sort();
    });
  }

  // Função para reiniciar o aplicativo
  void _reiniciarApp() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const MyApp()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'PALPITES DA LOTOFÁCIL',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    
                    color: Color.fromARGB(255, 33, 162, 37),
                  ),
                ),
                const SizedBox(height: 100),
                const SizedBox(height: 20), // Espaço entre o texto e a imagem
                Image.asset(
                  'assets/trevo.jpg',
                  width: 100,  // Definindo a largura da imagem
                  height: 100, // Definindo a altura da imagem
                ),
                const SizedBox(height: 100), // Espaço entre a imagem e o texto
                const Text(
                  'Os números sorteados são:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 33, 162, 37),
                  ),
                ),
                Text(
                  _sorteados.isNotEmpty
                      ? _sorteados.join(', ') // Exibe os números sorteados
                      : 'Nenhum número sorteado ainda',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 30,
            left: 26,
            child: ElevatedButton(
              onPressed: _reiniciarApp,
              child: const Text('Reiniciar'),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _numeros,
        tooltip: 'Sortear',
        child: const Icon(Icons.app_registration_rounded),
      ),
    );
  }
}
