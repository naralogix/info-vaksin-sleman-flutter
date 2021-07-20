import 'package:flutter/material.dart';
import 'package:info_vaksin_sleman/models/faskes.dart';
import 'package:info_vaksin_sleman/models/vac_schedule.dart';

class FaskesCard extends StatelessWidget {
  const FaskesCard(this.faskes);
  final Faskes faskes;

  @override
  Widget build(BuildContext context) {
    final List<VacSchedule>? daftarJadwalVaksin = faskes.daftarJadwalVaksin;
    final bool hasEmptySlot = faskes.hasEmptySlot;
    if (daftarJadwalVaksin != null) {
      daftarJadwalVaksin.sort((VacSchedule a, VacSchedule b) =>
          (a.tanggalVaksin).compareTo(b.tanggalVaksin));
    }
    return Card(
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: hasEmptySlot ? null : Colors.black26,
          child: Icon(
            hasEmptySlot
                ? Icons.event_available_outlined
                : Icons.event_busy_outlined,
            color: hasEmptySlot ? Colors.white : Colors.white70,
          ),
        ),
        title: Text(faskes.nama,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: hasEmptySlot ? Colors.blue[800] : Colors.black54,
                )),
        subtitle: Text(
            hasEmptySlot ? 'Ada jadwal kosong' : 'Jadwal penuh / tidak ada',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: hasEmptySlot ? Colors.black87 : Colors.black54,
                )),
        children: <Widget>[
          const Divider(),
          if (daftarJadwalVaksin != null)
            ...daftarJadwalVaksin.map(
              (VacSchedule x) {
                final List<String> date = x.tanggalVaksin.split('-');
                final String tanggal = date[2];
                final String bulan = date[1];
                final String tahun = date[0];
                return ListTile(
                  contentPadding:
                      const EdgeInsets.fromLTRB(72.0, 0.0, 16.0, 0.0),
                  dense: true,
                  title: Text(
                    '$tanggal-$bulan-$tahun',
                    style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: Colors.grey[800],
                        ),
                  ),
                  subtitle: Text('Quota: ${x.quota} Sisa: ${x.sisa}'),
                );
              },
            ).toList()
          else
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(72.0, 0.0, 16.0, 0.0),
              dense: true,
              title: Text(
                'Belum ada jadwal yang diupload',
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: Colors.grey[800],
                    ),
              ),
            ),
        ],
      ),
    );
  }
}
