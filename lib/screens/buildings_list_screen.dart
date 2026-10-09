// import 'package:flutter/material.dart';
// import 'floors_list_screen.dart';

// class BuildingsListScreen extends StatefulWidget {
//   final List<Map<String, dynamic>> buildings;
//   final Map<int, bool> ledStates;
//   final Function(List<int> leds, bool state) onToggleLeds;
//   final bool Function(List<int> leds) isAnyLedOn;
//   final List<int> Function(List<dynamic> rooms, {int? filterRoomType}) extractLeds;
//   final int selectedFilterType;

//   const BuildingsListScreen({
//     super.key,
//     required this.buildings,
//     required this.ledStates,
//     required this.onToggleLeds,
//     required this.isAnyLedOn,
//     required this.extractLeds,
//     required this.selectedFilterType,
//   });

//   @override
//   State<BuildingsListScreen> createState() => _BuildingsListScreenState();
// }

// class _BuildingsListScreenState extends State<BuildingsListScreen> {
//   List<int> _getBuildingLeds(Map<String, dynamic> building) {
//     List<int> leds = [];
//     for (var f in building['floors']) {
//       leds.addAll(widget.extractLeds(f['rooms'], filterRoomType: widget.selectedFilterType));
//     }
//     return leds;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Danh Sách Tòa Nhà')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 16,
//             mainAxisSpacing: 16,
//             childAspectRatio: 1.1,
//           ),
//           itemCount: widget.buildings.length,
//           itemBuilder: (context, index) {
//             final b = widget.buildings[index];
//             List<int> bLeds = _getBuildingLeds(b);
//             bool isOn = widget.isAnyLedOn(bLeds);

//             return GestureDetector(
//               onTap: () {
//                 widget.onToggleLeds(bLeds, !isOn);
//                 setState(() {});
//               },
//               onDoubleTap: () async {
//                 await Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => FloorsListScreen(
//                       buildingName: b['name'],
//                       floors: b['floors'],
//                       ledStates: widget.ledStates,
//                       onToggleLeds: widget.onToggleLeds,
//                       isAnyLedOn: widget.isAnyLedOn,
//                       extractLeds: widget.extractLeds,
//                       selectedFilterType: widget.selectedFilterType,
//                     ),
//                   ),
//                 );
//                 setState(() {});
//               },
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 decoration: BoxDecoration(
//                   color: isOn ? Colors.orange.shade400 : Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: isOn ? Colors.orange : Colors.grey.shade300, width: 2),
//                   boxShadow: [
//                     BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 3)),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.apartment,
//                       size: 40,
//                       color: isOn ? Colors.white : Colors.teal,
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       b['name'],
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: isOn ? Colors.white : Colors.black87,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       isOn ? 'TRẠNG THÁI: BẬT' : 'TRẠNG THÁI: TẮT',
//                       style: TextStyle(fontSize: 12, color: isOn ? Colors.white70 : Colors.grey),
//                     ),
//                     Text(
//                       '(${bLeds.length} phòng)',
//                       style: TextStyle(fontSize: 11, color: isOn ? Colors.white70 : Colors.grey.shade600),
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
import 'floors_list_screen.dart';

class BuildingsListScreen extends StatefulWidget {
  final List<Map<String, dynamic>> buildings;
  final Map<int, bool> ledStates;
  final Function(List<int> leds, bool state) onToggleLeds;
  final bool Function(List<int> leds) isAnyLedOn;
  final List<int> Function(List<dynamic> rooms, {int? filterRoomType}) extractLeds;
  final int selectedFilterType;

  const BuildingsListScreen({
    super.key,
    required this.buildings,
    required this.ledStates,
    required this.onToggleLeds,
    required this.isAnyLedOn,
    required this.extractLeds,
    required this.selectedFilterType,
  });

  @override
  State<BuildingsListScreen> createState() => _BuildingsListScreenState();
}

class _BuildingsListScreenState extends State<BuildingsListScreen> {
  List<int> _getBuildingLeds(Map<String, dynamic> building) {
    List<int> leds = [];
    for (var f in building['floors']) {
      leds.addAll(widget.extractLeds(f['rooms'], filterRoomType: widget.selectedFilterType));
    }
    return leds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Ảnh nền Tòa nhà full màn hình
          // Positioned.fill(
          //   child: Image.asset(
          //     'assets/images/building.jpg',
          //     fit: BoxFit.cover,
          //     errorBuilder: (context, error, stackTrace) => Container(
          //       color: Colors.grey.shade900,
          //       child: const Center(
          //         child: Icon(Icons.apartment, size: 80, color: Colors.white24),
          //       ),
          //     ),
          //   ),
          // ),
          // 1. Ảnh nền FULL 100% màn hình (Bắt buộc dùng BoxFit.fill hoặc BoxFit.cover)
          Positioned.fill(
            child: Image.asset(
              'assets/images/building.jpg',
              fit: BoxFit.fill, // Tràn phẳng tuyệt đối cả chiều rộng lẫn chiều cao
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade900),
            ),
          ),

          // 2. Lớp phủ Gradient Tối làm nổi bật chữ & khung điều khiển
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
                // Top Bar: Tiêu đề
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Expanded(
                        child: Text(
                          'Danh Sách Tòa Nhà',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [Shadow(blurRadius: 8, color: Colors.black)],
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Cân bằng không gian với nút Back
                    ],
                  ),
                ),

                const Spacer(),

                // Khung điều khiển danh sách Tòa Nhà ở phía dưới
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
                          'Chọn Tòa Nhà Để Điều Khiển:',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Danh sách Tòa Nhà nằm ngang gọn gàng
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: widget.buildings.map((b) {
                              List<int> bLeds = _getBuildingLeds(b);
                              bool isOn = widget.isAnyLedOn(bLeds);

                              return Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    widget.onToggleLeds(bLeds, !isOn);
                                    setState(() {});
                                  },
                                  onDoubleTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FloorsListScreen(
                                          buildingName: b['name'],
                                          floors: b['floors'],
                                          ledStates: widget.ledStates,
                                          onToggleLeds: widget.onToggleLeds,
                                          isAnyLedOn: widget.isAnyLedOn,
                                          extractLeds: widget.extractLeds,
                                          selectedFilterType: widget.selectedFilterType,
                                        ),
                                      ),
                                    );
                                    setState(() {});
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: isOn ? const Color(0xFF009688) : Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: isOn ? Colors.teal.shade700 : Colors.grey.shade300,
                                        width: 1.5,
                                      ),
                                      boxShadow: isOn
                                          ? [
                                              BoxShadow(
                                                color: Colors.teal.withValues(alpha: 0.3),
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
                                          isOn ? Icons.lightbulb : Icons.apartment,
                                          size: 20,
                                          color: isOn ? Colors.white : Colors.grey.shade700,
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              b['name'],
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: isOn ? Colors.white : Colors.black87,
                                              ),
                                            ),
                                            Text(
                                              '${bLeds.length} phòng • ${isOn ? "ĐANG BẬT" : "TẮT"}',
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
                            '• Chạm 1 lần: Bật/Tắt Tòa  |  • Nhấn đúp 2 lần: Xem danh sách tầng',
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