// // // import 'package:flutter/material.dart';
// // // import 'rooms_list_screen.dart';

// // // class FloorsListScreen extends StatefulWidget {
// // //   final String buildingName;
// // //   final List<dynamic> floors;
// // //   final Map<int, bool> ledStates;
// // //   final Function(List<int> leds, bool state) onToggleLeds;
// // //   final bool Function(List<int> leds) isAnyLedOn;
// // //   final List<int> Function(List<dynamic> rooms, {int? filterRoomType}) extractLeds;
// // //   final int selectedFilterType;

// // //   const FloorsListScreen({
// // //     super.key,
// // //     required this.buildingName,
// // //     required this.floors,
// // //     required this.ledStates,
// // //     required this.onToggleLeds,
// // //     required this.isAnyLedOn,
// // //     required this.extractLeds,
// // //     required this.selectedFilterType,
// // //   });

// // //   @override
// // //   State<FloorsListScreen> createState() => _FloorsListScreenState();
// // // }

// // // class _FloorsListScreenState extends State<FloorsListScreen> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(title: Text(widget.buildingName)),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: GridView.builder(
// // //           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// // //             crossAxisCount: 2,
// // //             crossAxisSpacing: 16,
// // //             mainAxisSpacing: 16,
// // //             childAspectRatio: 1.2,
// // //           ),
// // //           itemCount: widget.floors.length,
// // //           itemBuilder: (context, index) {
// // //             final f = widget.floors[index];
// // //             List<int> fLeds = widget.extractLeds(f['rooms'], filterRoomType: widget.selectedFilterType);
// // //             bool isOn = widget.isAnyLedOn(fLeds);

// // //             return GestureDetector(
// // //               onTap: () {
// // //                 widget.onToggleLeds(fLeds, !isOn);
// // //                 setState(() {});
// // //               },
// // //               onDoubleTap: () async {
// // //                 await Navigator.push(
// // //                   context,
// // //                   MaterialPageRoute(
// // //                     builder: (context) => RoomsListScreen(
// // //                       floorName: '${widget.buildingName} - ${f['name']}',
// // //                       rooms: f['rooms'],
// // //                       ledStates: widget.ledStates,
// // //                       onToggleLeds: widget.onToggleLeds,
// // //                       isAnyLedOn: widget.isAnyLedOn,
// // //                     ),
// // //                   ),
// // //                 );
// // //                 setState(() {});
// // //               },
// // //               child: AnimatedContainer(
// // //                 duration: const Duration(milliseconds: 200),
// // //                 decoration: BoxDecoration(
// // //                   color: isOn ? Colors.amber.shade600 : Colors.white,
// // //                   borderRadius: BorderRadius.circular(14),
// // //                   border: Border.all(color: isOn ? Colors.amber : Colors.grey.shade300, width: 2),
// // //                 ),
// // //                 child: Column(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     Icon(Icons.layers, size: 36, color: isOn ? Colors.white : Colors.teal),
// // //                     const SizedBox(height: 6),
// // //                     Text(
// // //                       f['name'],
// // //                       style: TextStyle(
// // //                         fontSize: 16,
// // //                         fontWeight: FontWeight.bold,
// // //                         color: isOn ? Colors.white : Colors.black87,
// // //                       ),
// // //                     ),
// // //                     Text(
// // //                       '${fLeds.length} Phòng',
// // //                       style: TextStyle(fontSize: 12, color: isOn ? Colors.white70 : Colors.grey),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             );
// // //           },
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }


// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/services.dart'; // Bắt buộc import thư viện này
// // // import 'rooms_list_screen.dart';

// // // class FloorsListScreen extends StatefulWidget {
// // //   final String buildingName;
// // //   final List<dynamic> floors;
// // //   final Map<int, bool> ledStates;
// // //   final Function(List<int> leds, bool state) onToggleLeds;
// // //   final bool Function(List<int> leds) isAnyLedOn;
// // //   final List<int> Function(List<dynamic> rooms, {int? filterRoomType}) extractLeds;
// // //   final int selectedFilterType;

