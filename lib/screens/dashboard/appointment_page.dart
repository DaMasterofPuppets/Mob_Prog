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
              primary: Color(0xFF420309),
              onPrimary: Color(0xFFF1B24A),
              onSurface: Color(0xFF420309),
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
              primary: Color(0xFF420309),
              onPrimary: Color(0xFFF1B24A),
              onSurface: Color(0xFF420309),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

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
              fontSize: isTablet ? 26 : 22,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Date:', formattedDate, gold, isTablet),
              SizedBox(height: isTablet ? 16 : 12),
              _buildDetailRow('Time:', selectedTime, gold, isTablet),
              SizedBox(height: isTablet ? 16 : 12),
              _buildDetailRow('Package:', selectedPackage ?? '', gold, isTablet),
              if (message.isNotEmpty) ...[
                SizedBox(height: isTablet ? 16 : 12),
                _buildDetailRow('Message:', message, gold, isTablet),
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
                  fontSize: isTablet ? 17 : 15,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: gold,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 24 : 16,
                  vertical: isTablet ? 14 : 12,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                _proceedWithBooking();
              },
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                  fontSize: isTablet ? 17 : 15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, Color gold, bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: gold,
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 17 : 15,
            fontFamily: 'PlayfairDisplay',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 17 : 15,
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

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
              size: isTablet ? 80 : 64,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Booking Confirmed!',
                  style: TextStyle(
                    color: gold,
                    fontSize: isTablet ? 28 : 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isTablet ? 16 : 12),
                Text(
                  'Your appointment has been successfully booked. Check your email for confirmation details.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 17 : 15,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 40 : 32,
                      vertical: isTablet ? 16 : 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlayfairDisplay',
                      fontSize: isTablet ? 18 : 16,
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
    final Color maroon = const Color(0xFF420309);
    final Color gold = const Color(0xFFF1B24A);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    final days = List.generate(4, (i) => selectedDate.add(Duration(days: i)));

    return Scaffold(
      backgroundColor: maroon,
      appBar: AppBar(
        backgroundColor: maroon,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 16.0 : 0),
          child: Row(
            children: [
              CircleAvatar(
                radius: isTablet ? 24 : 20,
                backgroundColor: Colors.black,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.amber,
                    size: isTablet ? 28 : 24,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: isTablet ? 20 : 16),
              Text(
                'Appointment',
                style: TextStyle(
                  fontSize: isTablet ? 42 : 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                  color: gold,
                ),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet ? screenWidth * 0.15 : 16,
            vertical: 16,
          ),
          child: Column(
            children: [
              SizedBox(height: isTablet ? 30 : 20),
              
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
                  padding: EdgeInsets.symmetric(
                    vertical: isTablet ? 24 : 16,
                    horizontal: isTablet ? 20 : 12,
                  ),
                  child: Column(
                    children: [
                      Text(
                        DateFormat('MMMM yyyy').format(selectedDate),
                        style: TextStyle(
                          fontSize: isTablet ? 22 : 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF420309),
                          fontFamily: 'PlayfairDisplay',
                        ),
                      ),
                      SizedBox(height: isTablet ? 18 : 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: days.map((date) {
                          final isSelected = date.day == selectedDate.day &&
                              date.month == selectedDate.month;
                          return Column(
                            children: [
                              Container(
                                width: isTablet ? 65 : 50,
                                height: isTablet ? 65 : 50,
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
                                      fontSize: isTablet ? 22 : 18,
                                      fontFamily: 'PlayfairDisplay',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: isTablet ? 8 : 6),
                              Text(
                                DateFormat('E').format(date),
                                style: TextStyle(
                                  fontFamily: 'PlayfairDisplay',
                                  fontWeight: FontWeight.w600,
                                  fontSize: isTablet ? 15 : 13,
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

              SizedBox(height: isTablet ? 40 : 32),

              // Date
              _infoTile(
                Icons.calendar_today,
                'Date: ${DateFormat.yMMMMd().format(selectedDate)}',
                _pickDate,
                isTablet,
              ),
              SizedBox(height: isTablet ? 20 : 16),

              // Time
              _infoTile(
                Icons.access_time,
                'Time: ${selectedTime.isEmpty ? 'Not selected' : selectedTime}',
                _pickTime,
                isTablet,
              ),
              SizedBox(height: isTablet ? 20 : 16),

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
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 20 : 16,
                          vertical: 4,
                        ),
                        child: DropdownButton<String>(
                          value: selectedPackage,
                          hint: Text(
                            'Package: Choose',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'PlayfairDisplay',
                              fontWeight: FontWeight.w600,
                              fontSize: isTablet ? 17 : 15,
                            ),
                          ),
                          dropdownColor: gold,
                          underline: const SizedBox(),
                          isExpanded: true,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                            size: isTablet ? 28 : 24,
                          ),
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
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'PlayfairDisplay',
                                  fontWeight: FontWeight.w600,
                                  fontSize: isTablet ? 17 : 15,
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
                        icon: Icon(
                          Icons.help_outline,
                          color: Color(0xFF420309),
                          size: isTablet ? 28 : 24,
                        ),
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

              SizedBox(height: isTablet ? 35 : 28),

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
                  maxLines: isTablet ? 5 : 4,
                  style: TextStyle(
                    fontFamily: 'PlayfairDisplay',
                    fontSize: isTablet ? 17 : 15,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Optional message...',
                    hintStyle: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      color: Colors.grey[600],
                      fontSize: isTablet ? 17 : 15,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 20 : 16,
                      vertical: isTablet ? 18 : 14,
                    ),
                  ),
                ),
              ),

              SizedBox(height: isTablet ? 45 : 36),

              // Book now button
              Container(
                width: double.infinity,
                height: isTablet ? 65 : 55,
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
                  child: Text(
                    'BOOK NOW',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: isTablet ? 20 : 18,
                      fontFamily: 'PlayfairDisplay',
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              SizedBox(height: isTablet ? 50 : 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String text, VoidCallback? onTap, bool isTablet) {
    final gold = const Color(0xFFE1A948);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(isTablet ? 18 : 14),
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
            Icon(icon, color: Colors.black, size: isTablet ? 26 : 22),
            SizedBox(width: isTablet ? 16 : 12),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'PlayfairDisplay',
                  fontWeight: FontWeight.w600,
                  fontSize: isTablet ? 17 : 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}