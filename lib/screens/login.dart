import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController password = TextEditingController();
    final FirebaseAuth auth = FirebaseAuth.instance;

    Future<void> signIn(String password, BuildContext context) async {
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: 'ddb.thedoldi@gmail.com',
          password: password,
        );
        User? user = userCredential.user;

        // Se a autenticação for bem-sucedida, navegue para a página inicial
        if (user != null) {
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
                    color: const Color.fromARGB(255, 5, 146, 59),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.verified,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Usuário autenticado com sucesso!',
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

            Navigator.pushNamed(context, '/transations');
          }
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
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
                        'PIN incorreto, tente novamente.',
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
        }
      }
    }

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF053D54),
      body: Center(
        child: Transform.translate(
          offset: Offset(0, -height * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/logo.png',
                height: height * 0.7,
              ),
              Transform.translate(
                offset: Offset(0, -height * 0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width < 700 ? width * 0.4 : width * 0.15,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 2, 48, 66),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: TextField(
                        controller: password,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 8, 86, 117),
                          fontWeight: FontWeight.w900,
                        ),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'PIN',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 8, 86, 117),
                            fontWeight: FontWeight.w900,
                          ),
                          contentPadding: width < 1000
                              ? const EdgeInsets.all(10)
                              : width < 1400
                                  ? EdgeInsets.symmetric(
                                      vertical: height * 0.0314)
                                  : width < 2000
                                      ? EdgeInsets.symmetric(
                                          vertical: height * 0.0359)
                                      : EdgeInsets.symmetric(
                                          vertical: height * 0.0382),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await signIn(password.text, context);
                      },
                      child: Container(
                        width: width < 700 ? width * 0.09 : width * 0.04,
                        height: height * 0.087,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 9, 44, 58),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                          size: height * 0.035,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
