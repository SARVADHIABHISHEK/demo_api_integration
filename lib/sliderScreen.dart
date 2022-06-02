import 'package:api_intregraion/api_model.dart';
import 'package:flutter/material.dart';

class SliderScreen extends StatefulWidget {
  final List<ApiModel> todo;

  const SliderScreen({Key key, this.todo}) : super(key: key);

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Slider Images'),
      ),
      body: GridView.builder(
          itemCount: widget.todo.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 3 : 2,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: (2 / 1.2),
          ),
          itemBuilder: (context, index) {
            final item = widget.todo[index];
            final List<String> images = item.sliderImages.map((e) => e.image).toList();
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(images[index])),
                ),
              ),
            );
          }),
    );
  }
}
