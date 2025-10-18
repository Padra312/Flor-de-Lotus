import 'dart:convert'; // para conversão do JSON
import 'package:http/http.dart' as http; // pacote http para conexão
import '../models/massage.dart'; // Importa o modelo Product

class MassageService {
  static const String baseUrl = 'http://192.168.0.6:8080/api';
 
  static Future<List<Massage>> getMassagens() async {
    final response = await http.get(Uri.parse('$baseUrl/massagens'));
   
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Massage.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar produtos: ${response.statusCode}');
    }
  }


}
