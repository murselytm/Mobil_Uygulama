import 'package:demo_cal_car/search_on_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:pin_code_fields/pin_code_fields.dart';
// ignore: import_of_legacy_library_into_null_safe
// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movgi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  State<LoginScreen> createState() => _LoginScrenState();
}

class _LoginScrenState extends State<LoginScreen> {
  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/newyork.jpg"), fit: BoxFit.cover),
              color: Colors.black.withOpacity(0.4)),
        ),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height / 5 * 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 80, right: 10),
                    child: Text(
                      "Telefon Doğrulama",
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40, right: 40, bottom: 10, top: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        label: Text(""),
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SmsVerificationPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: StadiumBorder(),
                          minimumSize: Size(300, 50)),
                      child: Text("Doğrulama Kodu Gönder",
                          style: TextStyle(color: Colors.black, fontSize: 18)),
                    ),
                  )
                ],
              ),
            ))
      ]),
    );
  }
}

class SmsVerificationPage extends StatefulWidget {
  const SmsVerificationPage({Key? key}) : super(key: key);
  @override
  State<SmsVerificationPage> createState() => _SmsVerificationPage();
}

class _SmsVerificationPage extends State<SmsVerificationPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 70),
            child: PinCodeTextField(
              appContext: context,
              controller: controller,
              length: 4,
              cursorHeight: 19,
              enableActiveFill: true,
              textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  fieldWidth: 50,
                  inactiveColor: Colors.grey,
                  selectedColor: Color.fromARGB(255, 196, 188, 122),
                  activeFillColor: Color.fromARGB(255, 41, 177, 93),
                  selectedFillColor: Color.fromARGB(255, 216, 219, 19),
                  inactiveFillColor: Colors.grey.shade100,
                  borderWidth: 1,
                  borderRadius: BorderRadius.circular(8)),
              onChanged: ((value) {}),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 40, right: 40, top: 50, bottom: 10),
            child: Text("Lütfen PİN kodunu giriniz",
                style: TextStyle(fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SideBarPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: StadiumBorder(),
                  minimumSize: Size(300, 50)),
              child: Text("GEÇİCİ BUTON",
                  style: TextStyle(color: Colors.black, fontSize: 18)),
            ),
          )
        ],
      ),
    );
  }
}

class SideBarPage extends StatelessWidget {
  const SideBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(""),
          backgroundColor: Color.fromARGB(255, 43, 166, 197),
          iconTheme: IconThemeData(color: Color.fromARGB(255, 7, 7, 7)),
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 219, 210, 210),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          minimumSize: Size(200, 60)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectRepairMan()),
                        );
                      },
                      child: const Text(
                        "Çekici",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 219, 210, 210),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          minimumSize: Size(200, 60)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectRepairMan()),
                        );
                      },
                      child: const Text(
                        "Akü",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 219, 210, 210),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          minimumSize: Size(200, 60)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectRepairMan()),
                        );
                      },
                      child: const Text(
                        "Lastik",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        drawer: const _SideBarPage(),
      );
}

class _SideBarPage extends StatelessWidget {
  const _SideBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        child: Drawer(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildHeader(context),
                buildMenuItems(context),
              ],
            ),
          ),
        ),
      );

  Widget buildPage(BuildContext context) => Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ElevatedButton(onPressed: () {}, child: Text("Deneme"))],
        ),
      ));
  Widget buildHeader(BuildContext context) => Material(
        color: Color.fromARGB(255, 43, 166, 197),
        child: InkWell(
          onTap: () {
            Navigator.pop(context);

            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const UserPage(),
            ));
          },
          child: Container(
            padding: EdgeInsets.only(
              top: 24 + MediaQuery.of(context).padding.top,
              bottom: 24,
            ),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 52,
                  backgroundImage: AssetImage("assets/pr.jpg"),
                ),
                SizedBox(height: 12),
                Text(
                  "John Doe",
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                Text(
                  "0232325123",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                )
              ],
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          runSpacing: 20,
          children: [
            ListTile(
              leading: const Icon(Icons.account_box),
              title: const Text(
                "Profil",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.attach_money_rounded),
              title: const Text(
                "Kredi",
                style: TextStyle(fontSize: 18),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text("Geçmiş", style: TextStyle(fontSize: 18)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Çıkış", style: TextStyle(fontSize: 18)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            )
          ],
        ),
      );
}

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("John Doe"),
          backgroundColor: Color.fromARGB(255, 43, 166, 197),
        ),
        body: Image.asset("assets/pr.jpg"),
      );
}

class SelectRepairMan extends StatefulWidget {
  const SelectRepairMan({Key? key}) : super(key: key);

  @override
  State<SelectRepairMan> createState() => _SelectRepairMan();
}

class _SelectRepairMan extends State<SelectRepairMan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "Aracınızı Nereye Götürmek İstersiniz",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  decoration: TextDecoration.underline),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 219, 210, 210),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  minimumSize: Size(300, 60)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchOnMap()),
                );
              },
              child: const Text(
                "Kendi Tamaricim Var",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 219, 210, 210),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  minimumSize: Size(300, 60)),
              onPressed: () {},
              child: const Text(
                "Tamirci Seç",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
