import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  final String name;
  final String number;
  final String id;
  final String bloodGroup;
  const UpdateScreen(
      {super.key,
      required this.name,
      required this.number,
      required this.id,
      required this.bloodGroup});

  @override
  State<UpdateScreen> createState() => UpdateScreenState();
}

class UpdateScreenState extends State<UpdateScreen> {
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
  void initState() {
    super.initState();
    nameController.text = widget.name;
    numberController.text = widget.number;
    selectedGroup = widget.bloodGroup;
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
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
