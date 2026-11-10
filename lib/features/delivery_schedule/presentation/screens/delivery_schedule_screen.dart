
import 'package:flutter/material.dart';

class DeliveryScheduleScreen extends StatefulWidget {
  const DeliveryScheduleScreen({super.key});

  @override
  State<DeliveryScheduleScreen> createState() =>
      _DeliveryScheduleScreenState();
}

class _DeliveryScheduleScreenState
    extends State<DeliveryScheduleScreen> {
  static const Color primaryBlue = Color(0xFF0756C9);
  static const Color darkBlue = Color(0xFF172337);
  static const Color background = Color(0xFFFAF9FF);
  static const Color lightBlue = Color(0xFFDDF5FF);
  static const Color softPurple = Color(0xFFF0F1FC);
  static const Color pinkBorder = Color(0xFFF0A0A5);

  late DateTime selectedDate;

  String selectedSlot = 'afternoon';

  final TextEditingController noteController =
      TextEditingController();

  final Set<String> selectedNotes = {};

  final List<Map<String, String>> timeSlots = [
    {
      'id': 'morning',
      'time': '09:00 - 11:00',
      'label': 'Slot Pagi',
    },
    {
      'id': 'afternoon',
      'time': '14:30 - 15:30',
      'label': 'Dipilih',
    },
  ];

  final List<String> quickNotes = [
    'Titip satpam',
    'Taruh di depan pintu',
    'Hubungi sebelum tiba',
  ];

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    selectedDate = DateTime(now.year, now.month, now.day);
  }

  // FORMAT TANGGAL INDONESIA

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr',
      'Mei', 'Jun', 'Jul', 'Agu',
      'Sep', 'Okt', 'Nov', 'Des',
    ];

    return months[month - 1];
  }

  String _weekdayName(int weekday) {
    const weekdays = [
      'Senin', 'Selasa', 'Rabu', 'Kamis',
      'Jumat', 'Sabtu', 'Minggu',
    ];

    return weekdays[weekday - 1];
  }

  String _dateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final difference = date.difference(today).inDays;

    if (difference == 0) {
      return 'Hari Ini (${date.day} ${_monthName(date.month)})';
    }

    if (difference == 1) {
      return 'Besok (${date.day} ${_monthName(date.month)})';
    }

    return '${_weekdayName(date.weekday)} (${date.day} ${_monthName(date.month)})';
  }

  List<DateTime> get availableDates {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return List.generate(
      7,
      (index) => today.add(Duration(days: index)),
    );
  }

  String get selectedTime {
    return timeSlots.firstWhere(
      (slot) => slot['id'] == selectedSlot,
    )['time']!;
  }

  String get summaryDate {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final difference = selectedDate.difference(today).inDays;

    String prefix;

    if (difference == 0) {
      prefix = 'Hari Ini';
    } else if (difference == 1) {
      prefix = 'Besok';
    } else {
      prefix = _weekdayName(selectedDate.weekday);
    }

    return '$prefix, ${selectedDate.day} ${_monthName(selectedDate.month)}';
  }

  // HEADER

  Widget _buildHeader() {
    return Container(
      height: 47,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(
        color: Color(0xFFFCFAFF),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 35,
            child: IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tidak ada halaman sebelumnya.'),
                    ),
                  );
                }
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 20,
                color: darkBlue,
              ),
            ),
          ),
          const Expanded(
            child: Text(
              'Waktu Kirim Galonku',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: darkBlue,
              ),
            ),
          ),
          const SizedBox(width: 35),
        ],
      ),
    );
  }

  // KARTU INTRO

  Widget _buildIntroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: softPurple,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFBDEBFA),
              borderRadius: BorderRadius.circular(11),
            ),
            child: const Icon(
              Icons.water_drop,
              color: Color(0xFF087B91),
              size: 21,
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pilih Jadwal Pengantaran',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Kurir siap antar & jemput galon tepat waktu',
                  style: TextStyle(
                    fontSize: 9,
                    color: Color(0xFF687080),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // LABEL FORM

  Widget _sectionLabel(IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: primaryBlue,
        ),
        const SizedBox(width: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: darkBlue,
          ),
        ),
      ],
    );
  }

  // KARTU TANGGAL DAN JAM

  Widget _buildScheduleCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFECECF3),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TANGGAL

          _sectionLabel(
            Icons.calendar_today_outlined,
            'Tanggal Pengantaran',
          ),

          const SizedBox(height: 6),

          Container(
            height: 41,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: softPurple,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFFDDE0F0),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<DateTime>(
                value: selectedDate,
                isExpanded: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 19,
                  color: darkBlue,
                ),
                borderRadius: BorderRadius.circular(10),
                items: availableDates.map((date) {
                  return DropdownMenuItem<DateTime>(
                    value: date,
                    child: Text(
                      _dateLabel(date),
                      style: const TextStyle(
                        fontSize: 10,
                        color: darkBlue,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (date) {
                  if (date != null) {
                    setState(() {
                      selectedDate = date;
                    });
                  }
                },
              ),
            ),
          ),

          const SizedBox(height: 11),

          // JAM PENGANTARAN

          _sectionLabel(
            Icons.access_time,
            'Pilih Jam Pengantaran',
          ),

          const SizedBox(height: 7),

          Row(
            children: timeSlots.map((slot) {
              final isSelected = selectedSlot == slot['id'];

              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: slot['id'] == 'morning' ? 7 : 0,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(11),
                    onTap: () {
                      setState(() {
                        selectedSlot = slot['id']!;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      height: 54,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? primaryBlue
                            : softPurple,
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(
                          color: isSelected
                              ? primaryBlue
                              : const Color(0xFFDDE0F0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            slot['time']!,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : darkBlue,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isSelected)
                                const Icon(
                                  Icons.check_circle_outline,
                                  size: 10,
                                  color: Colors.white,
                                ),
                              if (isSelected)
                                const SizedBox(width: 3),
                              Text(
                                isSelected
                                    ? 'Dipilih'
                                    : slot['label']!,
                                style: TextStyle(
                                  fontSize: 9,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF737887),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // KARTU CATATAN

  Widget _buildNotesCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFECECF3),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _sectionLabel(
                Icons.edit_note,
                'Catatan Pengiriman',
              ),
              const Spacer(),
              const Text(
                'Opsional',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF737887),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // TEXT FIELD

          TextField(
            controller: noteController,
            maxLines: 3,
            minLines: 3,
            maxLength: 200,
            style: const TextStyle(
              fontSize: 11,
              color: darkBlue,
            ),
            decoration: InputDecoration(
              hintText: 'Tulis catatan...',
              hintStyle: const TextStyle(
                fontSize: 10,
                color: Color(0xFF9298A6),
              ),
              counterText: '',
              filled: true,
              fillColor: softPurple,
              contentPadding: const EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFFDDE0F0),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: primaryBlue,
                  width: 1.2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // CHIP CATATAN CEPAT

          Wrap(
            spacing: 5,
            runSpacing: 6,
            children: quickNotes.map((note) {
              final isSelected = selectedNotes.contains(note);

              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  _toggleQuickNote(note);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFDCEBFF)
                        : softPurple,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? primaryBlue
                          : const Color(0xFFE1E3EF),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSelected ? Icons.check : Icons.add,
                        size: 10,
                        color: isSelected
                            ? primaryBlue
                            : darkBlue,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        note,
                        style: TextStyle(
                          fontSize: 9,
                          color: isSelected
                              ? primaryBlue
                              : darkBlue,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // FUNGSI CHIP CATATAN

  void _toggleQuickNote(String note) {
    setState(() {
      final lines = noteController.text
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .toList();

      if (selectedNotes.contains(note)) {
        selectedNotes.remove(note);
        lines.remove(note);
      } else {
        selectedNotes.add(note);

        if (!lines.contains(note)) {
          lines.add(note);
        }
      }

      noteController.text = lines.join('\n');

      noteController.selection = TextSelection.collapsed(
        offset: noteController.text.length,
      );
    });
  }

  // JAMINAN HIGIENIS

  Widget _buildGuarantee() {
    return InkWell(
      borderRadius: BorderRadius.circular(11),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Jaminan Higienis & Punctual',
              style: TextStyle(fontSize: 15),
            ),
            content: const Text(
              'Tutup galon disanitasi dengan segel ganda dan botol disteril sebelum dikirim.',
              style: TextStyle(fontSize: 12),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Mengerti'),
              ),
            ],
          ),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: lightBlue,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: Color(0xFF087B91),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.settings_outlined,
                color: Colors.white,
                size: 17,
              ),
            ),
            const SizedBox(width: 9),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jaminan Higienis & Punctual',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Tutup galon sanitasi disegel ganda & botol disteril sebelum dikirim.',
                    style: TextStyle(
                      fontSize: 9,
                      height: 1.35,
                      color: Color(0xFF526274),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FOOTER RINGKASAN

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 9, 10, 10),
      decoration: const BoxDecoration(
        color: Color(0xFFFCFBFF),
        border: Border(
          top: BorderSide(
            color: Color(0xFFECECF3),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text(
                'Jadwal Dipilih',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF737887),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF087B46),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Bebas Atur',
                  style: TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 3),

          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: primaryBlue,
                size: 13,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  '$summaryDate • $selectedTime',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 9),

          SizedBox(
            width: double.infinity,
            height: 41,
            child: ElevatedButton(
              onPressed: _saveSchedule,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Simpan Jadwal',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SIMPAN JADWAL

  void _saveSchedule() {
    final note = noteController.text.trim();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Jadwal Berhasil Dipilih',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ],
          ),
          content: Text(
            'Tanggal: $summaryDate\n'
            'Jam: $selectedTime\n'
            'Catatan: ${note.isEmpty ? "-" : note}',
            style: const TextStyle(
              fontSize: 12,
              height: 1.6,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Mengerti',
                style: TextStyle(
                  color: primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // TAMPILAN UTAMA

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pinkBorder,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(7),
          child: Container(
            color: background,
            child: Column(
              children: [
                // HEADER TETAP
                _buildHeader(),

                // KONTEN RESPONSIF
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: constraints.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                10, 5, 10, 10,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  _buildIntroCard(),

                                  const SizedBox(height: 10),

                                  _buildScheduleCard(),

                                  const SizedBox(height: 10),

                                  _buildNotesCard(),

                                  // RUANG KOSONG SEPERTI FIGMA
                                  const Spacer(),

                                  _buildGuarantee(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // FOOTER TETAP DI BAWAH
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }
}
