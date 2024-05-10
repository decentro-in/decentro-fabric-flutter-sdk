library decentrotech_fabric;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

// Screen for opening UIStream in a managed webview.
class UIStreamWebView extends StatefulWidget {
  // UIStreamWebView constructor. Requires uistreamUrl to start the UIStream session
  const UIStreamWebView({super.key, required this.uistreamUrl});

  /// UIStream session url
  final String uistreamUrl;

  @override
  State<UIStreamWebView> createState() => _UIStreamWebViewState();
}

class _UIStreamWebViewState extends State<UIStreamWebView> {
  final GlobalKey webViewKey = GlobalKey();
  bool showLoading = true;

  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      allowsInlineMediaPlayback: true,
      iframeAllow: "camera; microphone",
      iframeAllowFullscreen: true,
      supportMultipleWindows: true,
      javaScriptCanOpenWindowsAutomatically: true);

  String url = "";
  final urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Builder(
      builder: (context) => Stack(
        children: [
          InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(url: WebUri(widget.uistreamUrl)),
            initialSettings: settings,
            onLoadStart: (controller, url) {
              setState(() {
                this.url = url.toString();
                urlController.text = this.url;
              });
            },
            onPermissionRequest: (controller, request) async {
              return PermissionResponse(
                  resources: request.resources,
                  action: PermissionResponseAction.GRANT);
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              final url = await controller.getUrl();
              final deeplink = navigationAction.request.url;

              if (deeplink != null && url != navigationAction.request.url) {
                launchUrl(deeplink,
                    mode: LaunchMode.externalNonBrowserApplication);

                return NavigationActionPolicy.CANCEL;
              }

              return NavigationActionPolicy.ALLOW;
            },
            onProgressChanged: (_, progress) {
              if (progress >= 100) {
                setState(() {
                  showLoading = false;
                });
              }
            },
            onConsoleMessage: (controller, consoleMessage) {
              if (kDebugMode) {
                print(consoleMessage);
              }
            },
            onCreateWindow: (controller, createWindowRequest) async {
              showBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) {
                  return _WindowPopup(createWindowAction: createWindowRequest);
                },
              );

              return true;
            },
          ),
          if (showLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    ));
  }
}

// UIStream popup window widget
class _WindowPopup extends StatefulWidget {
  final CreateWindowAction createWindowAction;

  const _WindowPopup({required this.createWindowAction});

  @override
  State<_WindowPopup> createState() => _WindowPopupState();
}

class _WindowPopupState extends State<_WindowPopup> {
  bool showLoading = true;

  @override
  Widget build(BuildContext context) {
    final safePaddingTop = AppBar().preferredSize.height;
    return Stack(children: [
      Container(
          padding: EdgeInsets.fromLTRB(0, safePaddingTop, 0, 0),
          child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32.0),
                ),
              ),
              child: InAppWebView(
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<OneSequenceGestureRecognizer>(
                    () => EagerGestureRecognizer(),
                  ),
                },
                onProgressChanged: (_, progress) {
                  if (progress >= 100) {
                    setState(() {
                      showLoading = false;
                    });
                  }
                },
                windowId: widget.createWindowAction.windowId,
                onCloseWindow: (controller) {
                  Navigator.pop(context);
                },
              ))),
      if (showLoading) const Center(child: CircularProgressIndicator())
    ]);
  }
}
