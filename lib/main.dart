import 'package:flutter/material.dart';

void main() {
  runApp(MuseumApp());
}

class Museum {
  final String name;
  final String region;
  final String visitors;
  final String description;
  final String imagePath;

  Museum({
    required this.name,
    required this.region,
    required this.visitors,
    required this.description,
    required this.imagePath,
  });
}

class RegionInfo {
  final String region;
  final List<Museum> museums;

  RegionInfo({
    required this.region,
    required this.museums,
  });
}

class MuseumApp extends StatelessWidget {
  final List<Museum> topMuseums = List.generate(
    20,
        (index) => Museum(
      name: "Mashhur muzey ${index + 1}",
      region: "Viloyat ${(index % 14) + 1}",
      visitors: "${(1000 - index * 20)} ming kishi",
      description: "Bu mashhur muzey haqida tavsif. U oʻzining boy tarixi bilan mashhur.",
      imagePath: "assets/images/img${index + 1}.jpg",
    ),
  );

  late final List<RegionInfo> regions = [
    RegionInfo(region: "Toshkent shahri", museums: topMuseums.sublist(0, 2)),
    RegionInfo(region: "Toshkent viloyati", museums: topMuseums.sublist(2, 3)),
    RegionInfo(region: "Andijon", museums: topMuseums.sublist(3, 4)),
    RegionInfo(region: "Fargʻona", museums: topMuseums.sublist(4, 5)),
    RegionInfo(region: "Namangan", museums: topMuseums.sublist(5, 6)),
    RegionInfo(region: "Samarqand", museums: topMuseums.sublist(6, 7)),
    RegionInfo(region: "Buxoro", museums: topMuseums.sublist(7, 8)),
    RegionInfo(region: "Xorazm", museums: topMuseums.sublist(8, 9)),
    RegionInfo(region: "Qashqadaryo", museums: topMuseums.sublist(9, 10)),
    RegionInfo(region: "Surxondaryo", museums: topMuseums.sublist(10, 11)),
    RegionInfo(region: "Jizzax", museums: topMuseums.sublist(11, 12)),
    RegionInfo(region: "Sirdaryo", museums: topMuseums.sublist(12, 13)),
    RegionInfo(region: "Navoiy", museums: topMuseums.sublist(13, 14)),
    RegionInfo(region: "Qoraqalpogʻiston", museums: topMuseums.sublist(14, 20)),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Oʻzbekiston Muzeylari',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFFDE7),
        fontFamily: 'Roboto',
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange.shade700,
            elevation: 4,
            title: Text(
              'Oʻzbekiston Muzeylari',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            bottom: TabBar(
              indicatorColor: Colors.green,
              labelColor: Colors.green.shade900,
              unselectedLabelColor: Colors.white,
              tabs: const [
                Tab(icon: Icon(Icons.star), text: "Eng ko‘p tashrif"),
                Tab(icon: Icon(Icons.map), text: "Hududlar bo‘yicha"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              buildTopMuseumsTab(context),
              buildRegionsTab(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopMuseumsTab(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: topMuseums.length,
      itemBuilder: (context, index) {
        final museum = topMuseums[index];
        return buildMuseumCard(context, museum);
      },
    );
  }

  Widget buildMuseumCard(BuildContext context, Museum museum) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MuseumDetailPage(museum: museum),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
                child: Image.asset(
                  museum.imagePath,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(museum.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 6),
                      Text(museum.region),
                      SizedBox(height: 6),
                      Text("Tashrifchilar: ${museum.visitors}"),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRegionsTab(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: regions.length,
      itemBuilder: (context, index) {
        final region = regions[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RegionMuseumsPage(regionInfo: region),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.3),
                    blurRadius: 8,
                    offset: Offset(0, 5),
                  )
                ],
              ),
              child: ListTile(
                leading: Icon(Icons.location_city, color: Colors.green),
                title: Text(region.region, style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("Muzeylar soni: ${region.museums.length}"),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal),
              ),
            ),
          ),
        );
      },
    );
  }
}

class RegionMuseumsPage extends StatelessWidget {
  final RegionInfo regionInfo;

  RegionMuseumsPage({required this.regionInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: Text(regionInfo.region, style: TextStyle(color: Colors.white)),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 80),
        itemCount: regionInfo.museums.length,
        itemBuilder: (context, index) {
          final museum = regionInfo.museums[index];
          return MuseumApp().buildMuseumCard(context, museum);
        },
      ),
    );
  }
}

class MuseumDetailPage extends StatelessWidget {
  final Museum museum;

  MuseumDetailPage({required this.museum});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange.shade700,
        title: Text(museum.name, style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                museum.imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text("Hudud: ${museum.region}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text("Tashrifchilar: ${museum.visitors}", style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text(museum.description, style: TextStyle(fontSize: 14, color: Colors.grey.shade800)),
            SizedBox(height: 20),
            Text("Qoʻshimcha maʼlumotlar:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(height: 10),
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
          ],
        ),
      ),
    );
  }
}
