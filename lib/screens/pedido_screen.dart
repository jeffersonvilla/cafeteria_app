import 'package:flutter/material.dart';

class PedidoScreen extends StatefulWidget {
  @override
  _PedidoScreenState createState() => _PedidoScreenState();
}

class _PedidoScreenState extends State<PedidoScreen> {
  String? _selectedBebida;
  int _selectedCantidad = 1;
  List<Map<String, dynamic>> pedidos = [];
  List<String> bebidas = ['Café Americano', 'Café Latte', 'Capuchino', 'Té Verde', 'Pastel de Chocolate'];

  void _agregarPedido() {
    if (_selectedBebida != null) {
      setState(() {
        // Busca si el pedido ya existe
        int index = pedidos.indexWhere((pedido) => pedido['bebida'] == _selectedBebida);

        if (index != -1) {
          // Si ya existe, actualiza la cantidad
          pedidos[index]['cantidad'] += _selectedCantidad;
        } else {
          // Si no existe, agrega el nuevo pedido
          pedidos.add({
            'bebida': _selectedBebida,
            'cantidad': _selectedCantidad,
          });
        }

        // Reinicia los campos
        _selectedBebida = null;
        _selectedCantidad = 1;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pedido actualizado')),
      );
    }
  }

  void _eliminarPedido(int index) {
    setState(() {
      pedidos.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pedido eliminado')),
    );
  }

  void _realizarPedido() {
    if (pedidos.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pedido realizado con éxito')),
      );
      setState(() {
        pedidos.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Pedido'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selecciona una bebida:',
                      style: TextStyle(fontSize: 18),
                    ),
                    DropdownButton<String>(
                      value: _selectedBebida,
                      hint: Text('Seleccionar bebida'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBebida = newValue;
                        });
                      },
                      items: bebidas.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Selecciona la cantidad:',
                      style: TextStyle(fontSize: 18),
                    ),
                    DropdownButton<int>(
                      value: _selectedCantidad,
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedCantidad = newValue ?? 1;
                        });
                      },
                      items: List.generate(10, (index) => index + 1)
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _selectedBebida == null
                          ? null
                          : _agregarPedido,
                      child: Text('Agregar al Pedido'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tu pedido:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${pedidos[index]['cantidad']} x ${pedidos[index]['bebida']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _eliminarPedido(index),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pedidos.isEmpty ? null : _realizarPedido,
              child: Text('Realizar Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}