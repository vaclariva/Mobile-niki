// card_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'payment.dart'; // Import halaman pembayaran
import '../components/cart_item.dart';
import '../models/cart.dart';
import '../models/shoe.dart';

class CardPage extends StatefulWidget {
  const CardPage({Key? key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: ((context, value, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "My Card",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: value.getUserCart().length,
                    itemBuilder: (BuildContext context, index) {
                      Shoe individualShoe = value.getUserCart()[index];

                      return GestureDetector(
                        onTap: () {
                          // Navigasi ke halaman detail produk atau aksi lainnya
                          // Misalnya Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProductPage(shoe: individualShoe)));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentPage(),
                            ),
                          );
                        },
                        child: CartItem(
                          shoe: individualShoe,
                          onIncrement: () {
                            value.incrementQuantity(individualShoe);
                          },
                          onDecrement: () {
                            value.decrementQuantity(individualShoe);
                          },
                          onDelete: () {
                            value.removeItemFromCart(individualShoe);
                          },
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          )),
    );
  }
}
