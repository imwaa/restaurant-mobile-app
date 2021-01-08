import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  SearchForm({this.onSearch});
  final void Function(String search) onSearch;

  @override
  _SearchFormState createState() => _SearchFormState();
}

/* ---------------------------------------
         COMPOSANT DE L'INTERFACE 
-----------------------------------------*/
class _SearchFormState extends State<SearchForm> {
  final _formKey = GlobalKey<FormState>();
  var _autoValidate = false;
  var _search;

  @override
  Widget build(context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Column(
              children: [
                /* -------------------------------
                   CONFIGURATION DE LA SEARCH BAR
                ----------------------------------*/
                TextFormField(
                  autofocus: false,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.redAccent,
                    ),
                    hintText: 'Effectuez votre recherche',
                    hintStyle: TextStyle(fontSize: 20),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.redAccent, width: 5.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.redAccent, width: 5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.redAccent, width: 3.0),
                    ),
                    filled: true,
                    errorStyle: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  onChanged: (value) {
                    _search = value;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Inserez quelque chose dans la barre de recherche';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),

                /* ---------------------- 
                   CONFIGURATION DU BOUTON
                -------------------------*/
                SizedBox(
                  width: double.infinity,
                  child: RawMaterialButton(
                      onPressed: () {
                        final isValid = _formKey.currentState.validate();
                        if (isValid) {
                          widget.onSearch(_search);
                          FocusManager.instance.primaryFocus.unfocus();
                        } else {
                          setState(() {
                            _autoValidate = true;
                          });
                        }
                      },
                      fillColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Chercher',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                          ),
                        ),
                      )),
                )
              ],
            )));
  }
}
