import 'package:flutter/material.dart';
import 'package:sana_starter/controller/home_controller.dart';
import 'package:sana_starter/model/device_model.dart';
import 'package:sana_starter/pages/home/widgets/devices.dart';
import 'package:sana_starter/utils/string_to_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DeviceModel> devices = [
    DeviceModel(
        name: 'SaNa Starter',
        isActive: false,
        color: "#7739ff",
        icon: 'assets/svg/starter.svg'),
    // DeviceModel(
    //     name: 'Smart Wi-Fi',
    //     isActive: true,
    //     color: "#ff5f5f",
    //     icon: 'assets/svg/wifi.svg'),
    // DeviceModel(
    //     name: 'Smart Spotlight',
    //     isActive: false,
    //     color: "#c9c306",
    //     icon: 'assets/svg/light.svg'),
    // DeviceModel(
    //     name: 'Smart Fan',
    //     isActive: false,
    //     color: "#c207db",
    //     icon: 'assets/svg/fan.svg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFFfce2e1), Colors.white]),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Hi,Teja",
                      style: TextStyle(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    CircleAvatar(
                        minRadius: 16,
                        backgroundImage: AssetImage("assets/images/user.webp"))
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "A total of ${devices.length} devices",
                                    style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  const Text(
                                    "Internet of Things",
                                    style: TextStyle(
                                        height: 1.1,
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              PopupMenuButton(
                                padding: const EdgeInsets.only(right: 12),
                                icon: Icon(Icons.more_horiz,
                                    color: Colors.grey[300], size: 30),
                                onSelected: (value) async {
                                  await HomeController().onTapClose();
                                },
                                offset: const Offset(0.0, 10),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                itemBuilder: (ctx) =>
                                    [_buildPopupMenuItem("Close", 1)],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: GridView.builder(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 20),
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: 3 / 4,
                                        crossAxisSpacing: 20,
                                        mainAxisSpacing: 20),
                                itemCount: devices.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return Devices(
                                    name: devices[index].name,
                                    svg: devices[index].icon,
                                    color: devices[index].color.toColor(),
                                    isActive: devices[index].isActive,
                                    onChanged: (val) async {
                                      await HomeController().onTapConnect(val);
                                      setState(() {
                                        devices[index].isActive =
                                            !devices[index].isActive;
                                      });
                                    },
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(title, value) {
    return PopupMenuItem(
        value: value,
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w400),
        ));
  }
}
