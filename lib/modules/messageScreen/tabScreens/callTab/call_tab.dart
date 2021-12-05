import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CallTab extends StatelessWidget {
  const CallTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context , index)=> messageRowItem(),
        separatorBuilder: (context , index)=> const SizedBox(
          height: 10.0,
        ),
        itemCount: 10,
      ),
    );
  }

  Widget messageRowItem()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.lightBlue,
                      radius: 30.0,
                    ),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/images/profile.png'),
                      radius: 28.0,
                    ),
                  ],

                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: const[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 9.0,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 7.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Mohamed Mmdouh',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${DateFormat('EEE, d MMM y     hh:mm aaa').format(DateTime.now())}',
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: (){},
              icon: const Icon(
                Icons.call,
                size: 25.0,
                color: Colors.lightBlue,
              ),
          ),
        ],
      ),
    );
  }

}