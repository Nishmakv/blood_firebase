import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdddScreen extends StatefulWidget {
  const AdddScreen({super.key});

  @override
  State<AdddScreen> createState() => _AdddScreenState();
}

class _AdddScreenState extends State<AdddScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final List bloodGroup = ['A+', 'A-', 'B+', 'B-', 'OB-', 'OB+'];
  String? selectedGroup = '';
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');
  void addDonor() {
    final data = {
      'name': nameController.text,
      'phone number': numberController.text,
      'blood group': selectedGroup
    };
    donor.add(data);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Donors',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Donor Name',
                  label: const Text('Name'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: numberController,
                keyboardType: TextInputType.number,
                maxLength: 10,
                decoration: InputDecoration(
                  hintText: 'Donor Number',
                  label: const Text('Number'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  label: Text(
                    'Selected blood group',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                items: bloodGroup
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  selectedGroup = value as String? ?? '';
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  addDonor();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
