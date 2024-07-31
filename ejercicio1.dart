void main() {
  List<Map<String, dynamic>> productos = [
    {'nombre': 'Producto 1', 'precio': 100.0, 'descuento': 0.1, 'iva': 0.21},
    {'nombre': 'Producto 2', 'precio': 200.0, 'descuento': 0.15, 'iva': 0.21},
    {'nombre': 'Producto 3', 'precio': 150.0, 'descuento': 0.05, 'iva': 0.21},
  ];

  for (var producto in productos) {
    double precio = producto['precio'] ?? 1;
    double descuento = producto['descuento'] ?? 0;
    double iva = producto['iva'] ?? 0.21;

    double precioConDescuento = precio * (1 - descuento);

    double ivaAplicado = precioConDescuento * iva;

    double total = precioConDescuento + ivaAplicado;
    print('El precio final del producto ${producto["nombre"]} es de $total');
  }
}
