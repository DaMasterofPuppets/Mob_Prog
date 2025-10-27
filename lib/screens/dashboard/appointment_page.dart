import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'packages_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
  
  DateTime selectedDate = DateTime.now();
  String selectedTime = '';
  String? selectedPackage;

  final List<String> packages = ['Tiara', 'Coronet', 'Crown'];

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        selectedTime = '';
      });
    }
  }

  void _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //Background Colors
    final Color maroon = const Color(0xFF420309);
    final Color gold = const Color(0xFFF1B24A);

    final days = List.generate(4, (i) => selectedDate.add(Duration(days: i)));

    return Scaffold(
      backgroundColor: maroon,
      appBar: AppBar(
        backgroundColor: maroon,
        elevation: 0,

        //Back Button
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.amber),
                onPressed: () => Navigator.pop(context),
              ),
            ),

            const SizedBox(width: 16),
            
            Text(
              'Appointment',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'PlayfairDisplay',
                color: gold,
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                width: double.infinity,
                color: gold,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    Text(
                      DateFormat('MMMM yyyy').format(selectedDate),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF420309),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: days.map((date) {
                        final isSelected = date.day == selectedDate.day &&
                            date.month == selectedDate.month;
                        return Column(
                          children: [
                            CircleAvatar(
                              backgroundColor: isSelected ? maroon : Colors.white,
                              child: Text(
                                '${date.day}',
                                style: TextStyle(
                                  color: isSelected ? Colors.white : maroon,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(DateFormat('E').format(date)),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            //time
            _infoTile(Icons.calendar_today,
                'Date: ${DateFormat.yMMMMd().format(selectedDate)}', _pickDate),
            const SizedBox(height: 8),

            //Date
            _infoTile(Icons.access_time,
                'Time: ${selectedTime.isEmpty ? 'Not selected' : selectedTime}', _pickTime),
            const SizedBox(height: 8),

            // package + question mark button
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: gold,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      value: selectedPackage,
                      hint: const Text(
                        'Package: Choose',
                        style: TextStyle(color: Colors.black),
                      ),
                      dropdownColor: gold,
                      underline: const SizedBox(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            selectedPackage = value;
                          });
                        }
                      },
                      items: packages.map((p) {
                        return DropdownMenuItem<String>(
                          value: p,
                          child: Text('Package: $p',
                              style: const TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(width: 8),
    
      //question mark
      IconButton(
        icon: const Icon(Icons.help_outline, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PackagesPage()),
          );
        },
      ),
    ],
  ),
),

            const SizedBox(height: 24),

// Optional message text box
TextField(
  controller: _messageController,
  maxLines: 3,
  decoration: InputDecoration(
    hintText: 'Optional message',
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  ),
  style: const TextStyle(color: Colors.black),
),


const SizedBox(height: 48),

// When "Book now" is pressed
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () async {

      if (selectedTime.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a time first')),
        );
        return;
      }

  if (selectedPackage == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please choose a package first')),
    );
    return;
  }

      final message = _messageController.text.trim();
      final formattedDate = DateFormat.yMMMMd().format(selectedDate);

try {
  await Supabase.instance.client.functions.invoke(
    'send-booking-email',
    body: {
      'time': selectedTime,
      'date': formattedDate,
      'message': message,
      'email': Supabase.instance.client.auth.currentUser?.email,
      'package': selectedPackage,
    },
  );

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Booking email sent successfully!')),
  );
} catch (e, st) {

        print('[BOOK] error: $e');
        print('[BOOK] stack: $st');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send email: $e')),
        );
      }
    },
            style: ElevatedButton.styleFrom(
              backgroundColor: gold,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'BOOK NOW',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ),


          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String text, [VoidCallback? onTap]) {
    final gold = const Color(0xFFE1A948);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: gold,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 20),
            const SizedBox(width: 8),
            Expanded(child: Text(text, style: const TextStyle(color: Colors.black))),
          ],
        ),
      ),
    );
  }
}