// // //   const FloorsListScreen({
// // //     super.key,
// // //     required this.buildingName,
// // //     required this.floors,
// // //     required this.ledStates,
// // //     required this.onToggleLeds,
// // //     required this.isAnyLedOn,
// // //     required this.extractLeds,
// // //     required this.selectedFilterType,
// // //   });

// // //   @override
// // //   State<FloorsListScreen> createState() => _FloorsListScreenState();
// // // }

// // // class _FloorsListScreenState extends State<FloorsListScreen> {
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     // BẬT CHẾ ĐỘ FULL SCREEN 100% (Ẩn hẳn thanh Pin/Giờ và thanh gạch dưới)
// // //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       // BẮT BUỘC: Không dùng Padding hay Container bọc ngoài Stack ở đây!
// // //       body: Stack(
// // //         fit: StackFit.expand, // Ép Stack kéo giãn tối đa toàn bộ màn hình
// // //         children: [
// // //           // 1. Ảnh nền floor.jpg TRÀN KHÔNG KẼ HỞ
// // //           Positioned.fill(
// // //             child: Image.asset(
// // //               'assets/images/floor.jpg',
// // //               fit: BoxFit.fill, // Dãn tràn tuyệt đối cả chiều dài lẫn rộng
// // //               errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade900),
// // //             ),
// // //           ),

// // //           // 2. Lớp phủ Gradient Tối
// // //           Positioned.fill(
// // //             child: Container(
// // //               decoration: BoxDecoration(
// // //                 gradient: LinearGradient(
// // //                   begin: Alignment.topCenter,
// // //                   end: Alignment.bottomCenter,
// // //                   colors: [
// // //                     Colors.black.withValues(alpha: 0.6),
// // //                     Colors.transparent,
// // //                     Colors.black.withValues(alpha: 0.8),
// // //                   ],
// // //                   stops: const [0.0, 0.5, 1.0],
// // //                 ),
// // //               ),
// // //             ),
// // //           ),

// // //           // 3. Các nút điều khiển & Tiêu đề
// // //           SafeArea(
// // //             child: Column(
// // //               children: [
// // //                 // Thanh tiêu đề Top Bar
// // //                 Padding(
// // //                   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
// // //                   child: Row(
// // //                     children: [
// // //                       CircleAvatar(
// // //                         backgroundColor: Colors.black45,
// // //                         child: IconButton(
// // //                           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
// // //                           onPressed: () => Navigator.pop(context),
// // //                         ),
// // //                       ),
// // //                       Expanded(
// // //                         child: Text(
// // //                           widget.buildingName,
// // //                           textAlign: TextAlign.center,
// // //                           style: const TextStyle(
// // //                             fontSize: 22,
// // //                             fontWeight: FontWeight.bold,
// // //                             color: Colors.white,
// // //                             shadows: [Shadow(blurRadius: 10, color: Colors.black)],
// // //                           ),
// // //                         ),
// // //                       ),
// // //                       const SizedBox(width: 40),
// // //                     ],
// // //                   ),
// // //                 ),

// // //                 const Spacer(), // Đẩy khung điều khiển xuống sát đáy

// // //                 // Khung danh sách Tầng
// // //                 Padding(
// // //                   padding: const EdgeInsets.all(16.0),
// // //                   child: Container(
// // //                     padding: const EdgeInsets.all(16),
// // //                     decoration: BoxDecoration(
// // //                       color: Colors.white.withValues(alpha: 0.92),
// // //                       borderRadius: BorderRadius.circular(20),
// // //                       boxShadow: const [
// // //                         BoxShadow(
// // //                           color: Colors.black38,
// // //                           blurRadius: 16,
// // //                           offset: Offset(0, 6),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                     child: Column(
// // //                       crossAxisAlignment: CrossAxisAlignment.start,
// // //                       mainAxisSize: MainAxisSize.min,
// // //                       children: [
// // //                         const Text(
// // //                           'Chọn Tầng Để Điều Khiển:',
// // //                           style: TextStyle(
// // //                             fontSize: 15,
// // //                             fontWeight: FontWeight.bold,
// // //                             color: Colors.black87,
// // //                           ),
// // //                         ),
// // //                         const SizedBox(height: 12),
// // //                         SingleChildScrollView(
// // //                           scrollDirection: Axis.horizontal,
// // //                           child: Row(
// // //                             children: widget.floors.map((f) {
// // //                               List<int> fLeds = widget.extractLeds(f['rooms'], filterRoomType: widget.selectedFilterType);
// // //                               bool isOn = widget.isAnyLedOn(fLeds);

