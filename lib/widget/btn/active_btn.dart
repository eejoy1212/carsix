import 'package:flutter/material.dart';

class ActiveBtn extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final bool isSelected;

  const ActiveBtn({
    super.key,
    required this.onTap,
    required this.title,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          // 테두리와 배경
          Container(
            height: 76,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: isSelected
                    ? [
                        Color(0xFF6F0009), // 빨간색 시작
                        Color(0xFF272727), // 회색 끝
                      ]
                    : [
                        Color(0xFF1a1a1a),
                        Color(0xFF272727),
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Container(
              margin: EdgeInsets.all(2), // 보더 두께 (2px)
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: isSelected
                      ? [
                          Color(0xFF231616), // 배경 시작
                          Color(0x00231616), // 배경 끝 (투명)
                        ]
                      : [
                          Color(0xFF1b1b1b),
                          Color(0xFF1b1b1b),
                        ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // 텍스트
          Positioned.fill(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Color(0xFF6b6b6b), // 항상 흰색 텍스트
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
