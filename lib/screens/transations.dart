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
            const ButtonMenu(),
            SizedBox(
              height: height * 0.08,
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
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('transations')
                  .orderBy('data', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("");
                }

                return SizedBox(
                  width: width * 0.5,
                  height: height * 0.5,
                  child: ListView(
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
