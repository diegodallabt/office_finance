import 'package:flutter/material.dart';

class ButtonMenu extends StatelessWidget {
  const ButtonMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(width * 0.01),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width * 0.005),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/transations');
            },
            child: Row(children: [
              Text(
                'Transações',
                style: TextStyle(
                  color: const Color(0xFF053D54),
                  fontSize: width * 0.014,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                width: width * 0.02,
              ),
              const Icon(
                Icons.transfer_within_a_station,
                color: Color(0xFF053D54),
              ),
            ]),
          ),
        ),
        SizedBox(
          width: width * 0.02,
        ),
        InkWell(
          onTap: () {
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
                          'Essa opção está indisponível no momento.',
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
          },
          child: Container(
            padding: EdgeInsets.all(width * 0.01),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(width * 0.005),
            ),
            child: Row(children: [
              Text(
                'Extrato',
                style: TextStyle(
                  color: const Color(0xFF053D54),
                  fontSize: width * 0.014,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                width: width * 0.02,
              ),
              const Icon(
                Icons.balance,
                color: Color(0xFF053D54),
              ),
            ]),
          ),
        ),
        SizedBox(
          width: width * 0.02,
        ),
        Container(
          padding: EdgeInsets.all(width * 0.01),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(width * 0.005),
          ),
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, '/manager');
            },
            child: Row(children: [
              Text(
                'Gerenciar saldo',
                style: TextStyle(
                  color: const Color(0xFF053D54),
                  fontSize: width * 0.014,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                width: width * 0.02,
              ),
              const Icon(
                Icons.money,
                color: Color(0xFF053D54),
              ),
            ]),
          ),
        ),
        SizedBox(
          width: width * 0.02,
        ),
      ],
    );
  }
}
