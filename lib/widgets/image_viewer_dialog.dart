// import 'package:flutter/material.dart';
// import 'dynamic_image.dart'; // 🟢 Dùng chung DynamicImage hỗ trợ cả HTTP, Asset, File local, Web Blob

// class ImageViewerDialog {
//   /// Hàm tĩnh mở Dialog xem ảnh full màn hình có tính năng Zoom (Chụm/xòe 2 ngón tay)
//   static void show(BuildContext context, String imagePath, {String? title}) {
//     if (imagePath.isEmpty) return;

//     showDialog(
//       context: context,
//       useRootNavigator: true, // 🟢 BẮT BUỘC: Đẩy Dialog đè lên trên BottomSheet
//   barrierColor: Colors.black.withValues(alpha: 0.92),
//       // barrierColor: Colors.black.withValues(alpha: .92), // Nền tối như ứng dụng Thư viện ảnh
//       builder: (dialogContext) {
//         return Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Stack(
//             children: [
//               // 🟢 1. Khu vực hiển thị ảnh + Cử chỉ Zoom (InteractiveViewer)
//               Center(
//                 child: InteractiveViewer(
//                   panEnabled: true,
//                   boundaryMargin: const EdgeInsets.all(20),
//                   minScale: 0.5,
//                   maxScale: 4.0, // Phóng to tối đa 4 lần để soi rõ chi tiết bản vẽ/mặt bằng
//                   child: DynamicImage(
//                     imagePath: imagePath,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),

//               // 🟢 2. Thanh Tiêu đề & Nút Đóng (X) ở góc trên
//               SafeArea(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Tiêu đề ảnh (nếu có)
//                       Expanded(
//                         child: title != null && title.isNotEmpty
//                             ? Text(
//                                 title,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.bold,
//                                   shadows: [
//                                     Shadow(blurRadius: 4, color: Colors.black, offset: Offset(0, 1)),
//                                   ],
//                                 ),
//                                 overflow: TextOverflow.ellipsis,
//                               )
//                             : const SizedBox.shrink(),
//                       ),

//                       // Nút Đóng (X)
//                       CircleAvatar(
//                         backgroundColor: Colors.black54,
//                         child: IconButton(
//                           icon: const Icon(Icons.close_rounded, color: Colors.white, size: 22),
//                           onPressed: () => Navigator.pop(dialogContext),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'dynamic_image.dart';

class ImageViewerDialog {
  static void show(BuildContext context, String imagePath, {String? title}) {
    debugPrint('🖼️ [OPEN IMAGE DIALOG]: $imagePath');

    // Nếu đường dẫn rỗng, báo log để kiểm tra thay vì im lặng return
    if (imagePath.trim().isEmpty) {
      debugPrint('⚠️ [IMAGE DIALOG ERROR]: DynamicImage URL is EMPTY!');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Không tìm thấy đường dẫn hình ảnh!')),
      );
      return;
    }

    showDialog(
      context: context,
      useRootNavigator: true, // 🟢 BẮT BUỘC: Đẩy Dialog đè lên trên BottomSheet
      barrierColor: Colors.black.withValues(alpha: 0.92),
      builder: (dialogContext) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              // 1. Khu vực hiển thị ảnh + Cử chỉ Zoom (InteractiveViewer)
              Center(
                child: InteractiveViewer(
                  panEnabled: true,
                  clipBehavior: Clip.none,
                  minScale: 0.5,
                  maxScale: 4.0, // Phóng to tối đa 4x
                  child: DynamicImage(
                    imagePath: imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // 2. Thanh Tiêu đề & Nút Đóng
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title ?? 'Chi Tiết Hình Ảnh',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(blurRadius: 4, color: Colors.black, offset: Offset(0, 1)),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(Icons.close_rounded, color: Colors.white, size: 22),
                          onPressed: () => Navigator.of(dialogContext).pop(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}