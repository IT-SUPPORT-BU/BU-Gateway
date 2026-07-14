import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_windows/webview_windows.dart' as win_webview;
import 'package:url_launcher/url_launcher.dart';

/// WebViewScreen displays a given URL.
/// - On web: opens the link in a new browser tab (embedding isn't reliable on web).
/// - On Windows: uses webview_windows (WebView2) inside the app.
/// - On Android/iOS: uses webview_flutter inside the app.
class WebViewScreen extends StatefulWidget {
  final String title;
  final String url;

  const WebViewScreen({super.key, required this.title, required this.url});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  WebViewController? _mobileController;
  win_webview.WebviewController? _windowsController;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _openExternally();
    } else if (Platform.isWindows) {
      _initWindowsWebView();
    } else {
      _initMobileWebView();
    }
  }

  /// On web, launch the portal in a new browser tab, then pop back.
  Future<void> _openExternally() async {
    final uri = Uri.parse(widget.url);
    final launched = await launchUrl(uri, webOnlyWindowName: '_blank');
    if (!launched && mounted) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
      return;
    }
    if (mounted) {
      Navigator.pop(context);
    }
  }

  void _initMobileWebView() {
    _mobileController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
              _hasError = false;
            });
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
          },
          onWebResourceError: (error) {
            setState(() {
              _isLoading = false;
              _hasError = true;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  Future<void> _initWindowsWebView() async {
    try {
      _windowsController = win_webview.WebviewController();
      await _windowsController!.initialize();
      await _windowsController!.loadUrl(widget.url);
      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _windowsController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // While the web tab is opening, show a brief loading screen before popping back.
    if (kIsWeb) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title, style: const TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF003087),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Center(
          child: _hasError
              ? const Text('Could not open link. Check your browser popup settings.')
              : const CircularProgressIndicator(color: Color(0xFF003087)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF003087),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (!Platform.isWindows)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _mobileController?.reload(),
            ),
        ],
      ),
      body: Stack(
        children: [
          if (_hasError)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.wifi_off, size: 60, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text(
                      'Unable to load this page.\nCheck your internet connection.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          else if (Platform.isWindows)
            (_windowsController != null && !_isLoading)
                ? win_webview.Webview(_windowsController!)
                : const SizedBox()
          else if (_mobileController != null)
            WebViewWidget(controller: _mobileController!),
          if (_isLoading && !_hasError)
            const Center(child: CircularProgressIndicator(color: Color(0xFF003087))),
        ],
      ),
    );
  }
}