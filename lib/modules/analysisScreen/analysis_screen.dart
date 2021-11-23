import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AnalysisScreen extends StatelessWidget {
  AnalysisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var indicatorLength = MediaQuery.of(context).size.width*0.58;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 25.0,
          ),
        ),
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'Student Analysis',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.05,
              ),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.png'),
                radius: 55.0,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              const Text(
                'Mohamed Mmdouh Mohamed',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const Text(
                '4th , Computer Science',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0 , vertical: 10.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 4.0,
                              percent: 0.90,
                              center: const Text("90%"),
                              progressColor: Colors.red,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.05,
                            ),
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 4.0,
                              percent: 0.75,
                              center: const Text("75%"),
                              progressColor: Colors.green,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.05,
                            ),
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 4.0,
                              percent: 0.55,
                              center: const Text("55%"),
                              progressColor: Colors.blue,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.05,
                            ),
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 4.0,
                              percent: 0.66,
                              center: const Text("66%"),
                              progressColor: Colors.orange,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.05,
                            ),
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 4.0,
                              percent: 0.55,
                              center: const Text("55%"),
                              progressColor: Colors.amber,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.05,
                            ),
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 4.0,
                              percent: 0.85,
                              center: const Text("85%"),
                              progressColor: Colors.indigo,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.05,
                            ),
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 4.0,
                              percent: 0.55,
                              center: const Text("55%"),
                              progressColor: Colors.amber,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.05,
                            ),
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 4.0,
                              percent: 0.85,
                              center: const Text("85%"),
                              progressColor: Colors.indigo,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.05,
                            ),
                            CircularPercentIndicator(
                              radius: 45.0,
                              lineWidth: 4.0,
                              percent: 0.81,
                              center: const Text("81%"),
                              progressColor: Colors.brown,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.04,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 5.0,
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.02,
                        ),
                        const Expanded(
                          child: Text(
                            'Audience',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.07,
                        ),
                        LinearPercentIndicator(
                          width: indicatorLength,
                          animation: true,
                          lineHeight: 16.0,
                          animationDuration: 2000,
                          percent: 0.9,
                          center: const Text(
                            '90.0%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.red,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 5.0,
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.02,
                        ),
                        const Expanded(
                          child: Text(
                            'CPA',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.07,
                        ),
                        LinearPercentIndicator(
                          width: indicatorLength,
                          animation: true,
                          lineHeight: 16.0,
                          animationDuration: 2000,
                          percent: 0.75,
                          center: const Text(
                            '75.0%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.green,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 5.0,
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.02,
                        ),
                        const Expanded(
                          child: Text(
                            'Subject 1',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.07,
                        ),
                        LinearPercentIndicator(
                          width: indicatorLength,
                          animation: true,
                          lineHeight: 16.0,
                          animationDuration: 2000,
                          percent: 0.55,
                          center: const Text(
                            '55.0%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.blue,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 5.0,
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.02,
                        ),
                        const Expanded(
                          child: Text(
                            'Subject 2',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.07,
                        ),
                        LinearPercentIndicator(
                          width: indicatorLength,
                          animation: true,
                          lineHeight: 16.0,
                          animationDuration: 2000,
                          percent: 0.66,
                          center: const Text(
                            '66.0%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.orange,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 5.0,
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.02,
                        ),
                        const Expanded(
                          child: Text(
                            'Subject 3',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.07,
                        ),
                        LinearPercentIndicator(
                          width: indicatorLength,
                          animation: true,
                          lineHeight: 16.0,
                          animationDuration: 2000,
                          percent: 0.55,
                          center: const Text(
                            '55.0%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.amber,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 5.0,
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.02,
                        ),
                        const Expanded(
                          child: Text(
                            'Subject 4',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.07,
                        ),
                        LinearPercentIndicator(
                          width: indicatorLength,
                          animation: true,
                          lineHeight: 16.0,
                          animationDuration: 2000,
                          percent: 0.85,
                          center: const Text(
                            '85.0%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.deepPurple,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 5.0,
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.02,
                        ),
                        const Expanded(
                          child: Text(
                            'Subject 5',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.07,
                        ),
                        LinearPercentIndicator(
                          width: indicatorLength,
                          animation: true,
                          lineHeight: 16.0,
                          animationDuration: 2000,
                          percent: 0.55,
                          center: const Text(
                            '55.0%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.amber,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 5.0,
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.02,
                        ),
                        const Expanded(
                          child: Text(
                            'Subject 6',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.07,
                        ),
                        LinearPercentIndicator(
                          width: indicatorLength,
                          animation: true,
                          lineHeight: 16.0,
                          animationDuration: 2000,
                          percent: 0.85,
                          center: const Text(
                            '85.0%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.deepPurple,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 5.0,
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.02,
                        ),
                        const Expanded(
                          child: Text(
                            'General',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.04,
                        ),
                        LinearPercentIndicator(
                          width: indicatorLength,
                          animation: true,
                          lineHeight: 16.0,
                          animationDuration: 2000,
                          percent: 0.81,
                          center: const Text(
                            '81.0%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.brown,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    ) ;
  }
}
