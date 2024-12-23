import 'package:dio/dio.dart';

class MenuModel{

  //메뉴 조회
  Future<List<dynamic>>searchMenu() async{
    final dio = Dio();

    try{
      final response = await dio.get("http://localhost:8080/menu/view");
      if(response.statusCode == 200){
        return response.data as List<dynamic>;
      }else{
        throw Exception("로드 실패");
      }
    }catch (e){
      print(e);
      throw Exception("Error : $e");
    }
  }

}