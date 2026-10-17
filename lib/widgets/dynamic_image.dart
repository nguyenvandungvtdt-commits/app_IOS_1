// // // import 'package:flutter/material.dart';
// // // import 'package:cached_network_image/cached_network_image.dart';

// // // class DynamicImage extends StatelessWidget {
// // //   final String imagePath;
// // //   final BoxFit fit;

// // //   const DynamicImage({
// // //     super.key,
// // //     required this.imagePath,
// // //     this.fit = BoxFit.fill,
// // //   });

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
// // //       return CachedNetworkImage(
// // //         imageUrl: imagePath,
// // //         fit: fit,
// // //         placeholder: (context, url) => Container(
// // //           color: const Color(0xFF0F172A),
// // //           child: const Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
// // //         ),
// // //         errorWidget: (context, url, error) => Container(
// // //           color: Colors.grey.shade900,
// // //           child: const Icon(Icons.broken_image, color: Colors.white38, size: 48),
// // //         ),
// // //       );
// // //     } else {
// // //       return Image.asset(
// // //         imagePath,
// // //         fit: fit,
// // //         errorBuilder: (context, error, stackTrace) => Container(
// // //           color: Colors.grey.shade900,
// // //           child: const Icon(Icons.image_not_supported, color: Colors.white38, size: 48),
// // //         ),
// // //       );
// // //     }
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:cached_network_image/cached_network_image.dart';

// // class DynamicImage extends StatelessWidget {
// //   final String imagePath;
// //   final BoxFit fit;
// //   final String fallbackAsset;

// //   const DynamicImage({
// //     super.key,
// //     required this.imagePath,
// //     this.fit = BoxFit.contain, // 🟢 Đổi mặc định sang BoxFit.contain để KHÔNG BỊ CẮT XÉN ẢNH
// //     this.fallbackAsset = 'assets/images/overview.jpg', // 🟢 Asset đệm mặc định
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
// //       return CachedNetworkImage(
// //         imageUrl: imagePath,
// //         fit: fit,
// //         // 🟢 Trong lúc chờ tải từ Online -> Hiện ngay ảnh Asset Local làm bộ đệm (xóa bỏ vòng xoay)
// //         placeholder: (context, url) => Stack(
// //           fit: StackFit.expand,
// //           children: [
// //             Image.asset(
// //               fallbackAsset,
// //               fit: fit,
// //             ),
// //             const Center(
// //               child: CircularProgressIndicator(
// //                 color: Colors.cyanAccent,
// //                 strokeWidth: 2,
// //               ),
// //             ),
// //           ],
// //         ),
// //         // 🟢 Khi link Online bị lỗi 404/Mất mạng -> Hiện ảnh Asset Local
// //         errorWidget: (context, url, error) => Image.asset(
// //           fallbackAsset,
// //           fit: fit,
// //           errorBuilder: (context, err, stack) => Container(
// //             color: Colors.grey.shade900,
// //             child: const Icon(Icons.broken_image, color: Colors.white38, size: 48),
// //           ),
// //         ),
// //       );
// //     } else {
// //       // 🟢 Trường hợp truyền đường dẫn Local Asset
// //       return Image.asset(
// //         imagePath,
// //         fit: fit,
// //         errorBuilder: (context, error, stackTrace) => Image.asset(
// //           fallbackAsset,
// //           fit: fit,
// //           errorBuilder: (context, err, stack) => Container(
// //             color: Colors.grey.shade900,
// //             child: const Icon(Icons.image_not_supported, color: Colors.white38, size: 48),
// //           ),
// //         ),
// //       );
// //     }
// //   }
// // }
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// class DynamicImage extends StatelessWidget {
//   final String imagePath;
//   final BoxFit fit;
//   final String fallbackAsset;
//   final Alignment alignment;

//   const DynamicImage({
//     super.key,
//     required this.imagePath,
//     this.fit = BoxFit.contain, // BoxFit.contain hoặc BoxFit.cover tùy giao diện
//     this.fallbackAsset = 'assets/images/overview.jpg',
//     this.alignment = Alignment.center,
//   });

//   @override
//   Widget build(BuildContext context) {
//     if (imagePath.isEmpty) {
//       return _buildFallbackAsset();
//     }

