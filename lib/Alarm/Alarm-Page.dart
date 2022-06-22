import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:fresh_wake/Widgets.dart';
import 'package:lottie/lottie.dart';

List<Widget> cardList = [];
bool isSwitched = true;
var textValue = 'Switch is OFF';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: Column(
          children: [
            TextStyle1("Set Alarm", 24, const Color(0xFFFFFFFF),
                FontWeight.w600, TextAlign.center, FontStyle.normal),
            Space(20),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: Textfield1(
                  alarmTaskController,
                  "Alarm Name",
                  "Task",
                  20,
                  const Color(0xFFFFFFFF),
                  FontWeight.w600,
                  TextAlign.center,
                  FontStyle.normal,
                  "asset/Alarm Bell.png"),
            ),
            Space(20),
            GestureDetector(
              onTap: () {
                _selectTime(context);
              },
              child: Card(
                color: Color(0xFFFFFFF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      height: 190,
                      width: 190,
                      child: AnalogClock(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 10, color: const Color(0xFF1A1A1A)),
                            color: const Color(0xFF1A1A1A),
                            shape: BoxShape.circle),
                        // decoration
                        isLive: false,
                        hourHandColor: Colors.white,
                        minuteHandColor: Colors.white,
                        showSecondHand: false,
                        numberColor: Colors.white,
                        showNumbers: true,
                        textScaleFactor: 2.2,
                        showTicks: false,
                        showDigitalClock: false,
                        digitalClockColor: Colors.white,
                        showAllNumbers: true,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A),
                                border: Border.all(
                                  width: 1,
                                  color: const Color(0xFF1A1A1A),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextStyle1(
                                  '${selectedTime.hour}',
                                  20,
                                  Colors.white,
                                  FontWeight.bold,
                                  TextAlign.center,
                                  FontStyle.normal),
                            ),
                          ],
                        ),
                        TextStyle1(
                            ":",
                            25,
                            const Color(0xFFFFFFFF),
                            FontWeight.w600,
                            TextAlign.center,
                            FontStyle.normal),
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1A1A1A),
                                border: Border.all(
                                  width: 1,
                                  color: const Color(0xFF1A1A1A),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextStyle1(
                                  '${selectedTime.minute}',
                                  20,
                                  Colors.white,
                                  FontWeight.bold,
                                  TextAlign.center,
                                  FontStyle.normal),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Space(20),

            // SizedBox(
            //   height: 200,
            //   width: 200,
            //   child: Lottie.network(
            //     "https://assets5.lottiefiles.com/packages/lf20_3w5swlwn.json",
            //   ),
            // ),
            ElevatedButton(
              child: TextStyle1('Save', 20, Colors.black, FontWeight.bold,
                  TextAlign.center, FontStyle.normal),
              onPressed: () {
                setState(
                  () {
                    String Name = alarmTaskController.text;
                    String Price = selectedTime.hour.toString();
                    String Brand = selectedTime.minute.toString();

                    userdata.write('Brand', Brand);
                    userdata.write('Name', Name);
                    userdata.write('Price', Price);

                    if (Name == "" || Price == "" || Brand == "") {
                      final snackBar = SnackBar(
                        content:
                            const Text('Please enter all the product details!'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      cardList.add(_card());
                      Navigator.pop(context);
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _card() {
    return Card(
      color: const Color(0xFF313334),
      child: ListTile(
          onTap: () {
            toggleSwitch(!isSwitched);
          },
          leading: CircleAvatar(
            radius: 23,
            child: ImageWidget("asset/Alarm Bell.png", 46, 46, () {}),
          ),
          title: TextStyle1(
              "${userdata.read('Name')} | ${userdata.read('Price')}:${userdata.read('Brand')}",
              20,
              Colors.white,
              FontWeight.w600,
              TextAlign.left,
              FontStyle.normal),
          subtitle: WeekDaysList(),
          trailing: Switch(
            splashRadius: 0.5,
            onChanged: (value) {},
            value: isSwitched,
            activeColor: Colors.blue,
            activeTrackColor: Colors.white,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
          )),
    );
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'Switch Button is ON';
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched = false;
        textValue = 'Switch Button is OFF';
      });
      print('Switch Button is OFF');
    }
  }

  Widget WeekDaysList() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 7,
          itemBuilder: (context, index) {
            return Column(children: [
              Container(
                width: MediaQuery.of(context).size.width / 20,
              ),
              TextStyle1(WeekDays[index], 14, const Color(0xFFE0E0E0),
                  FontWeight.w500, TextAlign.center, FontStyle.normal),
            ]);
          }),
    );
  }

  _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }
}
