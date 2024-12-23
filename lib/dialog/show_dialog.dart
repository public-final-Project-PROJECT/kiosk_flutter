import 'package:flutter/material.dart';
import 'package:kiosk_flutter/screen/payment_screen.dart';
import 'package:kiosk_flutter/store/cart.dart';
import 'package:provider/provider.dart';

class MenuDetailDialog extends StatelessWidget {

  final Map<String, dynamic> menu;

  const MenuDetailDialog({required this.menu});

  String formatText(String text, int chunkSize) {
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i += chunkSize) {
      buffer.write(text.substring(i, i + chunkSize > text.length ? text.length : i + chunkSize));
      if (i + chunkSize < text.length) {
        buffer.write('\n');
      }
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(menu['menuName'] ?? 'No Name'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          menu['image'] != null
              ? Image.asset(
            "${menu['image']}",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          )
              : Container(),
          SizedBox(height: 10),
          Text(
            '가격: ${menu['price']} 원',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 10),
          Text(
            formatText(menu['content'] ?? '설명 없음', 20), //
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.start, // 텍스트 정렬
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Provider.of<Cart>(context, listen: false).addItem({
              'name': menu['menuName'],
              'price': menu['price'],
            });
            Navigator.pop(context); // 다이얼로그 닫기
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => PaymentScreen(),
            //   ),
            // );
          },
          child: Text('담기'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('닫기'),
        ),
      ],
    );
  }
}
