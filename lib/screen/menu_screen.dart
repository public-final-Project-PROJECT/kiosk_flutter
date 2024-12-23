import 'package:flutter/material.dart';
import 'package:kiosk_flutter/dialog/show_dialog.dart';
import 'package:kiosk_flutter/model/menu_model.dart';
import 'package:kiosk_flutter/screen/payment_screen.dart';
import 'package:kiosk_flutter/store/cart.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  List<dynamic> _menus = [];
  final MenuModel _menuModel = MenuModel();
  dynamic _selectedMenu;

  @override
  void initState() {
    _loadMenus();
  }

  void _loadMenus() async {
    List<dynamic> menuData = await _menuModel.searchMenu();
    setState(() {
      _menus = menuData;
    });
  }


  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("메뉴 목록"),
      ),
      body: Column(
        children: [
          // GridView.builder를 확장 가능한 높이로 감쌉니다.
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 한 줄에 두 개의 항목을 표시
                crossAxisSpacing: 10, // 항목 간의 수평 간격
                mainAxisSpacing: 10, // 항목 간의 수직 간격
                childAspectRatio: 1, // 항목의 비율을 1:1로 설정
              ),
              itemCount: _menus.length,
              itemBuilder: (context, index) {
                var menu = _menus[index]; // 메뉴 항목 데이터
                return Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 카드 모서리 둥글게
                  ),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return MenuDetailDialog(menu: menu);
                        },
                      );
                    },
                    splashColor: Colors.blue.withAlpha(30), // 물결 효과 색상
                    highlightColor: Colors.blue.withAlpha(50), // 클릭 시 강조 색상
                    child: AnimatedScale(
                      duration: Duration(milliseconds: 150), // 애니메이션 지속 시간
                      scale: _selectedMenu == index ? 1.05 : 1.0, // 선택 시 크기 변환
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          menu['image'] != null
                              ? Image.asset(
                            "${menu['image']}",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover, // 이미지를 꽉 채우도록 설정
                          )
                              : Container(), // 이미지가 없으면 빈 컨테이너
                          SizedBox(height: 10),
                          Text(
                            menu['menuName'] ?? 'No Name',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5),
                          Text(
                            '가격: ${menu['price']} 원',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // 하단에 "카트" 컨테이너 추가
          Container(
            height: 100, // 카트 컨테이너 높이
            width: double.infinity, // 화면 너비에 맞게 확장
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Consumer<Cart>(
                    builder: (context, cart, child) {
                      return Column(
                        children: [
                          Container( child:  Text("메뉴 : ${cart.menuNames.join(',')}"),width: 200,),
                          Container( child:     Text("총 가격 : ${cart.totalPrice}"),width: 200,)
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentScreen(),
                            ),
                          );
                        },
                        child: Text("결제하기"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          cart.clearCart();
                        },
                        child: Text("비우기"),
                      ),
                    )

                  ],
                )

              ],
            ),
          ),
        ],
      ),
    );
  }}