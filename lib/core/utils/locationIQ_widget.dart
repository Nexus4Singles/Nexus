import 'package:flutter/material.dart';
import 'package:nexus/core/services/api_service.dart';
import 'package:rxdart/rxdart.dart';
import '../models/locationIQModel.dart';

class LocationIQWidget extends StatefulWidget {
  final InputDecoration inputDecoration;
  TextStyle textStyle;
  final String locationIQAPIKey;
  int debounceTime = 600;
  final TextEditingController textEditingController;
  Widget? seperatedBuilder;
  void clearData;
  Function(LocationIqModel) onClick;
  BoxDecoration? boxDecoration;
  bool isCrossBtnShown;
  bool? showError;
  double? containerHorizontalPadding;
  double? containerVerticalPadding;
  FocusNode? focusNode;
  LocationIQWidget(
      {super.key,
      required this.inputDecoration,
      required this.onClick,
      required this.textEditingController,
      required this.textStyle,
      required this.locationIQAPIKey,
      this.seperatedBuilder,
      this.clearData,
      this.boxDecoration,
      required this.isCrossBtnShown,
      this.showError,
      required this.debounceTime,
      this.containerHorizontalPadding,
      this.containerVerticalPadding,
      this.focusNode});

  @override
  State<LocationIQWidget> createState() => _LocationIQWidgetState();
}

class _LocationIQWidgetState extends State<LocationIQWidget> {
  final subject = PublishSubject<String>();
  TextEditingController controller = TextEditingController();
  final LayerLink _layerLink = LayerLink();
  bool isSearched = false;
  OverlayEntry? _overlayEntry;
  final ApiService service = ApiService();

  List<LocationIqModel> alPredictions = <LocationIqModel>[];

  // pk.da653605da38d00bec98323b179bd52e

  OverlayEntry? createOverlayEntry() {
    if (context.findRenderObject() != null) {
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      var size = renderBox.size;
      var offset = renderBox.localToGlobal(Offset.zero);
      return OverlayEntry(
          builder: (context) => Positioned(
                left: offset.dx,
                top: size.height + offset.dy,
                width: size.width,
                child: CompositedTransformFollower(
                  showWhenUnlinked: false,
                  link: _layerLink,
                  offset: Offset(0.0, size.height + 5.0),
                  child: Material(
                      child: ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: alPredictions.length,
                    separatorBuilder: (context, pos) =>
                        widget.seperatedBuilder ?? const SizedBox(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          var selectedData = alPredictions[index];
                          if (index < alPredictions.length) {
                            widget.textEditingController.text =
                                selectedData.displayName ?? "";
                            widget.onClick(selectedData);
                            removeOverlay();
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(alPredictions[index].displayName ?? ""),
                        ),
                      );
                    },
                  )),
                ),
              ));
    }
    return null;
  }

  removeOverlay() {
    alPredictions.clear();
    _overlayEntry = createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    _overlayEntry!.markNeedsBuild();
  }

  getLocation(String text) async {
    String apiURL =
        "https://api.locationiq.com/v1/autocomplete?key=pk.da653605da38d00bec98323b179bd52e&q=$text";
    return service.get(text.isEmpty ? "" : apiURL, onSuccess: (response) {
      var data = (response!.data as List);
      var responseData =
          data.map((val) => LocationIqModel.fromJson(val)).toList();
      if (text.isEmpty) {
        alPredictions.clear();
        _overlayEntry!.remove();
        return;
      }

      isSearched = false;
      alPredictions.clear();
      if (responseData.isNotEmpty &&
          (widget.textEditingController.text.toString().trim()).isNotEmpty) {
        alPredictions.addAll(responseData);
      }

      _overlayEntry = null;
      _overlayEntry = createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry!);
    }, onError: (res) {
      _showSnackBar(res!.data['error']);
    });
  }

  _showSnackBar(String errorData) {
    if (widget.showError!) {
      final snackBar = SnackBar(
        content: Text("$errorData"),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    super.initState();
    subject.stream
        .distinct()
        .debounceTime(Duration(milliseconds: widget.debounceTime))
        .listen(textChanged);
  }

  textChanged(String text) async {
    debugPrint("this is the text that goes => $text");
    text.isEmpty ? removeOverlay() : getLocation(text);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: widget.containerHorizontalPadding ?? 0,
            vertical: widget.containerVerticalPadding ?? 0),
        alignment: Alignment.centerLeft,
        decoration: widget.boxDecoration ??
            BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Colors.grey, width: 0.6),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                decoration: widget.inputDecoration,
                style: widget.textStyle,
                controller: widget.textEditingController,
                focusNode: widget.focusNode ?? FocusNode(),
                onChanged: (string) {
                  subject.add(string);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
