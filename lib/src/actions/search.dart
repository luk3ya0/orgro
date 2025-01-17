import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MySearchDelegate {
  MySearchDelegate({
    required this.onQueryChanged,
    required this.onQuerySubmitted,
    String? initialQuery,
  }) : _searchController = TextEditingController(text: initialQuery) {
    _searchController.addListener(_searchQueryChanged);
  }

  final Function(String) onQueryChanged;
  final Function(String) onQuerySubmitted;
  final ValueNotifier<bool> searchMode = ValueNotifier(false);
  final TextEditingController _searchController;

  Widget buildSearchField() => SearchField(
        _searchController,
        onClear: _clearSearchQuery,
        onSubmitted: onQuerySubmitted,
      );

  void dispose() {
    _searchController.dispose();
  }

  void start(BuildContext context) {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    searchMode.value = true;
  }

  void _stopSearch() {
    searchMode.value = false;
  }

  void _clearSearchQuery() {
    _searchController.clear();
    onQuerySubmitted(_searchController.text);
  }

  void _searchQueryChanged() => onQueryChanged(_searchController.text);

  bool get hasQuery => _searchController.value.text.isNotEmpty;

  String get queryString => _searchController.value.text;
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    required this.hasQuery,
    required this.onPressed,
    super.key,
  });
  final VoidCallback onPressed;
  final bool hasQuery;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: onPressed,
        ),
        // Badge indicating an active query. The size and positioning is
        // manually adjusted to match the icon it adorns. The icon is assumed to
        // take up an a kMinInteractiveDimension × kMinInteractiveDimension
        // area.
        Positioned(
          top: kMinInteractiveDimension / 3,
          right: kMinInteractiveDimension / 3,
          child: Visibility(
            visible: hasQuery,
            child: Container(
              height: kMinInteractiveDimension / 6,
              width: kMinInteractiveDimension / 6,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField(
    this._controller, {
    this.onClear,
    this.onSubmitted,
    super.key,
  });
  final TextEditingController _controller;
  final VoidCallback? onClear;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    // All these theme gyrations are to try to match the default appearance of
    // regular text in the AppBar
    final theme = Theme.of(context);
    final style = DefaultTextStyle.of(context).style;
    final color = style.color?.withOpacity(0.7);
    final iconTheme = IconThemeData(color: color);
    return Theme(
      data: theme.copyWith(hintColor: color),
      child: TextField(
        autofocus: true,
        style: style,
        controller: _controller,
        textInputAction: TextInputAction.search,
        cursorColor: theme.colorScheme.secondary,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.hintTextSearch,
          border: InputBorder.none,
          prefixIcon: IconTheme.merge(
            data: iconTheme,
            child: const Icon(Icons.search),
          ),
          suffixIcon: IconTheme.merge(
            data: iconTheme,
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller,
              builder: (context, value, child) =>
                  value.text.isNotEmpty ? child! : const SizedBox.shrink(),
              child: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: onClear,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
