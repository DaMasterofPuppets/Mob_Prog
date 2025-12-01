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

  DateTime? selectedDate;
  String selectedTime = '';
  String? selectedPackage;

  final List<String> packages = ['Tiara', 'Coronet', 'Crown'];

  void _pickDate() async {
    final initial = selectedDate ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
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

  void _showWarningDialog(String message) {
    final Color maroon = const Color(0xFF420309);
    final Color gold = const Color(0xFFF1B24A);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isTablet ? 80 : 40,
            vertical: isTablet ? 40 : 24,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: maroon,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: gold, width: 3.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: isTablet ? 72 : 56,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: isTablet ? 12 : 10),
                Text(
                  'Notice',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: gold,
                    fontSize: isTablet ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
                SizedBox(height: isTablet ? 10 : 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 15 : 14,
                    fontFamily: 'PlayfairDisplay',
                    height: 1.4,
                  ),
                ),
                SizedBox(height: isTablet ? 16 : 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: gold,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: isTablet ? 14 : 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(color: gold),
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showConfirmationDialog() {
    final Color maroon = const Color(0xFF420309);
    final Color gold = const Color(0xFFF1B24A);
    final message = _messageController.text.trim();
    final formattedDate =
        selectedDate != null ? DateFormat.yMMMMd().format(selectedDate!) : 'Not selected';
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: isTablet ? 80 : 40,
            vertical: isTablet ? 40 : 24,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: maroon,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: gold, width: 3.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: isTablet ? 72 : 56,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: isTablet ? 14 : 10),
                Text(
                  'Confirm Booking Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: gold,
                    fontSize: isTablet ? 20 : 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
                SizedBox(height: isTablet ? 12 : 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _dialogDetailRow('Date:', formattedDate, gold, isTablet),
                    SizedBox(height: isTablet ? 12 : 8),
                    _dialogDetailRow('Time:', selectedTime.isEmpty ? 'Not selected' : selectedTime, gold, isTablet),
                    SizedBox(height: isTablet ? 12 : 8),
                    _dialogDetailRow('Package:', selectedPackage ?? '', gold, isTablet),
                    if (message.isNotEmpty) ...[
                      SizedBox(height: isTablet ? 12 : 8),
                      _dialogDetailRow('Message:', message, gold, isTablet),
                    ],
                  ],
                ),
                SizedBox(height: isTablet ? 18 : 14),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: gold.withOpacity(0.0),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: isTablet ? 14 : 12),
                          side: BorderSide(color: gold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PlayfairDisplay',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _proceedWithBooking();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: gold,
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: isTablet ? 14 : 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PlayfairDisplay',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _dialogDetailRow(String label, String value, Color gold, bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: gold,
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 15 : 13,
            fontFamily: 'PlayfairDisplay',
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 15 : 13,
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
    final formattedDate =
        selectedDate != null ? DateFormat.yMMMMd().format(selectedDate!) : 'Not selected';
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

      // Success dialog (logo intentionally removed; only check icon is shown)
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(
              horizontal: isTablet ? 80 : 40,
              vertical: isTablet ? 40 : 24,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              decoration: BoxDecoration(
                color: maroon,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: gold, width: 3.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: gold,
                    size: isTablet ? 80 : 64,
                  ),
                  SizedBox(height: isTablet ? 10 : 8),
                  Text(
                    'Booking Confirmed!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: gold,
                      fontSize: isTablet ? 22 : 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlayfairDisplay',
                    ),
                  ),
                  SizedBox(height: isTablet ? 12 : 10),
                  Text(
                    'Your appointment has been successfully booked. We will contact you by email with the details.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isTablet ? 15 : 14,
                      fontFamily: 'PlayfairDisplay',
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: isTablet ? 18 : 14),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gold,
                        padding: EdgeInsets.symmetric(vertical: isTablet ? 14 : 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e, st) {
      print('[BOOK] error: $e');
      print('[BOOK] stack: $st');
      _showWarningDialog('Failed to send email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color maroon = const Color(0xFF420309);
    final Color gold = const Color(0xFFF1B24A);
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 600;

    final baseDate = DateTime.now();
    final days = List.generate(4, (i) => baseDate.add(Duration(days: i)));

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
                        selectedDate != null
                            ? DateFormat('MMMM yyyy').format(selectedDate!)
                            : 'Select date',
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
                          final isSelected = selectedDate != null &&
                              date.day == selectedDate!.day &&
                              date.month == selectedDate!.month &&
                              date.year == selectedDate!.year;
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

              SizedBox(height: isTablet ? 14 : 12),
              Text(
                'Tap the controls below to select a date, time, and package for your booking.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.95),
                  fontFamily: 'PlayfairDisplay',
                  fontSize: isTablet ? 15 : 13,
                ),
              ),
              SizedBox(height: isTablet ? 28 : 20),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: _pickDate,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: isTablet ? 16 : 12,
                          horizontal: isTablet ? 16 : 12,
                        ),
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
                            Icon(Icons.calendar_today,
                                color: Colors.black, size: isTablet ? 26 : 22),
                            SizedBox(width: isTablet ? 12 : 8),
                            Text(
                              'Date:',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'PlayfairDisplay',
                                fontWeight: FontWeight.w600,
                                fontSize: isTablet ? 17 : 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: _pickDate,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: isTablet ? 16 : 12,
                          horizontal: isTablet ? 16 : 12,
                        ),
                        decoration: BoxDecoration(
                          color: gold,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          selectedDate != null
                              ? DateFormat.yMMMMd().format(selectedDate!)
                              : 'Not selected',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'PlayfairDisplay',
                            fontSize: isTablet ? 16 : 14,
                            fontWeight: selectedDate != null ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: isTablet ? 16 : 12),

              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: _pickTime,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: isTablet ? 16 : 12,
                          horizontal: isTablet ? 16 : 12,
                        ),
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
                            Icon(Icons.access_time,
                                color: Colors.black, size: isTablet ? 26 : 22),
                            SizedBox(width: isTablet ? 12 : 8),
                            Text(
                              'Time:',
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'PlayfairDisplay',
                                fontWeight: FontWeight.w600,
                                fontSize: isTablet ? 17 : 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: _pickTime,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: isTablet ? 16 : 12,
                          horizontal: isTablet ? 16 : 12,
                        ),
                        decoration: BoxDecoration(
                          color: gold,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          selectedTime.isNotEmpty ? selectedTime : 'Not selected',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'PlayfairDisplay',
                            fontSize: isTablet ? 16 : 14,
                            fontWeight: selectedTime.isNotEmpty ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: isTablet ? 20 : 16),

              Row(
                children: [
                  Expanded(
                    child: Container(
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
                  ),
                  SizedBox(width: 12),
                  Material(
                    color: gold,
                    shape: const CircleBorder(),
                    elevation: 3,
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PackagesPage()),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(isTablet ? 12 : 10),
                        child: Icon(
                          Icons.help_outline,
                          color: maroon,
                          size: isTablet ? 28 : 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: isTablet ? 28 : 22),

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

              SizedBox(height: isTablet ? 36 : 30),

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
                      _showWarningDialog('Please select a time first');
                      return;
                    }
                    if (selectedPackage == null) {
                      _showWarningDialog('Please choose a package first');
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
}
