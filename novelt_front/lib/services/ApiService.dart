import 'package:http/http.dart' as http;

class ApiService{
  final String baseUrl = '';
  final String today = 'today';

  // get 함수 예시
  void getexample()async {
    final url = Uri.parse('$baseUrl/$today');
    final response = await http.get(url);

    if (response.statusCode == 200){
      print(response.body);
    }
    throw Error();
  }
}
<<<<<<< HEAD

=======
>>>>>>> 7c596e57f2d63d404c0bb7626e01400eacffb469
