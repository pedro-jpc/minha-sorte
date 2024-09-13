import 'package:flutter/material.dart';
import 'dart:math';

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
  List<List<int>> _combinacoes = []; // Variável para armazenar as combinações
  int _indiceCombinacaoAtual = 0;

  // Função para simular os últimos 30 concursos e gerar combinações
  void _numeros() {
    // Simulação dos últimos 30 concursos da Lotofácil
    List<List<int>> ultimosConcursos = [
      [1, 2, 3, 5, 7, 9, 10, 12, 15, 17, 18, 19, 21, 23, 25],
      [2, 3, 4, 6, 8, 11, 12, 14, 16, 17, 18, 20, 22, 24, 25],
      // ... (adicione os outros concursos aqui)
      [1, 2, 6, 8, 9, 10, 11, 13, 14, 17, 18, 19, 21, 23, 25]
    ];

    // Inicializando o mapa para contar as frequências dos números
    Map<int, int> frequencias = {};

    // Contando a frequência dos números nos concursos simulados
    for (var concurso in ultimosConcursos) {
      for (var numero in concurso) {
        frequencias[numero] = (frequencias[numero] ?? 0) + 1;
      }
    }

    // Ordenando os números pelas frequências em ordem decrescente
    List<int> numerosMaisFrequentes = frequencias.keys.toList()
      ..sort((a, b) => frequencias[b]!.compareTo(frequencias[a]!));

    // Selecionando os 15 números mais frequentes
    List<int> top15 = numerosMaisFrequentes.sublist(0, 15);

    // Gerando várias combinações aleatórias a partir dos 15 mais frequentes
    Random random = Random();
    _combinacoes = List.generate(5, (index) {
      return top15..shuffle(random);
    });

    // Reiniciar o índice da combinação
    _indiceCombinacaoAtual = 0;
  }

  // Função para avançar para a próxima combinação ou gerar combinações se ainda não existirem
  void _proximaCombinacao() {
    setState(() {
      if (_combinacoes.isEmpty) {
        _numeros(); // Gera as combinações apenas na primeira vez
      } else {
        _indiceCombinacaoAtual =
            (_indiceCombinacaoAtual + 1) % _combinacoes.length;
      }
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
                  width: 100, // Definindo a largura da imagem
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
                  _combinacoes.isNotEmpty
                      ? _combinacoes[_indiceCombinacaoAtual]
                          .join(', ') // Exibe a combinação atual
                      : 'Nenhum número sorteado ainda', // Exibe mensagem se não houver combinação
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
        onPressed: _proximaCombinacao,
        tooltip: 'Próxima combinação',
        child: const Icon(Icons.app_registration_rounded),
      ),
    );
  }
}
