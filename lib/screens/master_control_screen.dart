import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../services/config_service.dart';
import 'buildings_list_screen.dart';
import 'connect_screen.dart';

class MasterControlScreen extends StatefulWidget {
  final WebSocketChannel channel;
  final String ip;
  final String? cachedJson;

  const MasterControlScreen({
    super.key,
    required this.channel,
    required this.ip,
    this.cachedJson,
  });

  @override
  State<MasterControlScreen> createState() => _MasterControlScreenState();
}

class _MasterControlScreenState extends State<MasterControlScreen> {
  String _projectName = 'Đang tải sa bàn...';
  List<Map<String, dynamic>> _buildings = [];
  final Map<int, bool> _ledStates = {};
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();

    if (widget.cachedJson != null) {
      _parseFlatJson(widget.cachedJson!, isFromCache: true);
    }

    widget.channel.stream.listen(
      (data) {
        String jsonStr = data.toString();
        _parseFlatJson(jsonStr, isFromCache: false);
      },
      onError: (_) {
        if (!mounted) return;
        _resetToConnectScreen();
      },
      onDone: () {
        if (!mounted) return;
        _resetToConnectScreen();
      },
    );
  }

  void _parseFlatJson(String jsonStr, {required bool isFromCache}) async {
    try {
      final raw = jsonDecode(jsonStr);
      String projectName = raw['p'] ?? 'Sa Bàn Tòa Nhà';
      List<dynamic> rows = raw['d'] ?? [];

      Map<String, Map<String, List<Map<String, dynamic>>>> structured = {};

      for (var row in rows) {
        String bName = row[0].toString();
        String fName = row[1].toString();
        String rNum = row[2].toString();
        int rType = row[3];
        int ledIdx = row[4];

        structured.putIfAbsent(bName, () => {});
        structured[bName]!.putIfAbsent(fName, () => []);

        structured[bName]![fName]!.add({
          'room_number': rNum,
          'room_type': rType,
          'led_index': ledIdx,
        });
      }

      List<Map<String, dynamic>> parsedBuildings = [];
      structured.forEach((bName, floorsMap) {
        List<Map<String, dynamic>> floorsList = [];
        floorsMap.forEach((fName, roomsList) {
          floorsList.add({
            'name': fName,
            'rooms': roomsList,
          });
        });

        parsedBuildings.add({
          'name': bName,
          'floors': floorsList,
        });
      });

      if (mounted) {
        setState(() {
          _projectName = projectName;
          _buildings = parsedBuildings;
          _isLoaded = true;
        });
      }

      if (!isFromCache) {
        await ConfigService.saveConfig(widget.ip, jsonStr);
      }
    } catch (e) {
      debugPrint("Lỗi Parse JSON: $e");
    }
  }

  void _resetToConnectScreen() async {
    await ConfigService.clearConfig();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ConnectScreen()),
    );
  }

  List<int> _extractLeds(List<dynamic> roomsList, {int? filterRoomType}) {
    List<int> leds = [];
    for (var r in roomsList) {
      if (filterRoomType == null || filterRoomType == 0 || r['room_type'] == filterRoomType) {
        leds.add(r['led_index']);
      }
    }
    return leds;
  }

  void _toggleLedList(List<int> ledIndices, bool targetState) {
    if (ledIndices.isEmpty) return;

    setState(() {
      for (int ledIdx in ledIndices) {
        _ledStates[ledIdx] = targetState;
      }
    });

    if (ledIndices.length == 1) {
      widget.channel.sink.add('${ledIndices.first}:${targetState ? 1 : 0}');
    } else {
      String idsJoined = ledIndices.join(',');
      String payload = 'ALL:${targetState ? 1 : 0}:$idsJoined';
      widget.channel.sink.add(payload);
    }
  }

  bool _isAnyLedOn(List<int> ledIndices) {
    for (int ledIdx in ledIndices) {
      if (_ledStates[ledIdx] ?? false) {
        return true;
      }
    }
    return false;
  }

  List<int> _getAllSabanLeds({int? filterType}) {
    List<int> allLeds = [];
    for (var b in _buildings) {
      for (var f in b['floors']) {
        allLeds.addAll(_extractLeds(f['rooms'], filterRoomType: filterType));
      }
    }
    return allLeds;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isLoaded) {
      return Scaffold(
        appBar: AppBar(title: const Text('Đang tải dữ liệu...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    List<int> allSabanLeds = _getAllSabanLeds();
    bool isMasterOn = _isAnyLedOn(allSabanLeds);

    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Ảnh Sa Bàn
          // Positioned.fill(
          //   child: InteractiveViewer(
          //     minScale: 1.0,
          //     maxScale: 4.0,
          //     child: Image.asset(
          //       'assets/images/overview.webp',
          //       fit: BoxFit.cover,
          //       errorBuilder: (context, error, stackTrace) => Container(
          //         color: Colors.grey.shade900,
          //         child: const Center(
          //           child: Icon(Icons.image_not_supported, color: Colors.white54, size: 50),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Positioned.fill(
            child: Image.asset(
              'assets/images/overview.webp',
              fit: BoxFit.fill, // Tràn phẳng tuyệt đối cả chiều rộng lẫn chiều cao
              errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey.shade900),
            ),
          ),

          // Lớp phủ Gradient Tối
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.6),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            ),
          ),

          // 2. Giao diện điều khiển
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 48),
                      Expanded(
                        child: Text(
                          _projectName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [Shadow(blurRadius: 8, color: Colors.black)],
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.refresh, color: Colors.white),
                        tooltip: 'Đổi IP / Xóa Cấu Hình',
                        onPressed: _resetToConnectScreen,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Các nút Bật/Tắt Căn Hộ
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildRoomTypeFilter(),
                ),

                const Spacer(),

                // Nút Tổng Sa Bàn
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      _toggleLedList(allSabanLeds, !isMasterOn);
                    },
                    onDoubleTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuildingsListScreen(
                            buildings: _buildings,
                            ledStates: _ledStates,
                            onToggleLeds: _toggleLedList,
                            isAnyLedOn: _isAnyLedOn,
                            extractLeds: _extractLeds,
                            selectedFilterType: 0,
                          ),
                        ),
                      );
                      setState(() {});
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                      decoration: BoxDecoration(
                        color: isMasterOn
                            ? Colors.orange.shade600.withValues(alpha: 0.9)
                            : Colors.blueGrey.shade900.withValues(alpha: 0.85),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isMasterOn ? Colors.orangeAccent : Colors.white24,
                          width: 1.5,
                        ),
                        boxShadow: const [
                          BoxShadow(color: Colors.black45, blurRadius: 12, offset: Offset(0, 4))
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isMasterOn ? Icons.lightbulb : Icons.lightbulb_outline,
                            size: 44,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'TỔNG SA BÀN (${isMasterOn ? "ĐANG BẬT" : "ĐANG TẮT"})',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '• Chạm 1 lần: Bật/Tắt tất cả  |  • Nhấn đúp 2 lần: Danh sách Tòa',
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
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

  Widget _buildRoomTypeFilter() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Điều Khiển Nhanh Loại Căn Hộ:',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildDirectToggleButton(label: 'Tất cả căn', filterType: 0),
                const SizedBox(width: 8),
                _buildDirectToggleButton(label: 'Loại 1 (1PN)', filterType: 1),
                const SizedBox(width: 8),
                _buildDirectToggleButton(label: 'Loại 2 (2PN)', filterType: 2),
                const SizedBox(width: 8),
                _buildDirectToggleButton(label: 'Loại 3 (3PN)', filterType: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectToggleButton({required String label, required int filterType}) {
    List<int> ledsOfThisType = _getAllSabanLeds(filterType: filterType);
    bool isTypeOn = _isAnyLedOn(ledsOfThisType);

    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: isTypeOn ? const Color(0xFF009688) : Colors.grey.shade200,
        foregroundColor: isTypeOn ? Colors.white : Colors.black87,
        elevation: isTypeOn ? 4 : 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: isTypeOn ? Colors.teal : Colors.grey.shade400,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      ),
      icon: Icon(
        isTypeOn ? Icons.power_settings_new : Icons.power_settings_new_outlined,
        size: 18,
        color: isTypeOn ? Colors.white : Colors.grey.shade700,
      ),
      label: Text(
        label,
        style: TextStyle(
          fontWeight: isTypeOn ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onPressed: () {
        _toggleLedList(ledsOfThisType, !isTypeOn);
      },
    );
  }
}