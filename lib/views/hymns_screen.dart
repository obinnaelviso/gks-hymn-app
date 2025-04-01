import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:gks_hymn/helpers/database_helper.dart';
import 'package:gks_hymn/models/hymn.dart';

class HymnsScreen extends StatefulWidget {
  const HymnsScreen({super.key});

  static const route = "/hymns";

  @override
  State<HymnsScreen> createState() => _HymnsScreenState();
}

class _HymnsScreenState extends State<HymnsScreen> {
  TextEditingController searchController = TextEditingController();
  List<Hymn> hymns = [];
  List<Hymn> filteredHymns = [];
  Hymn? currentHymn;
  PageController pageController = PageController();
  FontSize pageFontSize = FontSize.medium;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      hymns = await DatabaseHelper.instance.getHymns();
      currentHymn = hymns.first;
      filteredHymns = hymns;
      setState(() {});
    });
  }

  bool searchFound(Hymn searchHymn, String searchValue) {
    return (searchHymn.hymnNo
            .toLowerCase()
            .contains(searchValue.toLowerCase()) ||
        searchHymn.body.toLowerCase().contains(searchValue.toLowerCase()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Theocratic Songs Of Praise"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: searchController,
                onChanged: (text) {
                  setState(() {
                    filteredHymns =
                        hymns.where((hymn) => searchFound(hymn, text)).toList();
                    if (filteredHymns.isNotEmpty) {
                      currentHymn = filteredHymns.first;
                    }
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: TextButton(
                        onPressed: () {
                          setState(() {
                            searchController.text = '';
                            filteredHymns = hymns;
                          });
                        },
                        child: const Icon(Icons.cancel)),
                    hintText: "Search Hymns",
                    hintStyle: const TextStyle(
                      fontStyle: FontStyle.italic,
                    )),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Visibility(
                visible: searchController.text != '',
                child: const Text(
                  "Search Results:",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Visibility(
                visible: filteredHymns.isEmpty,
                child: const Expanded(
                  child: Center(
                    child: Text("No hymn found"),
                  ),
                ),
              ),
              Visibility(
                visible: filteredHymns.isNotEmpty,
                child: Expanded(
                  child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        if (filteredHymns.isNotEmpty) {
                          currentHymn = filteredHymns[index];
                        }
                      });
                    },
                    itemCount: filteredHymns.length,
                    itemBuilder: (context, index) {
                      final Hymn hymn = filteredHymns[index];
                      if (filteredHymns.isEmpty) {
                        return const Center(
                          child: Text("No result found for search"),
                        );
                      } else {
                        return GestureDetector(
                          onDoubleTap: () {
                            if (pageFontSize == FontSize.medium) {
                              setState(() {
                                pageFontSize = FontSize.larger;
                              });
                            } else {
                              setState(() {
                                pageFontSize = FontSize.medium;
                              });
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                hymn.hymnNo,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Html(data: hymn.body, style: {
                                    "p": Style(fontSize: pageFontSize),
                                    "li": Style(
                                      fontSize: pageFontSize,
                                      margin: Margins.only(
                                        top: 10.0,
                                      ),
                                    ),
                                  }),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Center(
                child: DropdownButton<Hymn>(
                  alignment: AlignmentDirectional.center,
                  items: filteredHymns.map<DropdownMenuItem<Hymn>>((Hymn hymn) {
                    return DropdownMenuItem<Hymn>(
                      value: hymn,
                      child: Text(
                        hymn.hymnNo,
                        textAlign: TextAlign.center,
                      ),
                    );
                  }).toList(),
                  onChanged: (hymn) {
                    pageController.jumpToPage(filteredHymns.indexOf(hymn!));
                  },
                  value: currentHymn,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
