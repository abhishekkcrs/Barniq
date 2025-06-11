import 'package:flutter/material.dart';

class DailyNeedsPage extends StatefulWidget {
  final List<Map<String, String>> categories;
  const DailyNeedsPage({Key? key, required this.categories}) : super(key: key);

  @override
  State<DailyNeedsPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<DailyNeedsPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Needs'),
        backgroundColor: Color(0xFFFFF3C1),
        iconTheme: IconThemeData(color: Colors.brown),
        titleTextStyle: TextStyle(
          color: Colors.brown,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        elevation: 0,
      ),
      backgroundColor: Color(0xFFFFF3C1),
      body: Row(
        children: [
          // Left vertical menu
          Container(
            width: 110,
            color: Colors.white,
            child: ListView.builder(
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                final isSelected = index == selectedIndex;
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    color: isSelected ? Color(0xFFFFF3C1) : Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            widget.categories[index]['image']!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.categories[index]['label']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected ? Colors.brown : Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Main content area
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.categories[selectedIndex]['image']!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.categories[selectedIndex]['label']!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.brown,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
