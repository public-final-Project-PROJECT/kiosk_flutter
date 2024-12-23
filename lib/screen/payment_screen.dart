

import 'package:flutter/material.dart';
import 'package:kiosk_flutter/main.dart';
import 'package:kiosk_flutter/screen/main_screen.dart';
import 'package:kiosk_flutter/store/cart.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("결제 화면"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/다운로드.png',
              width: 400,
              height: 400,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              "카드를 삽입해주세요.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("결제 완료"),
                    content: Text("결제가 완료되었습니다."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          cart.clearCart();
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const MyApp(),
                            ),
                          );
                        },
                        child: Text("확인"),
                      ),
                    ],
                  ),
                );
              },
              child: Text("결제 완료"),
            ),
          ],
        ),
      ),
    );
  }
}
