import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheets extends StatelessWidget {
  BottomSheets({Key? key}) : super(key: key);

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '만들기',
          style: TextStyle(fontSize: 16),
        ),
        IconButton(
          onPressed: Get.back,
          icon: Icon(Icons.close),
        )
      ],
    );
  }

  Widget _button({
    required IconData icon,
    required double size,
    required String text,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.withOpacity(0.3),
          ),
          child: Icon(
            icon,
            size: size,
          ),
        ),
        const SizedBox(width: 20),
        Text(text),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 20),
        height: 200,
        color: Colors.white,
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 10),
            _button(
                icon: Icons.cloud_upload_outlined,
                size: 35,
                text: 'upload',
                onTap: () {}),
            const SizedBox(height: 10),
            _button(
                icon: Icons.cast_outlined,
                size: 35,
                text: 'broadcast',
                onTap: () {}),
          ],
        ),
      ),
    );
  }
}
