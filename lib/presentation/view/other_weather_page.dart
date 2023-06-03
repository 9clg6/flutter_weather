import 'package:flutter/material.dart';

class OtherWeatherPage extends StatefulWidget {
  const OtherWeatherPage({Key? key}) : super(key: key);

  @override
  State<OtherWeatherPage> createState() => _OtherWeatherPageState();
}

class _OtherWeatherPageState extends State<OtherWeatherPage> {
  final _cityTextController = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 5),
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: TextFormField(
                    controller: _cityTextController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Quelle ville ?",
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 5),
                child: FractionallySizedBox(
                  widthFactor: 0.7,
                  child: TextFormField(
                    controller: _dateController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Quel jour ?",
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
