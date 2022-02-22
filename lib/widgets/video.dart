import 'package:flutter/material.dart';
import 'package:numeral/numeral.dart';
import 'package:timeago/timeago.dart' as timeago;

class Video extends StatelessWidget {
  const Video({Key? key, required this.video}) : super(key: key);
  final Map video;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          video["snippet"]["thumbnails"]["medium"]["url"],
          fit: BoxFit.contain,
          width: MediaQuery.of(context).size.width,
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://randomuser.me/api/portraits/men/44.jpg"),
                radius: 20,
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video["snippet"]["title"],
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${video["snippet"]["channelTitle"]} • ${Numeral(int.parse(video["statistics"]["viewCount"])).value()} views • ${timeago.format(DateTime.parse(video["snippet"]["publishedAt"]))}",
                      style: Theme.of(context).textTheme.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              )),
              InkWell(
                onTap: () {},
                child: const Icon(
                  Icons.more_vert,
                  size: 16,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
