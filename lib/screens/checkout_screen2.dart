import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jeje_mall5/constants/colors.dart';
import 'package:jeje_mall5/screens/payment_screen.dart';

class CheckoutStage2 extends StatefulWidget {
  const CheckoutStage2({super.key});

  @override
  _CheckoutStage2State createState() => _CheckoutStage2State();
}

class _CheckoutStage2State extends State<CheckoutStage2> {
  String _selectedAddress = 'Pickup';
  final TextEditingController _deliveryAddressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _phoneNumberConfirmController = TextEditingController();

  bool get isPhoneNumberConfirmed =>
      _phoneNumberController.text == _phoneNumberConfirmController.text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 99,
        leading: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Image.asset('./assets/images/mall_logo.png', width: 99, height: 31),
        ),
        title: const Text('Delivery Details', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 19)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select how to receive your package(s)',
                style: GoogleFonts.montserrat(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 21),
              Text(
                'Pickup',
                style: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: Text(
                  'Old Secretariat Complex, Area 1, Garki Abuja',
                  style: GoogleFonts.montserrat(fontSize: 12.0, fontWeight: FontWeight.w400),
                ),
                leading: Radio<String>(
                  value: 'Pickup',
                  groupValue: _selectedAddress,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedAddress = value!;
                    });
                  },
                ),
              ),
               Text(
                  'Delivery',
                  style: GoogleFonts.montserrat(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ListTile(
                title: Text(
                  'Sokoto Street, Area 1, Garki Area 1 AMAC',
                  style: GoogleFonts.montserrat(fontSize: 12.0, fontWeight: FontWeight.w400),
                ),
                leading: Radio<String>(
                  value: 'Delivery',
                  groupValue: _selectedAddress,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedAddress = value!;
                    });
                  },
                ),
              ),
              if (_selectedAddress == 'Delivery') ...[
                const SizedBox(height: 20),
                Text(
                  'Delivery Address',
                  style: GoogleFonts.montserrat(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 60,
                  child: TextField(
                    controller: _deliveryAddressController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(9))),
                      labelText: 'Enter delivery address',
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),
              Text(
                'Contact',
                style: GoogleFonts.montserrat(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 38.83,
                width: 248,
                child: TextField(
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 38.83,
                width: 248,
                child: TextField(
                  controller: _phoneNumberConfirmController,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Phone Number',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  width: 307,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      if (isPhoneNumberConfirmed) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const PaymentScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Phone numbers do not match. Please confirm.')),
                        );
                      }
                    },
                    child: Text(
                      'Proceed to Payment',
                      style: GoogleFonts.montserrat(
                        color: blFa,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
