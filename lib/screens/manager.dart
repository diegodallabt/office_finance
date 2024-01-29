import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:office_finances_web/auth/check_authenticate.dart';
import '../components/button_menu.dart';

class Manager extends StatefulWidget {
  const Manager({super.key});

  @override
  State<Manager> createState() => _ManagerState();
}

class _ManagerState extends State<Manager> {
  final TextEditingController _controller = TextEditingController();

  String dropdownValue = 'Escritório';

  void sendData() async {
    if (_controller.text == '' || _controller.text == 'R\$,00') {
      OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          right: 10.0,
          top: 10.0,
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Informe o valor que será adicionado ao saldo.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (context.mounted) {
        Overlay.of(context).insert(overlayEntry);
        Future.delayed(const Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      }
    } else {
      OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Positioned(
          right: 10.0,
          top: 10.0,
          child: Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Saldo alterado com sucesso.',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      if (context.mounted) {
        Overlay.of(context).insert(overlayEntry);
        Future.delayed(const Duration(seconds: 3), () {
          overlayEntry.remove();
        });
      }
      double? saldo;

      // retira o R$ e altera a virgula por ponto
      String valor = _controller.text.replaceAll('R\$', '');
      valor = valor.replaceAll(',', '.');

      // obtém o valor do saldo geral
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final DocumentSnapshot docSnapshot = await firestore
          .collection('balance')
          .doc('O5BlDfsHNGR3Jov9GqkP')
          .get();
      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;
        saldo = data['saldo'];
        saldo = saldo! + double.parse(valor);
        // atualiza o valor do saldo geral
        firestore
            .collection('balance')
            .doc('O5BlDfsHNGR3Jov9GqkP')
            .update({'saldo': saldo});
      }

      // adiciona a transação na collection transations
      FirebaseFirestore.instance.collection('transations').add({
        'data': DateTime.now(),
        'valor': double.parse(valor),
        'saldo': saldo,
        'autor': dropdownValue,
      });

      if (context.mounted) {
        Navigator.pushNamed(context, '/transations');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final text = _controller.text;
      if (!text.startsWith('R\$') && text.isNotEmpty) {
        _controller.text = 'R\$$text';
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length),
        );
      }
      if (!text.endsWith(',00') && text.length < 2 && text.isNotEmpty) {
        _controller.text = '$text,00';
        _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length - 3),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkAuthenticate(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF053D54),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const ButtonMenu(),
            SizedBox(
              height: height * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width < 700 ? width * 0.4 : width * 0.15,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(88, 0, 0, 0),
                        offset: Offset(2, 2),
                        spreadRadius: 2.0,
                        blurRadius: 5.0,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    controller: _controller,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w900,
                    ),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'Valor',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w900,
                      ),
                      contentPadding: width < 1000
                          ? const EdgeInsets.all(10)
                          : width < 1400
                              ? EdgeInsets.symmetric(vertical: height * 0.0314)
                              : width < 2000
                                  ? EdgeInsets.symmetric(
                                      vertical: height * 0.0359)
                                  : EdgeInsets.symmetric(
                                      vertical: height * 0.0382),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Container(
                  width: width < 700 ? width * 0.4 : width * 0.15,
                  height: height * 0.087,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(88, 0, 0, 0),
                        offset: Offset(2, 2),
                        spreadRadius: 2.0,
                        blurRadius: 5.0,
                      ),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: width * 0.012,
                        fontWeight: FontWeight.w900,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>[
                        'Escritório',
                        'Maricelis',
                        'Ivan',
                        'Bruno'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                            child: Text(
                              value,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            InkWell(
              onTap: () {
                sendData();
              },
              child: Container(
                width: width < 700 ? width * 0.4 : width * 0.15,
                height: height * 0.087,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(88, 0, 0, 0),
                      offset: Offset(2, 2),
                      spreadRadius: 2.0,
                      blurRadius: 5.0,
                    ),
                  ],
                  color: Color.fromARGB(255, 235, 146, 13),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                    child: Text(
                  'Alterar saldo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.012,
                    fontWeight: FontWeight.w500,
                  ),
                )),
              ),
            ),
            SizedBox(
              height: height * 0.29,
            ),
          ],
        ),
      ),
    );
  }
}
