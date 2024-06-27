import 'package:flutter/material.dart';
import 'cliente_service.dart';

class ClienteListScreen extends StatefulWidget {
  @override
  _ClienteListScreenState createState() => _ClienteListScreenState();
}

class _ClienteListScreenState extends State<ClienteListScreen> {
  final ClienteService _clienteService = ClienteService();
  late Future<List<Cliente>> _clientes;

  @override
  void initState() {
    super.initState();
    _clientes = _clienteService.getClientes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Clientes')),
      body: FutureBuilder<List<Cliente>>(
        future: _clientes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No se encontraron clientes'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final cliente = snapshot.data![index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('ID: ${cliente.idcliente}', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 8),
                        Text('Nombres: ${cliente.nombres}'),
                        Text('Apellidos: ${cliente.apellidos}'),
                        Text('Teléfono: ${cliente.telefono}'),
                        Text('Correo: ${cliente.correo}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aquí puedes agregar la lógica para añadir un nuevo cliente
        },
        child: Icon(Icons.add),
      ),
    );
  }
}