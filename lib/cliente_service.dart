import 'dart:convert';
import 'package:http/http.dart' as http;

class Cliente {
  final String idcliente;
  final String nombres;
  final String apellidos;
  final String telefono;
  final String correo;

  Cliente({
    required this.idcliente,
    required this.nombres,
    required this.apellidos,
    required this.telefono,
    required this.correo,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      idcliente: json['idcliente'],
      nombres: json['nombres'],
      apellidos: json['apellidos'],
      telefono: json['telefono'],
      correo: json['correo'],
    );
  }
}

class ClienteService {
  final String baseUrl = 'http://127.0.0.1:8080'; // Ajusta esto según tu configuración

  Future<List<Cliente>> getClientes() async {
    final response = await http.get(Uri.parse('$baseUrl/clientes'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return (data['clientes'] as List)
          .map((clienteJson) => Cliente.fromJson(clienteJson))
          .toList();
    } else {
      throw Exception('Failed to load clientes');
    }
  }

  Future<Cliente> getCliente(String codigo) async {
    final response = await http.get(Uri.parse('$baseUrl/clientes/$codigo'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Cliente.fromJson(data['clientes']);
    } else {
      throw Exception('Failed to load cliente');
    }
  }

  Future<void> registrarCliente(Cliente cliente) async {
    final response = await http.post(
      Uri.parse('$baseUrl/clientes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'idcliente': cliente.idcliente,
        'nombres': cliente.nombres,
        'apellidos': cliente.apellidos,
        'telefono': cliente.telefono,
        'correo': cliente.correo,
        
        
      }),

   
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create cliente');
    }
  }

  Future<void> eliminarCliente(String codigo) async {
    final response = await http.delete(Uri.parse('$baseUrl/eliminar_clientes/$codigo'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete cliente');
    }
  }
}