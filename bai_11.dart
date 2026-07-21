abstract class Vehicle {
  void move();
}

class Car extends Vehicle {
  @override
  void move() {
    print('Ô tô di chuyển bằng bánh xe.');
  }
}

class Bike extends Vehicle {
  @override
  void move() {
    print('Xe đạp di chuyển bằng sức người.');
  }
}

class Airplane extends Vehicle {
  @override
  void move() {
    print('Máy bay bay trên không.');
  }
}

void main() {
  // Cùng có kiểu Vehicle nhưng mỗi đối tượng chạy move() theo cách riêng.
  final List<Vehicle> vehicles = <Vehicle>[Car(), Bike(), Airplane()];

  for (final Vehicle vehicle in vehicles) {
    vehicle.move();
  }
}