// // //                               return Padding(
// // //                                 padding: const EdgeInsets.only(right: 10.0),
// // //                                 child: InkWell(
// // //                                   onTap: () {
// // //                                     widget.onToggleLeds(fLeds, !isOn);
// // //                                     setState(() {});
// // //                                   },
// // //                                   onDoubleTap: () async {
// // //                                     await Navigator.push(
// // //                                       context,
// // //                                       MaterialPageRoute(
// // //                                         builder: (context) => RoomsListScreen(
// // //                                           floorName: '${widget.buildingName} - ${f['name']}',
// // //                                           rooms: f['rooms'],
// // //                                           ledStates: widget.ledStates,
// // //                                           onToggleLeds: widget.onToggleLeds,
// // //                                           isAnyLedOn: widget.isAnyLedOn,
// // //                                         ),
// // //                                       ),
// // //                                     );
// // //                                     setState(() {});
// // //                                   },
// // //                                   borderRadius: BorderRadius.circular(12),
// // //                                   child: Container(
// // //                                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// // //                                     decoration: BoxDecoration(
// // //                                       color: isOn ? Colors.orange.shade600 : Colors.grey.shade100,
// // //                                       borderRadius: BorderRadius.circular(12),
// // //                                       border: Border.all(
// // //                                         color: isOn ? Colors.orange.shade800 : Colors.grey.shade300,
// // //                                         width: 1.5,
// // //                                       ),
// // //                                     ),
// // //                                     child: Row(
// // //                                       mainAxisSize: MainAxisSize.min,
// // //                                       children: [
// // //                                         Icon(
// // //                                           isOn ? Icons.lightbulb : Icons.layers,
// // //                                           size: 18,
// // //                                           color: isOn ? Colors.white : Colors.grey.shade700,
// // //                                         ),
// // //                                         const SizedBox(width: 6),
// // //                                         Column(
// // //                                           crossAxisAlignment: CrossAxisAlignment.start,
// // //                                           mainAxisSize: MainAxisSize.min,
// // //                                           children: [
// // //                                             Text(
// // //                                               f['name'],
// // //                                               style: TextStyle(
// // //                                                 fontSize: 14,
// // //                                                 fontWeight: FontWeight.bold,
// // //                                                 color: isOn ? Colors.white : Colors.black87,
// // //                                               ),
// // //                                             ),
// // //                                             Text(
// // //                                               '${fLeds.length} phòng • ${isOn ? "ĐANG BẬT" : "TẮT"}',
// // //                                               style: TextStyle(
// // //                                                 fontSize: 10,
// // //                                                 color: isOn ? Colors.white70 : Colors.grey.shade600,
// // //                                               ),
// // //                                             ),
// // //                                           ],
// // //                                         ),
// // //                                       ],
// // //                                     ),
// // //                                   ),
// // //                                 ),
// // //                               );
// // //                             }).toList(),
// // //                           ),
// // //                         ),
// // //                         const SizedBox(height: 6),
// // //                         const Center(
// // //                           child: Text(
// // //                             '• Chạm 1 lần: Bật/Tắt Tầng  |  • Nhấn đúp 2 lần: Xem danh sách căn hộ',
// // //                             style: TextStyle(fontSize: 11, color: Colors.black54),
// // //                           ),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ],
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }


// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'rooms_list_screen.dart';

