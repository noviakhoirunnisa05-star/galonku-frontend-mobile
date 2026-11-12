
import 'package:flutter/material.dart';

class AddressHeader extends StatelessWidget {
  final String userName;
  final String address;
  final VoidCallback? onChangeAddress;

  const AddressHeader({
    super.key,
    this.userName = 'Rosi',
    this.address = 'Kost Sakura, Kamar 204',
    this.onChangeAddress,
  });

  static const Color primaryBlue = Color(0xFF0756C9);
  static const Color darkText = Color(0xFF172337);

  Widget buildProfileImage() {
    return ClipOval(
      child: Image.asset(
        'assets/images/profile.png',
        width: 38,
        height: 38,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Profile gagal dimuat: $error');

          return Container(
            width: 38,
            height: 38,
            color: const Color(0xFFE7EEFF),
            child: const Icon(
              Icons.person,
              color: primaryBlue,
              size: 23,
            ),
          );
        },
      ),
    );
  }

  Widget buildLogo() {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.water_drop,
          color: primaryBlue,
          size: 25,
        ),
        SizedBox(width: 7),
        Text(
          'GalonKu',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
      ],
    );
  }

  Widget buildUserProfile() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          userName,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: darkText,
          ),
        ),
        const SizedBox(width: 9),
        buildProfileImage(),
      ],
    );
  }

  Widget buildAddress(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.location_on_outlined,
          color: primaryBlue,
          size: 19,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'Kirim ke: $address',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              color: darkText,
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: () {
            if (onChangeAddress != null) {
              onChangeAddress!();
            } else {
              showDialog<void>(
                context: context,
                builder: (dialogContext) {
                  return AlertDialog(
                    title: const Text('Ubah Alamat'),
                    content: Text(address),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                        },
                        child: const Text('Tutup'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 6,
            ),
            child: Text(
              'Ubah',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: primaryBlue,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildLogo(),
              buildUserProfile(),
            ],
          ),
          const SizedBox(height: 14),
          buildAddress(context),
        ],
      ),
    );
  }
}
