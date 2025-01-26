import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:idea/src/dropdown/example/lib/models/job.dart';
import 'package:idea/src/dropdown/ide_dropdown.dart';

Future<List<Job>> _getFakeRequestData(String query) async {
  return await Future.delayed(const Duration(seconds: 1), () {
    return jobItems.where((e) {
      return e.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  });
}

class SearchRequestDropdown extends StatelessWidget {
  const SearchRequestDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IdeDropdown<Job>.searchRequest(
      futureRequest: _getFakeRequestData,
      hintText: 'Search job role',
      onChanged: (value) {
        log('SearchRequestDropdown onChanged value: $value');
      },
      searchRequestLoadingIndicator: const Center(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}

class MultiSelectSearchRequestDropdown extends StatelessWidget {
  const MultiSelectSearchRequestDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IdeDropdown<Job>.multiSelectSearchRequest(
      futureRequest: _getFakeRequestData,
      hintText: 'Search job role',
      onListChanged: (value) {
        log('MultiSelectSearchDropdown onChanged value: $value');
      },
    );
  }
}
