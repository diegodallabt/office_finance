import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CreatePdf extends StatelessWidget {
  final pdf = pw.Document();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _buildPdf(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(); // Retorne aqui o seu widget
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<void> _buildPdf() async {
    final data = [
      {
        "data": "01/01/2024",
        "responsável": "João",
        "valor": "R\$100,00",
        "saldo": "R\$900,00"
      },
      {
        "data": "02/01/2024",
        "responsável": "Maria",
        "valor": "R\$200,00",
        "saldo": "R\$700,00"
      },
      // Adicione mais dados aqui
    ];

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Table.fromTextArray(
            context: context,
            data: <List<String>>[
              <String>["Data", "Responsável", "Valor", "Saldo"],
              ...data.map((item) => [
                    item["data"]!,
                    item["responsável"]!,
                    item["valor"]!,
                    item["saldo"]!
                  ])
            ],
          ),
        ],
      ),
    );

    final output = await pdf.save();

    final directory = await getTemporaryDirectory();
    final file = File('${directory.path}/relatório.pdf');
    await file.writeAsBytes(output);
  }
}
