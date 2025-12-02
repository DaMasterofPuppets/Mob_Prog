import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'packages_page.dart';
import 'reader_page.dart';
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
  String? selectedReader;

  final List<String> packages = ['Tiara', 'Coronet', 'Crown'];
  final List<String> readers = ['Deniella Ching'];

  Future<void> _pickDate() async {
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
      });
    }
  }

  Future<void> _pickTime() async {
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
    final bool isTablet = screenWidth >= 600;

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
            padding: EdgeInsets.all(isTablet ? 32 : 24),
            decoration: BoxDecoration(
              color: maroon,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: gold, width: 2.0),
              boxShadow: [
                BoxShadow(
                  color: gold.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(isTablet ? 16 : 12),
                  decoration: BoxDecoration(
                    color: gold.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.info_outline,
                    color: gold,
                    size: isTablet ? 48 : 40,
                  ),
                ),
                SizedBox(height: isTablet ? 20 : 16),
                Text(
                  'Notice',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: gold,
                    fontSize: isTablet ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
                SizedBox(height: isTablet ? 12 : 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isTablet ? 16 : 14,
                    fontFamily: 'PlayfairDisplay',
                    height: 1.5,
                  ),
                ),
                SizedBox(height: isTablet ? 24 : 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: gold,
                      foregroundColor: maroon,
                      padding: EdgeInsets.symmetric(vertical: isTablet ? 16 : 14),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PlayfairDisplay',
                        fontSize: isTablet ? 17 : 15,
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
    final bool isTablet = screenWidth >= 600;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: isTablet ? 80 : 40, vertical: isTablet ? 40 : 24),
          child: Container(
            padding: EdgeInsets.all(isTablet ? 32 : 24),
            decoration: BoxDecoration(
              color: maroon,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: gold, width: 2.0),
              boxShadow: [
                BoxShadow(
                  color: gold.withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 2,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: isTablet ? 80 : 64,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: isTablet ? 20 : 16),
                Text(
                  'Confirm Booking Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: gold,
                    fontSize: isTablet ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
                SizedBox(height: isTablet ? 24 : 20),
                Container(
                  padding: EdgeInsets.all(isTablet ? 20 : 16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: gold.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      _dialogDetailRow('Date', formattedDate, maroon, gold, isTablet),
                      SizedBox(height: isTablet ? 14 : 12),
                      Divider(color: gold.withOpacity(0.2), height: 1),
                      SizedBox(height: isTablet ? 14 : 12),
                      _dialogDetailRow('Time', selectedTime.isEmpty ? 'Not selected' : selectedTime, maroon, gold, isTablet),
                      SizedBox(height: isTablet ? 14 : 12),
                      Divider(color: gold.withOpacity(0.2), height: 1),
                      SizedBox(height: isTablet ? 14 : 12),
                      _dialogDetailRow('Package', selectedPackage ?? '', maroon, gold, isTablet),
                      SizedBox(height: isTablet ? 14 : 12),
                      Divider(color: gold.withOpacity(0.2), height: 1),
                      SizedBox(height: isTablet ? 14 : 12),
                      _dialogDetailRow('Reader', selectedReader ?? '', maroon, gold, isTablet),
                      if (message.isNotEmpty) ...[
                        SizedBox(height: isTablet ? 14 : 12),
                        Divider(color: gold.withOpacity(0.2), height: 1),
                        SizedBox(height: isTablet ? 14 : 12),
                        _dialogDetailRow('Message', message, maroon, gold, isTablet),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: isTablet ? 24 : 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: gold,
                          padding: EdgeInsets.symmetric(vertical: isTablet ? 16 : 14),
                          side: BorderSide(color: gold, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PlayfairDisplay',
                            fontSize: isTablet ? 17 : 15,
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
                          foregroundColor: maroon,
                          padding: EdgeInsets.symmetric(vertical: isTablet ? 16 : 14),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PlayfairDisplay',
                            fontSize: isTablet ? 17 : 15,
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

  Widget _dialogDetailRow(String label, String value, Color maroon, Color gold, bool isTablet) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              color: gold,
              fontWeight: FontWeight.bold,
              fontSize: isTablet ? 16 : 14,
              fontFamily: 'PlayfairDisplay',
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: isTablet ? 16 : 14,
              fontFamily: 'PlayfairDisplay',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _proceedWithBooking() async {
    final Color maroon = const Color(0xFF420309);
    final Color gold = const Color(0xFFF1B24A);
    final message = _messageController.text.trim();
    final formattedDate =
        selectedDate != null ? DateFormat.yMMMMd().format(selectedDate!) : 'Not selected';
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600;

    try {
      await Supabase.instance.client.functions.invoke(
        'send-booking-email',
        body: {
          'time': selectedTime,
          'date': formattedDate,
          'message': message,
          'email': Supabase.instance.client.auth.currentUser?.email,
          'package': selectedPackage,
          'reader': selectedReader,
        },
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(horizontal: isTablet ? 80 : 40, vertical: isTablet ? 40 : 24),
            child: Container(
              padding: EdgeInsets.all(isTablet ? 32 : 24),
              decoration: BoxDecoration(
                color: maroon,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: gold, width: 2.0),
                boxShadow: [
                  BoxShadow(
                    color: gold.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(isTablet ? 20 : 16),
                    decoration: BoxDecoration(
                      color: gold.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle_outline,
                      color: gold,
                      size: isTablet ? 64 : 56,
                    ),
                  ),
                  SizedBox(height: isTablet ? 20 : 16),
                  Text(
                    'Booking Confirmed!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: gold,
                      fontSize: isTablet ? 26 : 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PlayfairDisplay',
                    ),
                  ),
                  SizedBox(height: isTablet ? 16 : 12),
                  Text(
                    'Your appointment has been successfully booked. We will contact you by email with the details.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isTablet ? 16 : 14,
                      fontFamily: 'PlayfairDisplay',
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: isTablet ? 24 : 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gold,
                        foregroundColor: maroon,
                        padding: EdgeInsets.symmetric(vertical: isTablet ? 16 : 14),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacementNamed(context, '/dashboard');
                      },
                      child: Text(
                        'OK',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PlayfairDisplay',
                          fontSize: isTablet ? 17 : 15,
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
      _showWarningDialog('Failed to send email: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color maroon = const Color(0xFF420309);
    final Color gold = const Color(0xFFF1B24A);
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: maroon,
      appBar: AppBar(
        backgroundColor: maroon,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: isTablet ? 16.0 : 8, vertical: 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: gold,
                    size: isTablet ? 28 : 24,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: isTablet ? 20 : 16),
              Text(
                'Book Appointment',
                style: TextStyle(
                  fontSize: isTablet ? 32 : 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PlayfairDisplay',
                  color: gold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
        top: isTablet ? 40 : 28,      // ⬅️ increase top spacing here
        left: isTablet ? screenWidth * 0.15 : 16,
        right: isTablet ? screenWidth * 0.15 : 16,
        bottom: isTablet ? 16 : 12,
      ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(isTablet ? 20 : 16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: gold.withOpacity(0.3), width: 1),
                      ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(isTablet ? 8 : 6),
                          decoration: BoxDecoration(
                            color: gold,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                            size: isTablet ? 20 : 18,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Schedule Details',
                          style: TextStyle(
                            color: gold,
                            fontFamily: 'PlayfairDisplay',
                            fontSize: isTablet ? 18 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isTablet ? 16 : 12),
                    _buildDetailRow(
                      'Date',
                      selectedDate != null ? DateFormat.yMMMMd().format(selectedDate!) : 'Not selected',
                      Icons.event,
                      maroon,
                      gold,
                      isTablet,
                      onTap: _pickDate,
                    ),
                    SizedBox(height: isTablet ? 12 : 10),
                    _buildDetailRow(
                      'Time',
                      selectedTime.isNotEmpty ? selectedTime : 'Not selected',
                      Icons.access_time,
                      maroon,
                      gold,
                      isTablet,
                      onTap: _pickTime,
                    ),
                  ],
                ),
              ),
              SizedBox(height: isTablet ? 16 : 12),
              Container(
                padding: EdgeInsets.all(isTablet ? 20 : 16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: gold.withOpacity(0.3), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(isTablet ? 8 : 6),
                          decoration: BoxDecoration(
                            color: gold,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.card_giftcard,
                            color: Colors.black,
                            size: isTablet ? 20 : 18,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Select Package',
                          style: TextStyle(
                            color: gold,
                            fontFamily: 'PlayfairDisplay',
                            fontSize: isTablet ? 18 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isTablet ? 16 : 12),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: gold,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 12),
                              child: DropdownButton<String>(
                                value: selectedPackage,
                                hint: Text(
                                  'Choose a package',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontFamily: 'PlayfairDisplay',
                                    fontSize: isTablet ? 16 : 14,
                                  ),
                                ),
                                dropdownColor: gold,
                                underline: const SizedBox(),
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down, color: Colors.black, size: isTablet ? 28 : 24),
                                onChanged: (value) {
                                  if (value != null) setState(() => selectedPackage = value);
                                },
                                items: packages.map((p) {
                                  return DropdownMenuItem<String>(
                                    value: p,
                                    child: Text(
                                      p,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'PlayfairDisplay',
                                        fontWeight: FontWeight.w600,
                                        fontSize: isTablet ? 16 : 14,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: gold,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.help_outline, color: Colors.black, size: isTablet ? 26 : 22),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const PackagesPage()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: isTablet ? 16 : 12),
              Container(
                padding: EdgeInsets.all(isTablet ? 20 : 16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: gold.withOpacity(0.3), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(isTablet ? 8 : 6),
                          decoration: BoxDecoration(
                            color: gold,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: isTablet ? 20 : 18,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Select Reader',
                          style: TextStyle(
                            color: gold,
                            fontFamily: 'PlayfairDisplay',
                            fontSize: isTablet ? 18 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isTablet ? 16 : 12),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: gold,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 12),
                              child: DropdownButton<String>(
                                value: selectedReader,
                                hint: Text(
                                  'Choose a reader',
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontFamily: 'PlayfairDisplay',
                                    fontSize: isTablet ? 16 : 14,
                                  ),
                                ),
                                dropdownColor: gold,
                                underline: const SizedBox(),
                                isExpanded: true,
                                icon: Icon(Icons.arrow_drop_down, color: Colors.black, size: isTablet ? 28 : 24),
                                onChanged: (value) {
                                  if (value != null) setState(() => selectedReader = value);
                                },
                                items: readers.map((r) {
                                  return DropdownMenuItem<String>(
                                    value: r,
                                    child: Text(
                                      r,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'PlayfairDisplay',
                                        fontWeight: FontWeight.w600,
                                        fontSize: isTablet ? 16 : 14,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: gold,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(Icons.help_outline, color: Colors.black, size: isTablet ? 26 : 22),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const TheReaderPage()));
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: isTablet ? 16 : 12),
              Container(
                padding: EdgeInsets.all(isTablet ? 20 : 16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: gold.withOpacity(0.3), width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(isTablet ? 8 : 6),
                          decoration: BoxDecoration(
                            color: gold,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.message,
                            color: Colors.black,
                            size: isTablet ? 20 : 18,
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Additional Message',
                          style: TextStyle(
                            color: gold,
                            fontFamily: 'PlayfairDisplay',
                            fontSize: isTablet ? 18 : 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: isTablet ? 16 : 12),
                    TextField(
                      controller: _messageController,
                      maxLines: 3,
                      style: TextStyle(
                        fontFamily: 'PlayfairDisplay',
                        fontSize: isTablet ? 15 : 13,
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Share any special requests...',
                        hintStyle: TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          color: Colors.black.withOpacity(0.5),
                          fontSize: isTablet ? 15 : 13,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: gold, width: 2),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 16 : 12,
                          vertical: isTablet ? 14 : 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                  ],
                ),
              ),
            ),
            SizedBox(height: isTablet ? 6 : 4),
            Container(
              width: double.infinity,
              height: isTablet ? 56 : 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: gold.withOpacity(0.3),
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
                  if (selectedReader == null) {
                    _showWarningDialog('Please choose a reader first');
                    return;
                  }
                  _showConfirmationDialog();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: gold,
                  foregroundColor: maroon,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'BOOK APPOINTMENT',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 17 : 15,
                    fontFamily: 'PlayfairDisplay',
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            SizedBox(height: isTablet ? 6 : 4),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon,
    Color maroon,
    Color gold,
    bool isTablet, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(isTablet ? 14 : 12),
        decoration: BoxDecoration(
          color: gold,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black, size: isTablet ? 22 : 20),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontFamily: 'PlayfairDisplay',
                      fontSize: isTablet ? 12 : 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'PlayfairDisplay',
                      fontSize: isTablet ? 15 : 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.edit, color: Colors.black.withOpacity(0.5), size: isTablet ? 18 : 16),
          ],
        ),
      ),
    );
  }
}