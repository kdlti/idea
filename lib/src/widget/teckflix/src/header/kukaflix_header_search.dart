import 'dart:async';

import 'package:flutter/material.dart';

class HeaderSearch extends StatefulWidget {
  final String hintText;
  final ValueChanged<String> onSearch;

  const HeaderSearch({
    super.key,
    this.hintText = 'Procurar...',
    required this.onSearch,
  });

  @override
  _HeaderSearchState createState() => _HeaderSearchState();
}

class _HeaderSearchState extends State<HeaderSearch> {
  bool _isExpanded = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {
          _isExpanded = false;
          _searchController.clear();
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onSearch(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: _isExpanded ? 230 : 35,
          height: 40,
          child: TextField(
            controller: _searchController,
            focusNode: _focusNode,
            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
            onChanged: _onSearchChanged,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 10),
              prefixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                    if (_isExpanded) {
                      _focusNode.requestFocus();
                    } else {
                      _focusNode.unfocus();
                    }
                  });
                },
              ),
              suffixIcon: _isExpanded
                  ? IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                      },
                    )
                  : null,
              hintText: widget.hintText,
              hintStyle: TextStyle(color: Colors.white70, fontSize: 12),
              border: _isExpanded
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                    )
                  : InputBorder.none,
              focusedBorder: _isExpanded
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide(color: Colors.white60, width: 1),
                    )
                  : InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
