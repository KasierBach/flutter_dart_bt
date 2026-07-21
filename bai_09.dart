class Product {
  Product({required this.id, required this.name, required this.price});

  final String id;
  final String name;
  final double price;
}

class Cart {
  final List<Product> items = <Product>[];

  void addProduct(Product product) {
    items.add(product);
    print('Đã thêm ${product.name} vào giỏ hàng.');
  }

  void removeProduct(String id) {
    final int oldLength = items.length;
    items.removeWhere((Product product) => product.id == id);

    if (items.length < oldLength) {
      print('Đã xóa sản phẩm có mã $id.');
    } else {
      print('Không tìm thấy sản phẩm có mã $id.');
    }
  }

  double getTotal() {
    double total = 0;

    for (final Product product in items) {
      total = total + product.price;
    }

    return total;
  }

  void displayCart() {
    if (items.isEmpty) {
      print('Giỏ hàng đang trống.');
      return;
    }

    print('\nSản phẩm trong giỏ hàng:');
    for (final Product product in items) {
      print('${product.id} - ${product.name}: ${product.price} đồng');
    }
    print('Tổng tiền: ${getTotal()} đồng');
  }
}

void main() {
  final Cart cart = Cart();

  cart.addProduct(Product(id: 'SP01', name: 'Bút', price: 5000));
  cart.addProduct(Product(id: 'SP02', name: 'Vở', price: 12000));
  cart.addProduct(Product(id: 'SP03', name: 'Thước', price: 8000));

  cart.displayCart();
  cart.removeProduct('SP02');
  cart.displayCart();
}
