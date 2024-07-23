import 'package:flutter/material.dart';
import 'package:kitabulazkar/constants.dart';

import '../assets_path/azkar_search_indexes.dart';

class AzkarListScreen extends StatefulWidget {
  const AzkarListScreen({super.key});

  @override
  AzkarListScreenState createState() => AzkarListScreenState();
}

class AzkarListScreenState extends State<AzkarListScreen> {
  final TextEditingController _controller = TextEditingController();

  List<String> filteredSuggestions = [];
  int? selectedValue;

  @override
  void initState() {
    super.initState();
    _controller.addListener(filterSuggestions);
    filteredSuggestions = suggestionsMap.keys.toList();
  }

  void filterSuggestions() {
    final query = _controller.text.toLowerCase();
    setState(() {
      filteredSuggestions = suggestionsMap.keys.where((item) {
        return item.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(filterSuggestions);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomAppBar(),
      appBar: AppBar(
        title: const Text('Search by Zikr Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              textDirection: TextDirection.rtl,
              controller: _controller,
              cursorColor: kMainColor,
              decoration: const InputDecoration(
                labelText: 'Enter Zikr Name',
                labelStyle: TextStyle(color: Colors.black54),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredSuggestions.isEmpty
                  ? const Center(child: Text('No Zikr available'))
                  : ListView.builder(
                      itemCount: filteredSuggestions.length,
                      itemBuilder: (context, index) {
                        final key = filteredSuggestions[index];
                        return ListTile(
                          trailing: Text(
                            key,
                            style: kSuggestionTextColor,
                          ),
                          leading: Text(
                            suggestionsMap[key].toString(),
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          onTap: () {
                            // Handle the suggestion tap
                            _controller.text = key;
                            selectedValue = suggestionsMap[key];
                            Navigator.pop(context, selectedValue);
                            // print('Azkar List Page : $selectedValue');
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
