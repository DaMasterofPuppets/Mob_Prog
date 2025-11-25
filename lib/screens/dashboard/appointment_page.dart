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
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF420309), // maroon
              onPrimary: Color(0xFFF1B24A), // gold text
              onSurface: Color(0xFF420309), // maroon text
              surface: Colors.white,
            ),
            textTheme: const TextTheme(
              headlineMedium: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontWeight: FontWeight.bold,
              ),
              bodyLarge: TextStyle(fontFamily: 'PlayfairDisplay'),
              labelLarge: TextStyle(fontFamily: 'PlayfairDisplay'),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
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
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF420309), // maroon
              onPrimary: Color(0xFFF1B24A), // gold text
              onSurface: Color(0xFF420309), // maroon text
              surface: Colors.white,
            ),
            textTheme: const TextTheme(
              headlineMedium: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontWeight: FontWeight.bold,
              ),
              bodyLarge: TextStyle(fontFamily: 'PlayfairDisplay'),
              labelLarge: TextStyle(fontFamily: 'PlayfairDisplay'),
            ),
            timePickerTheme: const TimePickerThemeData(
              dialTextStyle: TextStyle(fontFamily: 'PlayfairDisplay'),
              hourMinuteTextStyle: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked.format(context);
      });
    }
  }

  void _showConfirmationDialog() {
    final Color maroon = const Color(0xFF420309);
    final Color gold = const Color(0xFFF1B24A);
    final message = _messageController.text.trim();
    final formattedDate = DateFormat.yMMMMd().format(selectedDate);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: maroon,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            'Confirm Booking Details',
            style: TextStyle(
              color: gold,
              fontWeight: FontWeight.bold,
              fontFamily: 'PlayfairDisplay',
              fontSize: 22,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Date:', formattedDate, gold),
              const SizedBox(height: 12),
              _buildDetailRow('Time:', selectedTime, gold),
              const SizedBox(height: 12),
              _buildDetailRow('Package:', selectedPackage ?? '', gold),
              if (message.isNotEmpty) ...[
                const SizedBox(height: 12),
                _buildDetailRow('Message:', message, gold),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: gold,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                _proceedWithBooking();
              },
              child: const Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, Color gold) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: gold,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            fontFamily: 'PlayfairDisplay',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'PlayfairDisplay',
            ),
          ),
        ),
      ],
    );
  }

  void _proceedWithBooking() async {
    final Color maroon = const Color(0xFF420309);
    final Color gold = const Color(0xFFF1B24A);
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

      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: maroon,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Icon(
              Icons.check_circle_outline,
              color: gold,
              size: 64,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Booking Confirmed!',
                  style: TextStyle(
                    color: gold,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                const Text(
                  'Your appointment has been successfully booked. Check your email for confirmation details.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'PlayfairDisplay',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gold,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlayfairDisplay',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } catch (e, st) {
      print('[BOOK] error: $e');
      print('[BOOK] stack: $st');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send email: $e')),
      );
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

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Calendar widget
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: gold,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('MMMM yyyy').format(selectedDate),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF420309),
                          fontFamily: 'PlayfairDisplay',
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: days.map((date) {
                          final isSelected = date.day == selectedDate.day &&
                              date.month == selectedDate.month;
                          return Column(
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: isSelected ? maroon : Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: maroon.withOpacity(0.5),
                                            blurRadius: 8,
                                            spreadRadius: 2,
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Center(
                                  child: Text(
                                    '${date.day}',
                                    style: TextStyle(
                                      color: isSelected ? gold : maroon,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: 'PlayfairDisplay',
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                DateFormat('E').format(date),
                                style: const TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              //Date
              _infoTile(Icons.calendar_today,
                  'Date: ${DateFormat.yMMMMd().format(selectedDate)}', _pickDate),
              const SizedBox(height: 16),

              //Time
              _infoTile(Icons.access_time,
                  'Time: ${selectedTime.isEmpty ? 'Not selected' : selectedTime}', _pickTime),
              const SizedBox(height: 16),

              // Package + question mark button
              Container(
                decoration: BoxDecoration(
                  color: gold,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        child: DropdownButton<String>(
                          value: selectedPackage,
                          hint: const Text(
                            'Package: Choose',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'PlayfairDisplay',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          dropdownColor: gold,
                          underline: const SizedBox(),
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
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
                              child: Text(
                                'Package: $p',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'PlayfairDisplay',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(color: maroon.withOpacity(0.3), width: 1),
                        ),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.help_outline, color: Color(0xFF420309)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PackagesPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Optional message text box
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _messageController,
                  maxLines: 4,
                  style: const TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Optional message...',
                    hintStyle: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      color: Colors.grey[600],
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),

              const SizedBox(height: 36),

              // Book now button
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [gold, gold.withOpacity(0.85)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: gold.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
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

                    _showConfirmationDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'BOOK NOW',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'PlayfairDisplay',
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String text, [VoidCallback? onTap]) {
    final gold = const Color(0xFFE1A948);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: gold,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}