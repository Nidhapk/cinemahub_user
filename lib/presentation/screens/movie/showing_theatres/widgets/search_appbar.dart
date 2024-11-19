import 'package:flutter/material.dart';

PreferredSizeWidget searchAppbarInNowShowingPage({required void Function()? closeOnPressed,void Function(String)? searchOnChanged}){
  return AppBar(
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.close,
                        size: 18, color: Color.fromARGB(255, 114, 114, 114)),
                    onPressed: closeOnPressed
                  ),
                ],
                title: TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Search theatres...',
                    border: InputBorder.none,
                  ),
                   onChanged: searchOnChanged
                 
                ),
              );
}