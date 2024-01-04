// class Shoe {
//   final String name;
//   final String price;
//   final String imagePath;
//   final String description;

//   Shoe({
//     required this.name,
//     required this.price,
//     required this.description,
//     required this.imagePath,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'name': name,
//       'price': price,
//       'description': description,
//       'imagePath': imagePath,
//     };
//   }
// }


class Shoe {
  final String name;
  final String price;
  final String imagePath;
  final String description;
  int quantity;

  Shoe({
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    this.quantity = 1, required title,
  });

    Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'description': description,
      'imagePath': imagePath,
    };
  }


  void incrementQuantity() {
    quantity++;
  }

  void decrementQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}