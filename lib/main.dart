import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController controller = TextEditingController();

  String resultado = "";
  String tipoEntrega = 'Regular';
  bool aceitarPromocoes = false;
  double currentSliderValue = 0;
  String? regiaoEscolhida;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Olá Flutter'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Preencha com o nome do Produto:',
              style: TextStyle(color: Colors.black87),
            ),
            
            const SizedBox(height: 5),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.account_box_outlined),
              ),
            ),

            const SizedBox(height: 15),
            Text('Defina Quantidade: ${currentSliderValue.toInt()}',
              style: const TextStyle(color: Colors.black87),
            ),
            Slider(
              value: currentSliderValue,
              max: 100,
              min: 0,
              label: currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  currentSliderValue = value;
                });
              },
            ),
            
            const SizedBox(height: 15),
            const Text(
              'Escolha o tipo de Entrega:',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                RadioListTile<String>(
                  title: const Text("Carreto"),
                  value: 'Carreto',
                  groupValue: tipoEntrega,
                  onChanged: (v) => setState(() => tipoEntrega = v!),
                ),
                RadioListTile<String>(
                  title: const Text("Retirada"),
                  value: 'Retirada',
                  groupValue: tipoEntrega,
                  onChanged: (v) => setState(() => tipoEntrega = v!),
                ),
                RadioListTile<String>(
                  title: const Text("Correio"),
                  value: 'Correio',
                  groupValue: tipoEntrega,
                  onChanged: (v) => setState(() => tipoEntrega = v!),
                ),
              ],
            ),
            
            const SizedBox(height: 15),
            const Text('Escolha a Região:'),
            Center(
              child: SizedBox(
                width: 200,
                child: DropdownButtonFormField<String>(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  hint: const Text("Selecione"),
                  isExpanded: true,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  ),
                  items: ['Norte', 'Leste', 'Sul', 'Oeste']
                      .map((String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                  onChanged: (novoValor) {
                    setState(() {
                      regiaoEscolhida = novoValor;
                    });
                  },
                ),
              ),
            ),
            
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: aceitarPromocoes,
                  onChanged: (bool? valor) {
                    setState(() {
                      aceitarPromocoes = valor ?? false;
                    });
                  },
                ),
                const Flexible(
                  child: Text("Sim, eu desejo receber promoções via e-mail."),
                ),
              ],
            ),
            
            const SizedBox(height: 15),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 115, 141, 158),
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    resultado = controller.text;
                    controller.clear();
                  });
                },
                child: const Text('Cadastrar'),
              ),
            ),
            
            const SizedBox(height: 20),
            if (resultado.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 249, 231, 255),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  'O produto selecionado foi: $resultado, mas a quantidade de produtos escolhida foi ${currentSliderValue.toInt()}.'
                  'O pedido será entregue via $tipoEntrega. Já a região de entrega será ${regiaoEscolhida ?? "região não informada"}.'
                  'O cliente aceita envio de promoções: ${aceitarPromocoes ? "Aceito":"Não Aceito"}.',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}