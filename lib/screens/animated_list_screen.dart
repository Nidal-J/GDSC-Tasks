import 'dart:developer';

import 'package:flutter/material.dart';

class AnimatedListScreen extends StatefulWidget {
  const AnimatedListScreen({super.key});

  @override
  State<AnimatedListScreen> createState() => _AnimatedListScreenState();
}

class _AnimatedListScreenState extends State<AnimatedListScreen> {
  final List<int> _list = [];
  final animatedKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Animated List'),
      ),
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              _list.add(_list.length + 1);
              animatedKey.currentState?.insertItem(
                _list.length - 1,
                duration: const Duration(milliseconds: 500),
              );
              log(_list.length.toString());
            },
            icon: const Icon(Icons.add),
          ),
          Expanded(
            child: AnimatedList(
              key: animatedKey,
              initialItemCount: _list.length,
              itemBuilder: (context, index, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  child: Card(
                    color: Colors.amber,
                    child: ListTile(
                      title: Text('Item ${_list[index]}'),
                      trailing: InkWell(
                        onTap: () async {
                          _list.removeAt(index);
                          animatedKey.currentState?.removeItem(
                            index,
                            (context, animation) => SizeTransition(
                              sizeFactor: animation,
                              child: Card(
                                color: Colors.red[400],
                                child: const ListTile(
                                  title: Center(
                                    child: Text(
                                      'Deleted',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: const Icon(Icons.delete, size: 24),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
