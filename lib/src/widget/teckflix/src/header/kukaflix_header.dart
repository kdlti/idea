import 'package:flutter/material.dart';
import 'package:idea/src/widget/teckflix/src/header/kukaflix_header_search.dart';
import 'package:idea/src/widget/teckflix/src/header/menu/header_menu.dart';

class KukaflixSearch {
  final String text;
  final bool isKids;

  KukaflixSearch({
    required this.text,
    required this.isKids,
  });
}

class KukaflixHeader extends StatelessWidget {
  final VoidCallback onClickHome;
  final VoidCallback onClickKids;
  final ValueChanged<KukaflixSearch> onSearch;
  final String urlLogo;
  final String hintTextSearch;
  final bool isKids;
  final HeaderMenu menu;

  const KukaflixHeader({
    super.key,
    required this.onClickHome,
    required this.onClickKids,
    required this.onSearch,
    required this.urlLogo,
    required this.isKids,
    this.hintTextSearch = 'Procurar...',
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 58),
      color: Colors.yellowAccent,
      width: MediaQuery.of(context).size.width,
      height: 68,
      child: Row(
        children: [
          InkWell(
            onTap: onClickHome,
            child: Container(
              margin: const EdgeInsets.only(right: 25),
              color: Colors.red,
              width: 92,
              height: 25,
              child: Image.network(urlLogo),
            ),
          ),
          menu,
          Spacer(),
          HeaderSearch(
            hintText: hintTextSearch,
            onSearch: (String value) {
              onSearch(KukaflixSearch(text: value, isKids: isKids));
            },
          ),
          SizedBox(width: 8),
          if(isKids)
          InkWell(
            onTap: onClickKids,
            child: Text(
              "Infantil",
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.white70,
                )),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            ),
            width: 32,
            height: 32,
          ),
          Icon(Icons.arrow_drop_down, color: Colors.white70),
        ],
      ),
    );
  }
}
