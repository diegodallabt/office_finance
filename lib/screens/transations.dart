// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../auth/check_authenticate.dart';
import '../components/button_menu.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime? initialDate;
  DateTime? finalDate;
  bool isVisible = false;
  bool isFiltering = false;
  String? pickedDate_initial;
  String? pickedDate_final;
  String dropdownValue = 'Escritório';

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
          children: [
            SizedBox(
              height: height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isVisible
                    ? FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('balance')
                            .doc('O5BlDfsHNGR3Jov9GqkP')
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Erro: ${snapshot.error}");
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data =
                                snapshot.data!.data() as Map<String, dynamic>;
                            return Text(
                              'R\$ ${data['saldo'].toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.015,
                                fontWeight: FontWeight.w900,
                              ),
                            );
                          }

                          return const Text("");
                        },
                      )
                    : Text('********',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.015,
                            fontWeight: FontWeight.w900)),
                SizedBox(
                  width: width * 0.01,
                ),
                InkWell(
                    onTap: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    child: isVisible
                        ? const Icon(Icons.visibility_off, color: Colors.white)
                        : const Icon(Icons.visibility, color: Colors.white)),
              ],
            ),
            SizedBox(
              height: height * 0.04,
            ),
            const ButtonMenu(),
            SizedBox(
              height: height * 0.04,
            ),
            SizedBox(
              width: width * 0.43,
              child: const Row(
                children: [
                  Text('Filtros', style: TextStyle(color: Colors.white)),
                  Spacer(),
                  Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    String? dataFormatada;
                    DateTime? picked = await showDatePicker(
                      locale: const Locale('pt', 'BR'),
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null) {
                      initialDate = DateTime(
                          picked.year, picked.month, picked.day, 23, 59);
                      dataFormatada =
                          DateFormat('dd/MM/yyyy').format(picked).toString();
                    }
                    setState(() {
                      pickedDate_initial = dataFormatada;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.01,
                      vertical: width * 0.004,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.005),
                      color: const Color.fromARGB(255, 5, 94, 129),
                    ),
                    child: Row(
                      children: [
                        Text(
                          pickedDate_initial != null
                              ? pickedDate_initial!
                              : 'Data inicial',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.012,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        const Icon(Icons.edit_calendar, color: Colors.white)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                InkWell(
                  onTap: () async {
                    String? dataFormatada;
                    DateTime? picked = await showDatePicker(
                      locale: const Locale('pt', 'BR'),
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2025),
                    );
                    if (picked != null) {
                      finalDate = DateTime(
                          picked.year, picked.month, picked.day, 23, 59);
                      dataFormatada =
                          DateFormat('dd/MM/yyyy').format(picked).toString();
                    }
                    setState(() {
                      pickedDate_final = dataFormatada;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.01,
                      vertical: width * 0.004,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.005),
                      color: const Color.fromARGB(255, 5, 94, 129),
                    ),
                    child: Row(
                      children: [
                        Text(
                          pickedDate_final != null
                              ? pickedDate_final!
                              : 'Data final',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.012,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.01,
                        ),
                        const Icon(Icons.edit_calendar, color: Colors.white)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Container(
                  width: width < 700 ? width * 0.4 : width * 0.15,
                  height: width < 700 ? height * 0.05 : height * 0.05,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 5, 94, 129),
                    borderRadius: BorderRadius.circular(width * 0.005),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: const Color.fromARGB(255, 5, 94,
                          129), // Altera a cor de fundo do DropdownButton
                      textTheme: const TextTheme(
                        titleMedium: TextStyle(
                            color: Colors.white), // Altera a cor do texto
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.012,
                          fontWeight: FontWeight.w100,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            isFiltering = true;
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
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                // faça um quadrado com fundo vermelho da altura do dropdown
                InkWell(
                  onTap: () {
                    setState(() {
                      isFiltering = false;
                      pickedDate_initial = null;
                      pickedDate_final = null;
                      initialDate = null;
                      finalDate = null;
                      dropdownValue = 'Escritório';
                    });
                  },
                  child: Container(
                      width: height * 0.05,
                      height: height * 0.05,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 236, 44, 44),
                        borderRadius: BorderRadius.circular(width * 0.005),
                      ),
                      child: const Icon(
                        Icons.delete_sweep,
                        color: Colors.white,
                      )),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Container(
              width: width * 0.5,
              padding: EdgeInsets.all(width * 0.01),
              decoration: BoxDecoration(
                // borda embaixo
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: width * 0.001,
                  ),
                ),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: width * 0.1,
                      child: Text(
                        'Data',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.014,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.1,
                      child: Text(
                        'Responsável',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.014,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.1,
                      child: Text(
                        'Valor',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.014,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.1,
                      child: Text(
                        'Saldo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.014,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            SizedBox(
              width: width * 0.5,
              height: height * 0.5,
              child: StreamBuilder<QuerySnapshot>(
                stream: initialDate != null && finalDate != null && !isFiltering
                    ? FirebaseFirestore.instance
                        .collection('transations')
                        .where('data', isGreaterThanOrEqualTo: initialDate)
                        .where('data', isLessThanOrEqualTo: finalDate)
                        .orderBy('data', descending: true)
                        .snapshots()
                    : isFiltering && initialDate == null && finalDate == null
                        ? FirebaseFirestore.instance
                            .collection('transations')
                            .where('autor', isEqualTo: dropdownValue)
                            .orderBy('data', descending: true)
                            .snapshots()
                        : isFiltering
                            ? FirebaseFirestore.instance
                                .collection('transations')
                                .where('autor', isEqualTo: dropdownValue)
                                .where('data',
                                    isGreaterThanOrEqualTo: initialDate)
                                .where('data', isLessThanOrEqualTo: finalDate)
                                .orderBy('data', descending: true)
                                .snapshots()
                            : FirebaseFirestore.instance
                                .collection('transations')
                                .orderBy('data', descending: true)
                                .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("");
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      String dataFormatada = DateFormat('dd/MM/yyyy')
                          .format(data['data'].toDate())
                          .toString();

                      return Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.01),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: const Color.fromARGB(255, 9, 135, 185),
                              width: MediaQuery.of(context).size.width * 0.0001,
                            ),
                          ),
                        ),
                        child: Row(children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              dataFormatada,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 9, 135, 185),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.014,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              data['autor'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 9, 135, 185),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.014,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              'R\$ ${data['valor']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: data['valor'] > 0
                                    ? const Color.fromARGB(255, 13, 199, 96)
                                    : const Color.fromARGB(255, 236, 44, 44),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.014,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Text(
                              'R\$ ${data['saldo']}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 9, 135, 185),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.014,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ]),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
