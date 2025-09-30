//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tinderapp/presentation/screens/onboarding/gender_screen.dart';
import 'package:tinderapp/presentation/screens/onboarding/widgets/stepper_bar.dart';

class DobScreen extends StatefulWidget {
  const DobScreen({super.key});

  @override
  State<DobScreen> createState() => _DobScreenState();
}

class _DobScreenState extends State<DobScreen> {
  TextEditingController dobController = TextEditingController();
  DateTime? _selectedDate;

  final _globalKey = GlobalKey<FormState>();
  @override
  void dispose() {
    dobController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dobController.text = DateFormat('dd/MM/yyyy').format(_selectedDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.black),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: StepProgressBar(
                  currentStep: 3, // <-- first page
                  totalSteps: 15, // <-- adjust based on your flow
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  "Your b-day?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    //  decorationStyle:
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Form(
                  key: _globalKey,
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),

                    controller: dobController,
                    //  keyboardType: TextInputType.phone,
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date of Birth",
                      suffixIcon: Icon(Icons.calendar_view_month_outlined),
                    ),
                    onTap: () {
                      _selectDate(context);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,

                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text:
                            "Your profile shows your age, not your date of birth.\n",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // TextSpan(
                      //   text: "Can't change it later.",
                      //   style: TextStyle(
                      //     color: Colors.white, // Typically a link color
                      //     fontSize: 18,
                      //     fontWeight: FontWeight.bold,
                      //     // decoration: TextDecoration.underline,
                      //     // decorationColor:
                      //     //     Colors.blue, // Optional for link feel
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.06,
                //decoration: BoxDecoration(color: Colors.grey),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  onPressed: () {
                    // print("object");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => GenderScreen()),
                    );
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: const Color.fromARGB(255, 96, 99, 100),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
