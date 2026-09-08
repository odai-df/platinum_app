import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class Unit360View extends StatefulWidget {
  final String imageUrl;

  const Unit360View({
    super.key,
    required this.imageUrl,
  });

  @override
  State<Unit360View> createState() => _Unit360ViewState();
}

class _Unit360ViewState extends State<Unit360View> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        title:  Text(
          '360° View'.tr(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Stack(
        children: [
          if (!_hasError)
            PanoramaViewer(
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (
                  context,
                  child,
                  loadingProgress,
                ) {
                  if (loadingProgress == null) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted && _isLoading) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    });

                    return child;
                  }

                  return const SizedBox.expand();
                },
                errorBuilder: (_, __, ___) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted && !_hasError) {
                      setState(() {
                        _hasError = true;
                        _isLoading = false;
                      });
                    }
                  });

                  return const SizedBox.expand();
                },
              ),
            ),
          if (_isLoading && !_hasError)
            const Center(
              // child: CircularProgressIndicator(
              //   color: Colors.white,
              // ),
            ),
          if (_hasError)
            const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.broken_image_outlined,
                    color: Colors.white,
                    size: 55,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Unable to load 360° image',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
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
