import 'dart:io';

import 'package:flutter/material.dart';
import 'package:masterbagasi/misc/ext/string_ext.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../domain/entity/video/defaultvideo/default_video.dart';
import '../../../misc/constant.dart';
import '../../../misc/string_util.dart';
import '../modified_loading_indicator.dart';

class DefaultVideoItem extends StatelessWidget {
  final DefaultVideo defaultVideo;

  const DefaultVideoItem({
    super.key,
    required this.defaultVideo
  });

  @override
  Widget build(BuildContext context) {
    BorderRadius borderRadius = BorderRadius.circular(8.0);
    return Padding(
      padding: const EdgeInsets.only(top: 1.0, bottom: 5.0),
      child: Material(
        color: Colors.white,
        borderRadius: borderRadius,
        elevation: 3,
        child: InkWell(
          onTap: () {},
          borderRadius: borderRadius,
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: borderRadius
            ),
            child: SizedBox(
              height: 170,
              child: AspectRatio(
                aspectRatio: Constant.aspectRatioValueDefaultVideo.toDouble(),
                child: _DefaultVideoPlayer(
                  defaultVideo: defaultVideo,
                )
              ),
            )
          )
        )
      )
    );
  }
}

class _DefaultVideoPlayer extends StatefulWidget {
  final DefaultVideo defaultVideo;

  const _DefaultVideoPlayer({
    required this.defaultVideo
  });

  @override
  State<_DefaultVideoPlayer> createState() => _DefaultVideoPlayerState();
}

class _DefaultVideoPlayerState extends State<_DefaultVideoPlayer> {
  bool _isLoading = true;
  int _progress = 0;
  WebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    String? effectiveUrl = StringUtil.convertYoutubeLinkUrlToId(widget.defaultVideo.url);
    String baseUrl = effectiveUrl.isNotEmptyString ? "https://www.youtube.com/${widget.defaultVideo.url}" : widget.defaultVideo.url;
    String embedUrl = effectiveUrl.isNotEmptyString ? "https://www.youtube.com/embed/$effectiveUrl" : widget.defaultVideo.url;
    return IndexedStack(
      index: _isLoading ? 0 : 1,
      children: [
        const Center(
          child: ModifiedLoadingIndicator()
        ),
        WebView(
          initialUrl: baseUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onProgress: (int progress) async {
            _progress = progress;
            setState(() {});
            if (_isLoading && _progress == 100) {
              await _onPageFinishedLoading();
            } else if (!_isLoading) {
              _onPageStartedLoading();
            }
          },
          zoomEnabled: false,
          onPageStarted: (String url) => _onPageStartedLoading(),
          onPageFinished: (String url) async => await _onPageFinishedLoading(),
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;
            //_webViewController?.
            _webViewController?.loadHtmlString(
              '''<html><head><meta name="viewport" content="width=device-width,initial-scale=1"></head><body><iframe id="youtube-iframe" src="$embedUrl?enablejsapi=1&autoplay=1&fs=0" frameborder="0" style="position:fixed;top:0;left:0;bottom:0;right:0;width:100%;height:100%;border:none;margin:0;padding:0;overflow:hidden;z-index:999999"></iframe><script type="text/javascript">var tag=document.createElement("script");tag.id="iframe-demo",tag.src="https://www.youtube.com/iframe_api";var player,firstScriptTag=document.getElementsByTagName("script")[0];function onYouTubeIframeAPIReady(){player=new YT.Player("youtube-iframe",{events:{onReady:onPlayerReady,onStateChange:onPlayerStateChange}})}function onPlayerReady(e){document.getElementById("existing-iframe-example").style.borderColor="#FF6D00"}function changeBorderColor(e){-1==e||0==e&&Print.postMessage("Ended")}function onPlayerStateChange(e){changeBorderColor(e.data)}firstScriptTag.parentNode.insertBefore(tag,firstScriptTag)</script></body></html>''',
              baseUrl: baseUrl
            );
          },
        ),
      ]
    );
  }

  Future<void> _onPageFinishedLoading() async {
    setState(() => _isLoading = false);
    _webViewController?.scrollTo(0, 0);
  }

  void _onPageStartedLoading() {
    setState(() => _isLoading = true);
  }
}