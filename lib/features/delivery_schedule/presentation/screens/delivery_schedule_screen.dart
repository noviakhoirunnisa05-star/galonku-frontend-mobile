
import 'package:flutter/material.dart';

class DeliveryScheduleScreen extends StatefulWidget {
  const DeliveryScheduleScreen({super.key});

  @override
  State<DeliveryScheduleScreen> createState() =>
      _DeliveryScheduleScreenState();
}

class _DeliveryScheduleScreenState
    extends State<DeliveryScheduleScreen> {
  // COLORS
  static const Color primaryBlue = Color(0xFF0756C9);
  static const Color darkBlue = Color(0xFF19334F);
  static const Color backgroundColor = Color(0xFFFAF9FE);
  static const Color lightBlue = Color(0xFFDDF5FC);

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

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  // FORMAT BULAN
  String monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr',
      'Mei', 'Jun', 'Jul', 'Agu',
      'Sep', 'Okt', 'Nov', 'Des',
    ];

    return months[month - 1];
  }

  // FORMAT HARI
  String weekdayName(int weekday) {
    const weekdays = [
      'Senin', 'Selasa', 'Rabu', 'Kamis',
      'Jumat', 'Sabtu', 'Minggu',
    ];

    return weekdays[weekday - 1];
  }

  String get selectedTime {
    return timeSlots.firstWhere(
      (slot) => slot['id'] == selectedSlot,
    )['time']!;
  }

  String get selectedDateLabel {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final difference = selectedDate.difference(today).inDays;

    if (difference == 0) return 'Hari Ini';
    if (difference == 1) return 'Besok';

    return weekdayName(selectedDate.weekday);
  }

  List<DateTime> get availableDates {
    final now = DateTime.now();

    return List.generate(7, (index) {
      final date = now.add(Duration(days: index));

      return DateTime(date.year, date.month, date.day);
    });
  }

  // LABEL BAGIAN
  Widget sectionLabel(IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          color: primaryBlue,
          size: 15,
        ),
        const SizedBox(width: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: darkBlue,
          ),
        ),
      ],
    );
  }

  // HEADER
  Widget buildHeader() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFF0EFF5),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(
              minWidth: 35,
              minHeight: 35,
            ),
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkBlue,
              size: 19,
            ),
          ),
          const Expanded(
            child: Text(
              'Waktu Kirim Galonku',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
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

  // INTRO CARD
  Widget buildIntro() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2FC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFD2F0FA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.water_drop,
              color: Color(0xFF087B91),
              size: 20,
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
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Kurir siap antar & jemput galon tepat waktu',
                  style: TextStyle(
                    fontSize: 9,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // DATE PICKER
  Widget buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionLabel(
          Icons.calendar_month_outlined,
          'Tanggal Pengantaran',
        ),
        const SizedBox(height: 7),
        Container(
          height: 43,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F3FC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color(0xFFE4E7F2),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<DateTime>(
              value: selectedDate,
              isExpanded: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                size: 19,
              ),
              items: availableDates.map((date) {
                final now = DateTime.now();
                final today = DateTime(
                  now.year,
                  now.month,
                  now.day,
                );

                final difference = date.difference(today).inDays;

                String label;

                if (difference == 0) {
                  label = 'Hari Ini';
                } else if (difference == 1) {
                  label = 'Besok';
                } else {
                  label = weekdayName(date.weekday);
                }

                return DropdownMenuItem<DateTime>(
                  value: date,
                  child: Text(
                    '$label (${date.day} ${monthName(date.month)})',
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
      ],
    );
  }

  // TIME PICKER
  Widget buildTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionLabel(
          Icons.access_time,
          'Pilih Jam Pengantaran',
        ),
        const SizedBox(height: 7),
        Row(
          children: timeSlots.map((slot) {
            final selected = selectedSlot == slot['id'];

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 6),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    setState(() {
                      selectedSlot = slot['id']!;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    height: 55,
                    decoration: BoxDecoration(
                      color: selected
                          ? primaryBlue
                          : const Color(0xFFF1F2FA),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selected
                            ? primaryBlue
                            : const Color(0xFFE6E8F2),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          slot['time']!,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: selected
                                ? Colors.white
                                : darkBlue,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (selected)
                              const Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                                size: 10,
                              ),
                            if (selected)
                              const SizedBox(width: 3),
                            Text(
                              slot['label']!,
                              style: TextStyle(
                                fontSize: 8,
                                color: selected
                                    ? Colors.white
                                    : Colors.black54,
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
    );
  }

  // DATE AND TIME CARD
  Widget buildScheduleCard() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFFECECF3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildDatePicker(),
          const SizedBox(height: 11),
          buildTimePicker(),
        ],
      ),
    );
  }

  // QUICK NOTE
  void toggleQuickNote(String note) {
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

  // NOTES CARD
  Widget buildNotes() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFFECECF3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              sectionLabel(
                Icons.edit_note,
                'Catatan Pengiriman',
              ),
              const Text(
                'Opsional',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          TextField(
            controller: noteController,
            minLines: 3,
            maxLines: 3,
            maxLength: 200,
            style: const TextStyle(
              fontSize: 10,
              color: darkBlue,
            ),
            decoration: InputDecoration(
              hintText: 'Tulis catatan pengiriman...',
              hintStyle: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
              ),
              counterText: '',
              filled: true,
              fillColor: const Color(0xFFF1F2FC),
              contentPadding: const EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFFE8EAF3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: primaryBlue,
                ),
              ),
            ),
          ),
          const SizedBox(height: 7),
          Wrap(
            spacing: 5,
            runSpacing: 6,
            children: quickNotes.map((note) {
              final selected = selectedNotes.contains(note);

              return InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () => toggleQuickNote(note),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFFDCEEFF)
                        : const Color(0xFFF0F1F8),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? primaryBlue
                          : const Color(0xFFE7E8F0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        selected
                            ? Icons.check_circle
                            : Icons.add,
                        size: 10,
                        color: selected
                            ? primaryBlue
                            : darkBlue,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        note,
                        style: TextStyle(
                          fontSize: 8,
                          color: selected
                              ? primaryBlue
                              : darkBlue,
                          fontWeight: selected
                              ? FontWeight.bold
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

  // HYGIENE BANNER
  Widget buildGuarantee() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFFBDE9F7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified_user_outlined,
              color: Color(0xFF087B91),
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
                  'Tutup galon disanitasi dengan segel ganda & botol disteril sebelum dikirim.',
                  style: TextStyle(
                    fontSize: 8,
                    height: 1.3,
                    color: Color(0xFF506274),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // SUMMARY
  Widget buildSummary() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Jadwal Dipilih',
                style: TextStyle(
                  fontSize: 9,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    size: 13,
                    color: primaryBlue,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '$selectedDateLabel, ${selectedDate.day} ${monthName(selectedDate.month)} • $selectedTime',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 9,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFD7F5E6),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'Bebas Atur',
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Color(0xFF087B46),
            ),
          ),
        ),
      ],
    );
  }

  // SAVE SCHEDULE
  void saveSchedule() {
    final note = noteController.text.trim();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Jadwal Berhasil Dipilih',
            style: TextStyle(fontSize: 15),
          ),
          content: Text(
            'Pengantaran: $selectedDateLabel, '
            '${selectedDate.day} ${monthName(selectedDate.month)}\n'
            'Jam: $selectedTime'
            '${note.isEmpty ? '' : '\nCatatan: $note'}',
            style: const TextStyle(
              fontSize: 12,
              height: 1.5,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Mengerti',
                style: TextStyle(color: primaryBlue),
              ),
            ),
          ],
        );
      },
    );
  }

  // BOTTOM SECTION
  Widget buildBottomSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 9, 14, 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFECECF3),
            width: 0.8,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildSummary(),
          const SizedBox(height: 9),
          SizedBox(
            width: double.infinity,
            height: 43,
            child: ElevatedButton(
              onPressed: saveSchedule,
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryBlue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Simpan Jadwal',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MAIN SCREEN
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(),

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
                            14, 7, 14, 14,
                          ),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                            children: [
                              // INTRO
                              buildIntro(),

                              const SizedBox(height: 9),

                              // DATE AND TIME
                              buildScheduleCard(),

                              const SizedBox(height: 9),

                              // NOTES
                              buildNotes(),

                              // SPACE RESPONSIF:
                              // MENDORONG BANNER KE BAGIAN BAWAH
                              // TANPA MENINGGALKAN KOSONGAN BESAR.
                              const Spacer(),

                              const SizedBox(height: 12),

                              // HYGIENE BANNER
                              buildGuarantee(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // SUMMARY DAN BUTTON MENEMPEL DI BAWAH
            buildBottomSection(),
          ],
        ),
      ),
    );
  }
}
