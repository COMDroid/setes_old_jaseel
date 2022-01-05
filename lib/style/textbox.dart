import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

InputDecoration textBoxStyle1(String ht, preIcon, {sufficIcon}) {
  return InputDecoration(
    hintText: ht,
    prefixIcon: Icon(preIcon, color: Colors.black45, size: 22),
    suffixIcon: sufficIcon,
    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
    hintStyle:
        const TextStyle(color: Colors.black12,fontSize: 12, fontWeight: FontWeight.w500),
    filled: true,
    fillColor: const Color.fromARGB(10, 255, 255, 255),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      borderSide: BorderSide(color: Color.fromARGB(10, 0, 0, 0), width: 2),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)),
      borderSide: BorderSide(color: Colors.black45),
    ),
  );
}

InputDecoration textBoxStyle2(String ht, preIcon, {sufficIcon}) {
  return InputDecoration(
    hintText: ht,
    prefixIcon: Icon(preIcon, color: Colors.black12),
    suffixIcon: sufficIcon,
    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
    hintStyle: const TextStyle(
      color: Colors.black26,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    filled: true,
    fillColor: const Color.fromARGB(20, 0, 0, 0),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(18)),
      borderSide: BorderSide(color: Colors.transparent, width: 1.5),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(18)),
      borderSide: BorderSide(color: Colors.transparent),
    ),
  );
}
