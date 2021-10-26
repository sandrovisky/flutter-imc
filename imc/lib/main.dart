import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados!";

  void _resetField() {
    setState(() {
      _infoText = "Informe seus dados!";
      _formkey = GlobalKey<FormState>();
    });
    weightController.text = "";
    heightController.text = "";
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(2)})";
      } else if (imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(2)})";
      } else if (imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(2)})";
      } else if (imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(2)})";
      } else if (imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(2)})";
      } else {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(2)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CALCULADORA IMC",
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.lightGreen.shade300,
        actions: [
          IconButton(
              onPressed: _resetField,
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Form(
            key: _formkey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(Icons.person_outline_rounded, size: 150),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Peso (kg)"),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                    controller: weightController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Altura (cm)"),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                    textAlign: TextAlign.center,
                    controller: heightController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Insira sua Altura!";
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.lightGreen.shade300)),
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _calculate();
                            }
                          },
                          child: const Text(
                            "CALCULAR",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                  Text(
                    _infoText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  )
                ]),
          )),
    );
  }
}
