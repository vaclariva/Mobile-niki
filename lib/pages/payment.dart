// import 'package:flutter/material.dart';

// class PaymentPage extends StatelessWidget {
//   const PaymentPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Payment'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Select Payment Method',
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//             const SizedBox(height: 16),
//             PaymentMethodCard(
//               method: 'Credit Card',
//               icon: Icons.credit_card,
//               onTap: () {
//                 // Add logic for credit card payment
//                 // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => CreditCardPayment()));
//               },
//             ),
//             PaymentMethodCard(
//               method: 'Bank Transfer',
//               icon: Icons.account_balance,
//               onTap: () {
//                 // Add logic for bank transfer payment
//                 // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => BankTransferPayment()));
//               },
//             ),
//             // Add more payment methods as needed
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PaymentMethodCard extends StatelessWidget {
//   final String method;
//   final IconData icon;
//   final VoidCallback onTap;

//   const PaymentMethodCard({
//     required this.method,
//     required this.icon,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         elevation: 5,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10.0),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                     icon,
//                     size: 40,
//                   ),
//                   const SizedBox(width: 16),
//                   Text(
//                     method,
//                     style: const TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//               const Icon(Icons.arrow_forward_ios),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedBank = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Payment Method',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            PaymentMethodCard(
              method: 'Credit Card',
              icon: Icons.credit_card,
              onTap: () {
                _showPaymentAlert('Credit Card');
              },
            ),
            PaymentMethodCard(
              method: 'Bank Transfer',
              icon: Icons.account_balance,
              onTap: () {
                _showBankOptions();
              },
            ),
            // Add more payment methods as needed
          ],
        ),
      ),
    );
  }

  void _showBankOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Bank'),
          content: Column(
            children: [
              ListTile(
                title: const Text('Mandiri'),
                onTap: () {
                  Navigator.pop(context);
                  _showPaymentAmountDialog('Mandiri');
                },
              ),
              ListTile(
                title: const Text('BCA'),
                onTap: () {
                  Navigator.pop(context);
                  _showPaymentAmountDialog('BCA');
                },
              ),
              ListTile(
                title: const Text('BRI'),
                onTap: () {
                  Navigator.pop(context);
                  _showPaymentAmountDialog('BRI');
                },
              ),
              ListTile(
                title: const Text('BNI'),
                onTap: () {
                  Navigator.pop(context);
                  _showPaymentAmountDialog('BNI');
                },
              ),
              // Add more banks as needed
            ],
          ),
        );
      },
    );
  }

  void _showPaymentAmountDialog(String bank) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Payment Details'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                style: TextStyle(color: Colors.grey),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showOrderConfirmationAlert(bank);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  onPrimary: Colors.white,
                ),
                child: const Text('Send', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showOrderConfirmationAlert(String bank) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order Placed'),
          content: Column(
            children: [
              const Text('Your order has been placed successfully!'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  onPrimary: Colors.white,
                ),
                child: const Text('OK', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPaymentAlert(String method) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          content: Column(
            children: [
              const Text('Your payment was successful!'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  onPrimary: Colors.white,
                ),
                child: const Text('OK', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  final String method;
  final IconData icon;
  final VoidCallback onTap;

  const PaymentMethodCard({
    required this.method,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 40,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    method,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: PaymentPage(),
  ));
}
