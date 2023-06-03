import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final Future<void> Function(String formText) endingOnTap;

  const CustomSearchBar({Key? key, required this.endingOnTap}) : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  bool _isArrowVisible = false;
  final _cityTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _cityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 50,
          width: 300,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.primary),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 200,
                child: TextFormField(
                  controller: _cityTextController,
                  onFieldSubmitted: (_) {
                    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                      widget.endingOnTap(_cityTextController.text);
                    }
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Merci d'insérer le nom d'une ville";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      if (value.isNotEmpty) {
                        _isArrowVisible = true;
                      } else {
                        _isArrowVisible = false;
                      }
                    });
                  },
                  decoration: InputDecoration(
                    icon: const Icon(Icons.search),
                    iconColor: Theme.of(context).colorScheme.tertiary,
                    border: InputBorder.none,
                    hintText: "Rechercher une ville",
                  ),
                ),
              ),
              if (_isArrowVisible)
                InkWell(
                  child: Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () async {
                    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                      widget.endingOnTap(_cityTextController.text);
                    }
                  },
                )
            ],
          ),
        ),
      ),
    );
  }
}
