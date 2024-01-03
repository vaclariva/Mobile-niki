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

class BankTransferPaymentPage extends StatefulWidget {
  @override
  _BankTransferPaymentPageState createState() =>
      _BankTransferPaymentPageState();
}

class _BankTransferPaymentPageState extends State<BankTransferPaymentPage> {
  String selectedBank = '1'; // Tambahkan variabel untuk menyimpan bank yang dipilih
  List<String> bankList = ['Bank A', 'Bank B', 'Bank C']; // Gantilah dengan list bank yang sesuai

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Transfer Payment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Bank',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: selectedBank,
              onChanged: (String? newValue) {
                setState(() {
                  selectedBank = newValue!;
                });
              },
              items: bankList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk melanjutkan transaksi
                if (selectedBank.isNotEmpty) {
                  // Lakukan sesuatu setelah bank dipilih
                  // Misalnya, tampilkan dialog untuk memasukkan nominal uang
                  _showAmountDialog();
                } else {
                  // Tampilkan pesan kesalahan jika bank tidak dipilih
                  _showErrorDialog();
                }
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }

  // Metode untuk menampilkan dialog memasukkan nominal uang
  void _showAmountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Amount'),
          content: TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Tambahkan logika untuk menangani jumlah yang dimasukkan
                // Misalnya, lakukan pembayaran dan tampilkan konfirmasi
                _showConfirmationDialog();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Metode untuk menampilkan dialog konfirmasi
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Transaction Completed'),
          content: const Text('Thank you for your payment!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog konfirmasi
                Navigator.pop(context); // Kembali ke halaman sebelumnya (My Card)
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Metode untuk menampilkan pesan kesalahan jika bank tidak dipilih
  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please select a bank.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Tutup dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
