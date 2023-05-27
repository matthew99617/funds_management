import 'package:flutter/material.dart';
import 'package:funds_management/presentation/screen/calendar/component/fake_data_list/basic_tile.dart';

class PlansTitleGroupList extends StatefulWidget {
  const PlansTitleGroupList({Key? key}) : super(key: key);

  @override
  State<PlansTitleGroupList> createState() => _PlansTitleGroupListState();
}

class _PlansTitleGroupListState extends State<PlansTitleGroupList> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: basicTiles.isEmpty ? Center(
        child: Text(
          "No Forward Plans",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ) : ListView(
        children: basicTiles.map(buildTile).toList(),
      ),
    );
  }
  
  Widget buildTile(BasicTile tile){
    if (tile.tiles.isEmpty){
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        child: ListTile(
          onTap: () {
            print("Tile: 123");
          },
          title: Text(
              tile.title
          ),
        ),
      );
    } else {
      return ExpansionTile(
        title: Text(tile.title),
        children: tile.tiles.map((tile) =>
            buildTile(tile)).toList(),
      );
    }
  }
}