//     // 1. Trường hợp link Online HTTP/HTTPS
//     if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
//       return CachedNetworkImage(
//         imageUrl: imagePath,
//         fit: fit,
//         alignment: alignment,
//         placeholder: (context, url) => Stack(
//           fit: StackFit.expand,
//           children: [
//             _buildFallbackAsset(),
//             const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.cyanAccent,
//                 strokeWidth: 2,
//               ),
//             ),
//           ],
//         ),
//         errorWidget: (context, url, error) => _buildFallbackAsset(),
//       );
//     }

//     // 2. Trường hợp Blob URL (khi chạy trên Flutter Web)
//     if (kIsWeb || imagePath.startsWith('blob:')) {
//       return Image.network(
//         imagePath,
//         fit: fit,
//         alignment: alignment,
//         errorBuilder: (context, error, stackTrace) => _buildFallbackAsset(),
//       );
//     }

//     // 3. 🟢 Trường hợp Ảnh chọn từ Thư viện Điện thoại thực (File path)
//     if (!imagePath.startsWith('assets/')) {
//       final file = File(imagePath);
//       if (file.existsSync()) {
//         return Image.file(
//           file,
//           fit: fit,
//           alignment: alignment,
//           errorBuilder: (context, error, stackTrace) => _buildFallbackAsset(),
//         );
//       }
//     }

//     // 4. Trường hợp Local Asset mặc định
//     return Image.asset(
//       imagePath,
//       fit: fit,
//       alignment: alignment,
//       errorBuilder: (context, error, stackTrace) => _buildFallbackAsset(),
//     );
//   }

//   // Widget đệm khi ảnh gặp lỗi hoặc đang tải
//   Widget _buildFallbackAsset() {
//     return Image.asset(
//       fallbackAsset,
//       fit: fit,
//       alignment: alignment,
//       errorBuilder: (context, err, stack) => Container(
//         color: Colors.grey.shade900,
//         child: const Icon(Icons.broken_image, color: Colors.white38, size: 48),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DynamicImage extends StatelessWidget {
  final String imagePath;
  final BoxFit fit;
  final String fallbackAsset;
  final Alignment alignment;

  const DynamicImage({
    super.key,
    required this.imagePath,
    this.fit = BoxFit.contain,
    this.fallbackAsset = 'assets/images/overview.jpg',
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    // 🟢 Nếu đường dẫn rỗng/null -> Dùng ảnh đệm Fallback ngay
    if (imagePath.trim().isEmpty) {
      return _buildFallbackAsset();
    }

    // 1. Trường hợp link Online HTTP/HTTPS (Sử dụng CacheNetworkImage)
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return CachedNetworkImage(
        imageUrl: imagePath,
        fit: fit,
        alignment: alignment,
        placeholder: (context, url) => Stack(
          fit: StackFit.expand,
          children: [
            _buildFallbackAsset(),
            const Center(
              child: CircularProgressIndicator(
                color: Colors.cyanAccent,
                strokeWidth: 2,
              ),
            ),
          ],
        ),
        errorWidget: (context, url, error) => _buildFallbackAsset(),
      );
    }

    // 2. Trường hợp Flutter Web hoặc Blob URL
    if (kIsWeb || imagePath.startsWith('blob:')) {
      return Image.network(
        imagePath,
        fit: fit,
        alignment: alignment,
        errorBuilder: (context, error, stackTrace) => _buildFallbackAsset(),
      );
    }

    // 3. Trường hợp Ảnh chọn từ Thư viện thiết bị (File path local - Chỉ kiểm tra trên Mobile)
    if (!kIsWeb && !imagePath.startsWith('assets/')) {
      try {
        final file = File(imagePath);
        if (file.existsSync()) {
          return Image.file(
            file,
            fit: fit,
            alignment: alignment,
            errorBuilder: (context, error, stackTrace) => _buildFallbackAsset(),
          );
        }
      } catch (e) {
        debugPrint('⚠️ DynamicImage File Check Error: $e');
      }
    }

    // 4. Trường hợp Local Asset
    return Image.asset(
      imagePath,
      fit: fit,
      alignment: alignment,
      errorBuilder: (context, error, stackTrace) => _buildFallbackAsset(),
    );
  }

  // Widget đệm khi ảnh gặp lỗi hoặc đang tải
  Widget _buildFallbackAsset() {
    return Image.asset(
      fallbackAsset,
      fit: fit,
      alignment: alignment,
      errorBuilder: (context, err, stack) => Container(
        color: Colors.grey.shade900,
        child: const Icon(Icons.broken_image, color: Colors.white38, size: 48),
      ),
    );
  }
}