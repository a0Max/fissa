import 'package:flutter/material.dart';

import '../../../../core/app_color.dart';
import '../../../../core/border_manager.dart';

class SearchMapPlaceWidget extends StatefulWidget {
  SearchMapPlaceWidget({
    // required this.apiKey,
    this.placeholder = 'Search',
    this.icon = Icons.search,
    this.hasClearButton = true,
    this.clearIcon = Icons.clear,
    this.iconColor = Colors.blue,
    required this.onSearch,
    this.bgColor = Colors.blue,
    this.textColor = Colors.white,
    this.key,
    required this.onTapOutside,
    this.text,
    required this.onTap,
    required this.suffixIconOnTap,
  }) : super(key: key);

  final Key? key;
  final String placeholder;
  final String? text;
  final void Function(String text) onSearch;
  final IconData icon;
  final bool hasClearButton;
  final IconData clearIcon;
  final Color iconColor;
  final Color bgColor;
  final Color textColor;
  final Function() onTap;
  final Function() suffixIconOnTap;
  final Function() onTapOutside;
  @override
  _SearchMapPlaceWidgetState createState() => _SearchMapPlaceWidgetState();
}

class _SearchMapPlaceWidgetState extends State<SearchMapPlaceWidget>
    with TickerProviderStateMixin {
  TextEditingController _textEditingController = TextEditingController();
  bool _isEditing = false;

  String _tempInput = "";
  String _currentInput = "";

  FocusNode _fn = FocusNode();

  CrossFadeState? _crossFadeState;

  @override
  void initState() {
    _textEditingController.addListener(_autocompletePlace);
    customListener();

    if (widget.hasClearButton) {
      _fn.addListener(() async {
        if (_fn.hasFocus)
          setState(() => _crossFadeState = CrossFadeState.showSecond);
        else
          setState(() => _crossFadeState = CrossFadeState.showFirst);
      });
      _crossFadeState = CrossFadeState.showFirst;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 4),
        child: _searchInput(context),
      );

  Widget _searchInput(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
        decoration: _inputStyle(),
        controller: widget.text != null
            ? TextEditingController(text: widget.text)
            : _textEditingController,
        onSubmitted: (_) => _selectPlace(),
        onTap: () => widget.onTap(),
        onTapOutside: (_) => widget.onTapOutside(),
        onEditingComplete: _selectPlace,
        autofocus: false,
        focusNode: _fn,
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.04,
          color: widget.textColor,
        ),
      ),
    );
  }

  InputDecoration _inputStyle() {
    return InputDecoration(
      hintText: widget.placeholder,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      filled: true,
      fillColor: AppColor.lightGreyColor3,
      prefixIcon: Icon(widget.icon, color: widget.iconColor),
      suffixIcon: IconButton(
        onPressed: () {
          widget.suffixIconOnTap();
          // if (_crossFadeState == CrossFadeState.showSecond)
          _textEditingController.clear();
          _fn.unfocus();
        },
        icon: AnimatedCrossFade(
          crossFadeState: _crossFadeState!,
          duration: Duration(milliseconds: 300),
          firstChild: SizedBox(),
          secondChild: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.lightGreyColor2.withOpacity(.2)),
              child: Icon(Icons.clear, color: widget.iconColor)),
        ),
      ),
      enabledBorder: getRegularBorderStyle(color: Colors.transparent),
      focusedBorder:
          getFocusedBorderStyle(color: AppColor.mainColor, weight: 2),
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      hintStyle: TextStyle(
        color: widget.textColor,
      ),
    );
  }

  void _autocompletePlace() async {
    if (_fn.hasFocus) {
      setState(() {
        _currentInput = _textEditingController.text;
        _isEditing = true;
      });

      _textEditingController.removeListener(_autocompletePlace);

      if (_currentInput.length == 0) {
        _textEditingController.addListener(_autocompletePlace);
        return;
      }

      if (_currentInput == _tempInput) {
        widget.onSearch(_currentInput);

        _textEditingController.addListener(_autocompletePlace);
        return;
      }

      Future.delayed(Duration(milliseconds: 500), () {
        _textEditingController.addListener(_autocompletePlace);
        if (_isEditing == true) _autocompletePlace();
      });
    }
  }

  void _selectPlace({String? prediction}) async {
    if (prediction != null) {
      _textEditingController.value = TextEditingValue(
        text: prediction,
        selection: TextSelection.collapsed(
          offset: prediction.length,
        ),
      );
    } else {
      await Future.delayed(Duration(milliseconds: 500));
    }

    _closeSearch();
  }

  void _closeSearch() async {
    _fn.unfocus();
    setState(() {
      _isEditing = false;
    });
    _textEditingController.addListener(_autocompletePlace);
  }

  void customListener() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() => _tempInput = _textEditingController.text);
      customListener();
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _fn.dispose();
    super.dispose();
  }
}
