import 'package:call_logs/styles/colors.dart';
import 'package:call_logs/styles/text_styles.dart';
import 'package:flutter/material.dart';

class CallCard extends StatefulWidget {
  final String type;
  final String person;
  final String data;
  final int calls;
  final bool unmissed;
  final String additional;

  const CallCard(
      {Key? key,
      this.type = "video",
      this.additional = "WhatsApp audio",
      this.unmissed = true,
      this.calls = 1,
      this.person = 'Мама',
      this.data = "Дата"})
      : super(key: key);

  @override
  State<CallCard> createState() => _CallCardState();
}

class _CallCardState extends State<CallCard> {
  @override
  Widget build(BuildContext context) {
    Map<String, Widget> icon = {
      "audio": const Icon(
        Icons.phone_forwarded,
        color: AppColor.tertiary,
        size: 14,
      ),
      "video": const Icon(Icons.video_call, color: AppColor.tertiary, size: 14),
      "incoming": const SizedBox(
        width: 14,
        height: 14,
      ),
    };
    return Padding(
      padding: const EdgeInsets.only(right: 0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14, top: 15, right: 14, bottom: 31),
            child: icon[widget.type],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.person} (${widget.calls})",
                    style: widget.unmissed ? AppTextStyle.bold17(): AppTextStyle.bold17(color: Colors.red)),
                Text(widget.additional, style: AppTextStyle.regular15()),
              ],
            ),
          ),
          Text(widget.data, style: AppTextStyle.regular15()),
          IconButton(
              padding: const EdgeInsets.only(left: 8, right: 21),
              onPressed: () => Navigator.pushNamed(context, '/info'),
              icon: const Icon(
                Icons.info_outlined,
                color: AppColor.link,
                size: 22,
              )),
        ],
      ),
    );
  }
}