// // class FloorsListScreen extends StatefulWidget {
// //   final String buildingName;
// //   final List<dynamic> floors;
// //   final Map<int, bool> ledStates;
// //   final Function(List<int> leds, bool state) onToggleLeds;
// //   final bool Function(List<int> leds) isAnyLedOn;
// //   final List<int> Function(List<dynamic> rooms, {int? filterRoomType}) extractLeds;
// //   final int selectedFilterType;

// //   const FloorsListScreen({
// //     super.key,
// //     required this.buildingName,
// //     required this.floors,
// //     required this.ledStates,
// //     required this.onToggleLeds,
// //     required this.isAnyLedOn,
// //     required this.extractLeds,
// //     required this.selectedFilterType,
// //   });

// //   @override
// //   State<FloorsListScreen> createState() => _FloorsListScreenState();
// // }

// // class _FloorsListScreenState extends State<FloorsListScreen> {
// //   @override
// //   void initState() {
// //     super.initState();
// //     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
// //   }

// //   // Hàm hỗ trợ chia mảng floors thành N dãy (hàng)
// //   List<List<dynamic>> _splitFloorsIntoRows(List<dynamic> floorsList, int rowCount) {
// //     List<List<dynamic>> rows = List.generate(rowCount, (_) => []);
// //     for (int i = 0; i < floorsList.length; i++) {
// //       rows[i % rowCount].add(floorsList[i]);
// //     }
// //     return rows;
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // Tự động quyết định số hàng dựa trên tổng số tầng (Nhiều tầng => Chia 3 hàng, ít tầng => 1-2 hàng)
// //     int rowCount = 1;
// //     if (widget.floors.length > 12) {
// //       rowCount = 3; // Nếu trên 12 tầng -> Chia làm 3 dãy ngang
// //     } else if (widget.floors.length > 6) {
// //       rowCount = 2; // Từ 7-12 tầng -> Chia làm 2 dãy ngang
// //     }

// //     List<List<dynamic>> floorRows = _splitFloorsIntoRows(widget.floors, rowCount);

// //     return Scaffold(
// //       body: Stack(
// //         fit: StackFit.expand,
// //         children: [
// //           // 1. Ảnh nền floor.jpg TRÀN MÀN HÌNH
// //           Positioned.fill(
// //             child: Image.asset(
// //               'assets/images/floor.jpg',
// //               fit: BoxFit.fill,
// //               errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade900),
// //             ),
// //           ),

