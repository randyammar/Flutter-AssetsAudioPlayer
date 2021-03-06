import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SongsSelector extends StatelessWidget {
  final Playing playing;
  final List<Audio> audios;
  final Function(Audio) onSelected;
  final Function(List<Audio>) onPlaylistSelected;

  SongsSelector({@required this.playing, @required this.audios, @required this.onSelected, @required this.onPlaylistSelected});

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(9)),
      style: NeumorphicStyle(
        depth: -8,
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, position) {
                final item = this.audios[position];
                final isPlaying = item.path == this.playing?.audio?.assetAudioPath;
                return Neumorphic(
                  margin: EdgeInsets.all(4),
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                  style: NeumorphicStyle(
                    depth: isPlaying ? -4 : 0,
                  ),
                  child: ListTile(
                      leading: Material(
                        shape: CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: item.metas.image.type == ImageType.network
                            ? Image.network(
                                item.metas.image.path,
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                item.metas.image.path,
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                      ),
                      title: Text(item.metas.title,
                          style: TextStyle(
                            color: isPlaying ? Colors.blue : Colors.black,
                          )),
                      onTap: () {
                        this.onSelected(item);
                      }),
                );
              },
              itemCount: this.audios.length,
            ),
          ),
          FractionallySizedBox(
            widthFactor: 1,
            child: NeumorphicButton(
              onClick: () {
                this.onPlaylistSelected(this.audios);
              },
              child: Center(child: Text("All as playlist")),
            ),
          )
        ],
      ),
    );
  }
}
