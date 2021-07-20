import 'package:flutter/material.dart';
import 'package:info_vaksin_sleman/models/faskes.dart';
import 'package:info_vaksin_sleman/pages/widgets/data_fetch_error.dart';
import 'package:info_vaksin_sleman/pages/widgets/faskes_card.dart';
import 'package:info_vaksin_sleman/repository/faskes_repository.dart';

class FaskesListPage extends StatefulWidget {
  const FaskesListPage({
    Key? key,
    required this.faskesRepository,
  }) : super(key: key);

  final FaskesRepository faskesRepository;

  @override
  _FaskesListPageState createState() => _FaskesListPageState();
}

class _FaskesListPageState extends State<FaskesListPage> {
  late Future<List<Faskes>> daftarFaskes;
  late DateTime _lastFetchDt;

  Future<List<Faskes>> _fetchFaskesList() {
    _lastFetchDt = DateTime.now();
    return widget.faskesRepository.fetchAllFaskesWithVaccinationSchedules();
  }

  @override
  void initState() {
    super.initState();
    daftarFaskes = _fetchFaskesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Info Vaksin Sleman'), actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.refresh_outlined),
          onPressed: () {
            setState(() {
              daftarFaskes = _fetchFaskesList();
            });
          },
        ),
        const SizedBox(width: 8.0),
      ]),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            daftarFaskes = _fetchFaskesList();
          });
        },
        child: FutureBuilder<List<Faskes>>(
          future: daftarFaskes,
          builder:
              (BuildContext context, AsyncSnapshot<List<Faskes>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return DataFetchError(
                    onRetry: () {
                      setState(() {
                        daftarFaskes = _fetchFaskesList();
                      });
                    },
                  );
                } else {
                  final List<Faskes> _daftarFaskes = snapshot.data!;
                  final DateTime dt = _lastFetchDt;
                  final List<String> _faskesWithEmptySlot = _daftarFaskes
                      .where((Faskes faskes) => faskes.hasEmptySlot)
                      .map((Faskes faskes) => faskes.nama)
                      .toList();
                  // final List<String> _faskesWithFullSlot = _faskesList
                  //     .where((Faskes faskes) => !faskes.hasEmptySlot)
                  //     .map((Faskes faskes) => faskes.nama)
                  //     .toList();
                  return ListView(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 16, 16),
                      child: DefaultTextStyle(
                        style: const TextStyle(color: Colors.black54),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                                'Data diambil pada ${dt.day}-${dt.month}-${dt.year}, ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}.'),
                            Text(
                                '${_daftarFaskes.length} data faskes berhasil diambil.'),
                            if (_faskesWithEmptySlot.isNotEmpty)
                              Text(
                                  'Ada jadwal kosong di faskes ${_faskesWithEmptySlot.join(", ")}.')
                            else
                              const Text(
                                'Belum ada jadwal kosong di semua faskes.',
                              ),
                          ],
                        ),
                      ),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: _daftarFaskes.length,
                        itemBuilder: (BuildContext context, int index) {
                          final Faskes faskes = _daftarFaskes[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            child: FaskesCard(faskes),
                          );
                        })
                  ]);
                }
            }
          },
        ),
      ),
    );
  }
}