// //           // 2. Lớp phủ Gradient Tối
// //           Positioned.fill(
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 gradient: LinearGradient(
// //                   begin: Alignment.topCenter,
// //                   end: Alignment.bottomCenter,
// //                   colors: [
// //                     Colors.black.withValues(alpha: 0.6),
// //                     Colors.transparent,
// //                     Colors.black.withValues(alpha: 0.8),
// //                   ],
// //                   stops: const [0.0, 0.5, 1.0],
// //                 ),
// //               ),
// //             ),
// //           ),

// //           // 3. Nội dung giao diện
// //           SafeArea(
// //             child: Column(
// //               children: [
// //                 // Top Bar
// //                 Padding(
// //                   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
// //                   child: Row(
// //                     children: [
// //                       CircleAvatar(
// //                         backgroundColor: Colors.black45,
// //                         child: IconButton(
// //                           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
// //                           onPressed: () => Navigator.pop(context),
// //                         ),
// //                       ),
// //                       Expanded(
// //                         child: Text(
// //                           widget.buildingName,
// //                           textAlign: TextAlign.center,
// //                           style: const TextStyle(
// //                             fontSize: 22,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.white,
// //                             shadows: [Shadow(blurRadius: 10, color: Colors.black)],
// //                           ),
// //                         ),
// //                       ),
// //                       const SizedBox(width: 40),
// //                     ],
// //                   ),
// //                 ),

// //                 const Spacer(),

// //                 // Khung danh sách Tầng
// //                 Padding(
// //                   padding: const EdgeInsets.all(16.0),
// //                   child: Container(
// //                     padding: const EdgeInsets.all(14),
// //                     decoration: BoxDecoration(
// //                       color: Colors.white.withValues(alpha: 0.92),
// //                       borderRadius: BorderRadius.circular(20),
// //                       boxShadow: const [
// //                         BoxShadow(
// //                           color: Colors.black38,
// //                           blurRadius: 16,
// //                           offset: Offset(0, 6),
// //                         ),
// //                       ],
// //                     ),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       mainAxisSize: MainAxisSize.min,
// //                       children: [
// //                         const Text(
// //                           'Chọn Tầng Để Điều Khiển:',
// //                           style: TextStyle(
// //                             fontSize: 14,
// //                             fontWeight: FontWeight.bold,
// //                             color: Colors.black87,
// //                           ),
// //                         ),
// //                         const SizedBox(height: 10),

// //                         // Khung cuộn ngang chứa N dãy nút
// //                         SingleChildScrollView(
// //                           scrollDirection: Axis.horizontal,
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: floorRows.map((rowFloors) {
// //                               return Padding(
// //                                 padding: const EdgeInsets.only(bottom: 8.0),
// //                                 child: Row(
// //                                   children: rowFloors.map((f) => _buildFloorButton(f)).toList(),
// //                                 ),
// //                               );
// //                             }).toList(),
// //                           ),
// //                         ),
// //                         const SizedBox(height: 4),
// //                         const Center(
// //                           child: Text(
// //                             '• Chạm 1 lần: Bật/Tắt Tầng  |  • Nhấn đúp 2 lần: Xem danh sách căn hộ',
// //                             style: TextStyle(fontSize: 11, color: Colors.black54),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildFloorButton(dynamic f) {
// //     List<int> fLeds = widget.extractLeds(f['rooms'], filterRoomType: widget.selectedFilterType);
// //     bool isOn = widget.isAnyLedOn(fLeds);

// //     return Padding(
// //       padding: const EdgeInsets.only(right: 8.0),
// //       child: InkWell(
// //         onTap: () {
// //           widget.onToggleLeds(fLeds, !isOn);
// //           setState(() {});
// //         },
// //         onDoubleTap: () async {
// //           await Navigator.push(
// //             context,
// //             MaterialPageRoute(
// //               builder: (context) => RoomsListScreen(
// //                 floorName: '${widget.buildingName} - ${f['name']}',
// //                 rooms: f['rooms'],
// //                 ledStates: widget.ledStates,
// //                 onToggleLeds: widget.onToggleLeds,
// //                 isAnyLedOn: widget.isAnyLedOn,
// //               ),
// //             ),
// //           );
// //           setState(() {});
// //         },
// //         borderRadius: BorderRadius.circular(10),
// //         child: AnimatedContainer(
// //           duration: const Duration(milliseconds: 150),
// //           width: 130, // Chiều rộng cố định giúp giữ đúng vị trí các nút khi chạm
// //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
// //           decoration: BoxDecoration(
// //             color: isOn ? Colors.orange.shade600 : Colors.grey.shade100,
// //             borderRadius: BorderRadius.circular(10),
// //             border: Border.all(
// //               color: isOn ? Colors.orange.shade800 : Colors.grey.shade300,
// //               width: 1.5,
// //             ),
// //           ),
// //           child: Row(
// //             mainAxisSize: MainAxisSize.min,
// //             children: [
// //               Icon(
// //                 isOn ? Icons.lightbulb : Icons.layers,
// //                 size: 16,
// //                 color: isOn ? Colors.white : Colors.grey.shade700,
// //               ),
// //               const SizedBox(width: 6),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     Text(
// //                       f['name'],
// //                       maxLines: 1,
// //                       overflow: TextOverflow.ellipsis,
// //                       style: TextStyle(
// //                         fontSize: 12,
// //                         fontWeight: FontWeight.bold,
// //                         color: isOn ? Colors.white : Colors.black87,
// //                       ),
// //                     ),
// //                     Text(
// //                       '${fLeds.length} phòng | ${isOn ? "BẬT" : "TẮT"}',
// //                       maxLines: 1,
// //                       overflow: TextOverflow.ellipsis,
// //                       style: TextStyle(
// //                         fontSize: 9.5,
// //                         color: isOn ? Colors.white.withValues(alpha: 0.9) : Colors.grey.shade600,
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'rooms_list_screen.dart';

// class FloorsListScreen extends StatefulWidget {
//   final String buildingName;
//   final List<dynamic> floors;
//   final Map<int, bool> ledStates;
//   final Function(List<int> leds, bool state) onToggleLeds;
//   final bool Function(List<int> leds) isAnyLedOn;
//   final List<int> Function(List<dynamic> rooms, {int? filterRoomType}) extractLeds;
//   final int selectedFilterType;

//   const FloorsListScreen({
//     super.key,
//     required this.buildingName,
//     required this.floors,
//     required this.ledStates,
//     required this.onToggleLeds,
//     required this.isAnyLedOn,
//     required this.extractLeds,
//     required this.selectedFilterType,
//   });

//   @override
//   State<FloorsListScreen> createState() => _FloorsListScreenState();
// }

// class _FloorsListScreenState extends State<FloorsListScreen> {
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
//   }

//   // Chia danh sách floors thành N hàng
//   List<List<dynamic>> _splitFloorsIntoRows(List<dynamic> floorsList, int rowCount) {
//     List<List<dynamic>> rows = List.generate(rowCount, (_) => []);
//     for (int i = 0; i < floorsList.length; i++) {
//       rows[i % rowCount].add(floorsList[i]);
//     }
//     return rows;
//   }

//   @override
//   Widget build(BuildContext context) {
//     int rowCount = 1;
//     if (widget.floors.length > 12) {
//       rowCount = 3;
//     } else if (widget.floors.length > 6) {
//       rowCount = 2;
//     }

//     List<List<dynamic>> floorRows = _splitFloorsIntoRows(widget.floors, rowCount);

//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           // 1. Ảnh nền mặt bằng floor.jpg
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/floor.jpg',
//               fit: BoxFit.fill,
//               errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade900),
//             ),
//           ),

//           // 2. Lớp phủ Gradient Tối nhẹ
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.black.withValues(alpha: 0.65),
//                     Colors.transparent,
//                     Colors.black.withValues(alpha: 0.8),
//                   ],
//                   stops: const [0.0, 0.4, 1.0],
//                 ),
//               ),
//             ),
//           ),

//           // 3. Nội dung giao diện
//           SafeArea(
//             child: Column(
//               children: [
//                 // Top Bar - Nút Quay lại & Tiêu đề
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Colors.black54,
//                         child: IconButton(
//                           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
//                           onPressed: () => Navigator.pop(context),
//                         ),
//                       ),
//                       Expanded(
//                         child: Text(
//                           widget.buildingName,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             shadows: [Shadow(blurRadius: 10, color: Colors.black)],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 40),
//                     ],
//                   ),
//                 ),

//                 const Spacer(),

//                 // Khung danh sách Tầng - PHONG CÁCH DARK GLASS
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Container(
//                     padding: const EdgeInsets.all(16),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withValues(alpha: 0.75), // Nền xám đen mờ sang trọng
//                       borderRadius: BorderRadius.circular(22),
//                       border: Border.all(color: Colors.white24, width: 1.2),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: Colors.black87,
//                           blurRadius: 20,
//                           offset: Offset(0, 8),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa nội dung khung
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Text(
//                           'ĐIỀU KHIỂN TẦNG SA BÀN',
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.orangeAccent,
//                             letterSpacing: 1.1,
//                           ),
//                         ),
//                         const SizedBox(height: 12),

//                         // Khung cuộn ngang CĂN GIỮA các dãy nút
//                         SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center, // Căn giữa các hàng
//                             children: floorRows.map((rowFloors) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(bottom: 10.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center, // Căn giữa nút trong hàng
//                                   children: rowFloors.map((f) => _buildFloorButton(f)).toList(),
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),

//                         const SizedBox(height: 4),
//                         const Text(
//                           '• Chạm 1 lần: Bật/Tắt Tầng   |   • Nhấn đúp 2 lần: Danh sách căn hộ',
//                           style: TextStyle(fontSize: 11, color: Colors.white60),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget Tạo Nút Bấm Tầng Sinh Động & Nổi Bật
//   Widget _buildFloorButton(dynamic f) {
//     List<int> fLeds = widget.extractLeds(f['rooms'], filterRoomType: widget.selectedFilterType);
//     bool isOn = widget.isAnyLedOn(fLeds);

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//       child: InkWell(
//         onTap: () {
//           widget.onToggleLeds(fLeds, !isOn);
//           setState(() {});
//         },
//         onDoubleTap: () async {
//           await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => RoomsListScreen(
//                 floorName: '${widget.buildingName} - ${f['name']}',
//                 rooms: f['rooms'],
//                 ledStates: widget.ledStates,
//                 onToggleLeds: widget.onToggleLeds,
//                 isAnyLedOn: widget.isAnyLedOn,
//               ),
//             ),
//           );
//           setState(() {});
//         },
//         borderRadius: BorderRadius.circular(12),
//         child: AnimatedContainer(
//           duration: const Duration(milliseconds: 180),
//           width: 132, // Cố định độ rộng để không bị rung/nhảy khi bấm
//           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
//           decoration: BoxDecoration(
//             // Đổi màu nền cực kỳ sinh động
//             color: isOn ? Colors.orange.shade600 : Colors.blueGrey.shade900.withValues(alpha: 0.8),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(
//               color: isOn ? Colors.orangeAccent : Colors.white24,
//               width: 1.5,
//             ),
//             boxShadow: isOn
//                 ? [
//                     BoxShadow(
//                       color: Colors.orange.withValues(alpha: 0.5),
//                       blurRadius: 10,
//                       offset: const Offset(0, 3),
//                     ),
//                   ]
//                 : [],
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 isOn ? Icons.lightbulb : Icons.layers,
//                 size: 18,
//                 color: isOn ? Colors.white : Colors.white60,
//               ),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       f['name'],
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 13,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       '${fLeds.length} phòng | ${isOn ? "BẬT" : "TẮT"}',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontSize: 10,
//                         fontWeight: isOn ? FontWeight.bold : FontWeight.normal,
//                         color: isOn ? Colors.white : Colors.white54,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'rooms_list_screen.dart';

class FloorsListScreen extends StatefulWidget {
  final String buildingName;
  final List<dynamic> floors;
  final Map<int, bool> ledStates;
  final Function(List<int> leds, bool state) onToggleLeds;
  final bool Function(List<int> leds) isAnyLedOn;
  final List<int> Function(List<dynamic> rooms, {int? filterRoomType}) extractLeds;
  final int selectedFilterType;

  const FloorsListScreen({
    super.key,
    required this.buildingName,
    required this.floors,
    required this.ledStates,
    required this.onToggleLeds,
    required this.isAnyLedOn,
    required this.extractLeds,
    required this.selectedFilterType,
  });

  @override
  State<FloorsListScreen> createState() => _FloorsListScreenState();
}

class _FloorsListScreenState extends State<FloorsListScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  // Chia danh sách Tầng nối tiếp nhau: Hàng 1 (Tầng 1 -> N), Hàng 2 (N+1 -> M)...
  List<List<dynamic>> _splitFloorsSequentially(List<dynamic> floorsList, int rowCount) {
    List<List<dynamic>> rows = [];
    int itemsPerRow = (floorsList.length / rowCount).ceil();

    for (int i = 0; i < floorsList.length; i += itemsPerRow) {
      int end = (i + itemsPerRow < floorsList.length) ? i + itemsPerRow : floorsList.length;
      rows.add(floorsList.sublist(i, end));
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    int rowCount = 1;
    if (widget.floors.length > 12) {
      rowCount = 3; // >12 tầng => 3 hàng
    } else if (widget.floors.length > 6) {
      rowCount = 2; // 7 - 12 tầng => 2 hàng
    }

    List<List<dynamic>> floorRows = _splitFloorsSequentially(widget.floors, rowCount);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Ảnh nền mặt bằng floor.jpg TRÀN MÀN HÌNH
          Positioned.fill(
            child: Image.asset(
              'assets/images/floor.jpg',
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade900),
            ),
          ),

          // 2. Lớp phủ Gradient Tối làm nổi khung nút
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.6),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),

          // 3. Nội dung giao diện
          SafeArea(
            child: Column(
              children: [
                // Top Bar - Nút Quay lại & Tiêu đề
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          widget.buildingName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                    ],
                  ),
                ),

                const Spacer(),

                // KHUNG CHỨA NGOÀI: TÔNG XANH PASTEL / XANH NGỌC NHẠT
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      // Màu nền Xanh Ngọc Nhạt mờ trong suốt nhẹ
                      color: const Color(0xFFE0F2FE).withValues(alpha: 0.94),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFFBAE6FD), width: 1.8),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 20,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, // CĂN GIỮA
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.tune, size: 16, color: Color(0xFF0369A1)),
                            SizedBox(width: 6),
                            Text(
                              'ĐIỀU KHIỂN TẦNG SA BÀN',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0369A1),
                                letterSpacing: 1.1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Cuộn ngang CĂN GIỮA các dãy nút Tầng
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center, // CĂN GIỮA NÚT
                            children: floorRows.map((rowFloors) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center, // CĂN GIỮA NÚT TRONG HÀNG
                                  children: rowFloors.map((f) => _buildFloorButton(f)).toList(),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        const SizedBox(height: 4),
                        const Text(
                          '• Chạm 1 lần: Bật/Tắt Tầng   |   • Nhấn đúp 2 lần: Danh sách căn hộ',
                          style: TextStyle(fontSize: 11, color: Color(0xFF0284C7), fontWeight: FontWeight.w500),
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

  // Widget NÚT BẤM MÀU HỒNG NHẠT (OFF) & CAM NỔI BẬT (ON)
  Widget _buildFloorButton(dynamic f) {
    List<int> fLeds = widget.extractLeds(f['rooms'], filterRoomType: widget.selectedFilterType);
    bool isOn = widget.isAnyLedOn(fLeds);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: InkWell(
        onTap: () {
          widget.onToggleLeds(fLeds, !isOn);
          setState(() {});
        },
        onDoubleTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomsListScreen(
                floorName: '${widget.buildingName} - ${f['name']}',
                rooms: f['rooms'],
                ledStates: widget.ledStates,
                onToggleLeds: widget.onToggleLeds,
                isAnyLedOn: widget.isAnyLedOn,
              ),
            ),
          );
          setState(() {});
        },
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: 132, // Cố định chiều rộng giúp giữ vị trí tuyệt đối khi bấm
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            // ON: Gradient Cam Hổ Phách
            // OFF: Nền Hồng Nhạt Pastel (Màu khác hoàn toàn so với khung Xanh ngoài)
            gradient: isOn
                ? const LinearGradient(
                    colors: [Color(0xFFFF9800), Color(0xFFF57C00)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : const LinearGradient(
                    colors: [Color(0xFFFCE7F3), Color(0xFFFBCFE8)], // Hồng Nhạt Pastel
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isOn ? Colors.amberAccent : const Color(0xFFF472B6), // Viền Hồng Đậm khi Tắt
              width: 1.5,
            ),
            boxShadow: isOn
                ? [
                    BoxShadow(
                      color: Colors.orange.withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.pink.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: isOn ? Colors.white.withValues(alpha: 0.25) : const Color(0xFFF472B6).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isOn ? Icons.lightbulb : Icons.layers,
                  size: 16,
                  color: isOn ? Colors.white : const Color(0xFFDB2777),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      f['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isOn ? Colors.white : const Color(0xFF831843), // Tím/Hồng Sẫm dễ đọc
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${fLeds.length} phòng | ${isOn ? "BẬT" : "TẮT"}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: isOn ? FontWeight.bold : FontWeight.w600,
                        color: isOn ? Colors.yellow.shade100 : const Color(0xFF9D174D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}