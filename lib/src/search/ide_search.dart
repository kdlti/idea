import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idea/package.dart';
import 'package:idea/src/search/popup/ide_search_popup.dart';

class IdeSearch extends StatefulWidget {
  final List<IdeSearchPopupItem>? searchColumns;
  final String? title;
  final String? message;
  final bool? showCloseButton;
  final double width;
  final ValueChanged<IdeSearchResult> onChanged;
  final bool autoSend;

  const IdeSearch({
    super.key,
    this.searchColumns,
    this.title,
    this.message,
    this.showCloseButton = true,
    this.width = 230,
    this.autoSend = false,
    required this.onChanged,
  });

  @override
  IdeSearchState createState() => IdeSearchState();
}

class IdeSearchState extends State<IdeSearch> {
  final TextEditingController _controller = TextEditingController(text: "");
  String dropdownValue = 'Nome da tarefa';
  bool showClearIcon = false;
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;
  String lastSearch = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onSearchChanged);
    _debounce?.cancel(); // Cancela o timer ao sair
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      showClearIcon = _controller.text.isNotEmpty;
    });

    if(!widget.autoSend) {
      return;
    }

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 600), () {
      final String searchText = _controller.text;
      if (searchText.isNotEmpty && searchText != lastSearch) {
        lastSearch = searchText;
        widget.onChanged(
          IdeSearchResult(
            search: _controller.text,
            columns: widget.searchColumns!,
            isSearch: _controller.text.isNotEmpty,
            event: IdeSearchEventType.search,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: TextField(
        cursorHeight: 20,
        cursorColor: Colors.blueAccent,
        focusNode: _focusNode,
        controller: _controller,
        style: const TextStyle(fontSize: 14),
        onSubmitted: (String value) {
          widget.onChanged(
            IdeSearchResult(
              search: _controller.text,
              columns: widget.searchColumns!,
              isSearch: _controller.text.isNotEmpty,
              event: IdeSearchEventType.search,
            ),
          );
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 4),
          hintText: 'Digite para pesquisar',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 0.5),
            borderRadius: BorderRadius.circular(4.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent, width: 1.0),
            borderRadius: BorderRadius.circular(4.0),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 35,
            minHeight: 30,
          ),
          prefixIcon: IdeCustomIconButton(
            icon: Icons.search,
            onPressed: () {
              FocusScope.of(context).requestFocus(_focusNode);
              _controller.selection = TextSelection.fromPosition(
                TextPosition(offset: _controller.text.length),
              );
              widget.onChanged(
                IdeSearchResult(
                  search: _controller.text,
                  columns: widget.searchColumns!,
                  isSearch: _controller.text.isNotEmpty,
                  event: IdeSearchEventType.search,
                ),
              );
            },
            decoration: const IdeIconButtonDecoration(
              margin: EdgeInsets.all(2),
            ),
          ),
          suffixIconConstraints: const BoxConstraints(
            minWidth: 28,
            minHeight: 28,
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              showClearIcon
                  ? IdeCustomIconButton(
                      icon: Icons.clear,
                      width: 26,
                      height: 26,
                      onPressed: () {
                        _controller.clear();
                        lastSearch = ''; // Limpa a última busca ao limpar o campo
                        widget.onChanged(
                          IdeSearchResult(
                            search: _controller.text,
                            columns: widget.searchColumns!,
                            isSearch: _controller.text.isNotEmpty,
                            event: IdeSearchEventType.reset,
                          ),
                        );
                      },
                    )
                  : const SizedBox(height: 26, width: 26), // Renderiza um SizedBox vazio quando showClearIcon é falso
              widget.searchColumns != null
                  ? IdeSearchPopup(
                      children: widget.searchColumns!,
                      title: widget.title,
                      message: widget.message,
                      showCloseButton: widget.showCloseButton,
                      width: widget.width,
                      onChanged: () {
                        widget.onChanged(
                          IdeSearchResult(
                            search: _controller.text,
                            columns: widget.searchColumns!,
                            isSearch: _controller.text.isNotEmpty,
                            event: IdeSearchEventType.selectColumns,
                          ),
                        );
                      },
                    )
                  : const SizedBox.shrink(), // Renderiza um SizedBox vazio quando searchColumns é nulo
              const SizedBox(width: 3),
            ],
          ),
        ),
      ),
    );
  }
}
