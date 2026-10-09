// import 'package:flutter/material.dart';

// class RoomsListScreen extends StatefulWidget {
//   final String floorName;
//   final List<dynamic> rooms;
//   final Map<int, bool> ledStates;
//   final Function(List<int> leds, bool state) onToggleLeds;
//   final bool Function(List<int> leds) isAnyLedOn;

//   const RoomsListScreen({
//     super.key,
//     required this.floorName,
//     required this.rooms,
//     required this.ledStates,
//     required this.onToggleLeds,
//     required this.isAnyLedOn,
//   });

//   @override
//   State<RoomsListScreen> createState() => _RoomsListScreenState();
// }

// class _RoomsListScreenState extends State<RoomsListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.floorName)),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 14,
//             mainAxisSpacing: 14,
//             childAspectRatio: 1.3,
//           ),
//           itemCount: widget.rooms.length,
//           itemBuilder: (context, index) {
//             final room = widget.rooms[index];
//             int ledIdx = room['led_index'];
//             bool isOn = widget.isAnyLedOn([ledIdx]);

//             return GestureDetector(
//               onTap: () {
//                 widget.onToggleLeds([ledIdx], !isOn);
//                 setState(() {});
//               },
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 decoration: BoxDecoration(
//                   color: isOn ? Colors.orange.shade400 : Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(
//                     color: isOn ? Colors.orange.shade700 : Colors.grey.shade300,
//                     width: 2,
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       isOn ? Icons.meeting_room : Icons.meeting_room_outlined,
//                       size: 32,
//                       color: isOn ? Colors.white : Colors.grey.shade700,
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       'Phòng ${room['room_number']}',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: isOn ? Colors.white : Colors.black87,
//                       ),
//                     ),
//                     Text(
//                       'Type ${room['room_type']} (LED #$ledIdx)',
//                       style: TextStyle(
//                         fontSize: 11,
//                         color: isOn ? Colors.white70 : Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class RoomsListScreen extends StatefulWidget {
  final String floorName;
  final List<dynamic> rooms;
  final Map<int, bool> ledStates;
  final Function(List<int> leds, bool state) onToggleLeds;
  final bool Function(List<int> leds) isAnyLedOn;

  const RoomsListScreen({
    super.key,
    required this.floorName,
    required this.rooms,
    required this.ledStates,
    required this.onToggleLeds,
    required this.isAnyLedOn,
  });

  @override
  State<RoomsListScreen> createState() => _RoomsListScreenState();
}

class _RoomsListScreenState extends State<RoomsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Ảnh nền
          Positioned.fill(
            child: Image.asset(
              'assets/images/room.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey.shade900,
                child: const Center(
                  child: Icon(Icons.meeting_room, size: 80, color: Colors.white24),
                ),
              ),
            ),
          ),

          // 2. Lớp phủ Gradient Tối
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.6),
                    Colors.black.withValues(alpha: 0.2),
                    Colors.black.withValues(alpha: 0.8),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),

          // 3. Nội dung giao diện
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: Text(
                          widget.floorName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [Shadow(blurRadius: 8, color: Colors.black)],
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),

                const Spacer(),

                // Khung điều khiển danh sách Căn Hộ
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Bật / Tắt Trực Tiếp Từng Căn Hộ:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Cuộn ngang danh sách Căn Hộ
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: widget.rooms.map((room) {
                              int ledIdx = room['led_index'];
                              bool isOn = widget.isAnyLedOn([ledIdx]);

                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    widget.onToggleLeds([ledIdx], !isOn);
                                    setState(() {});
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: isOn ? Colors.orange.shade600 : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isOn ? Colors.orange.shade800 : Colors.grey.shade300,
                                        width: 1.5,
                                      ),
                                      boxShadow: isOn
                                          ? [
                                              BoxShadow(
                                                color: Colors.orange.withValues(alpha: 0.3),
                                                blurRadius: 8,
                                                offset: const Offset(0, 3),
                                              )
                                            ]
                                          : [],
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          isOn ? Icons.lightbulb : Icons.meeting_room_outlined,
                                          size: 20,
                                          color: isOn ? Colors.white : Colors.grey.shade700,
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Căn ${room['room_number']}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: isOn ? Colors.white : Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              'Type ${room['room_type']} (LED #$ledIdx)',
                                              style: TextStyle(
                                                fontSize: 11,
                                                color: isOn ? Colors.white70 : Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Center(
                          child: Text(
                            '• Chạm 1 lần vào nút để Bật/Tắt LED của phòng',
                            style: TextStyle(fontSize: 11, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}