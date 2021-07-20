import 'package:flutter/material.dart';

class DataFetchError extends StatelessWidget {
  const DataFetchError({
    Key? key,
    this.onRetry,
  }) : super(key: key);

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.error_outline_outlined,
              size: 96.0, color: Colors.redAccent),
          const SizedBox(height: 24.0),
          Text('Gagal mengambil data',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.w300)),
          const SizedBox(height: 48.0),
          OutlinedButton(
            child: Text(
              'COBA LAGI',
              style: Theme.of(context)
                  .textTheme
                  .button
                  ?.copyWith(fontSize: 16.0, color: Colors.blue),
            ),
            onPressed: onRetry,
          ),
        ],
      ),
    );
  }
}
