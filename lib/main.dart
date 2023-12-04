import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:ui';

void main()  async{
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => FormPage(),
      '/second': (context) => FormPage2(),
      '/second/mainPage':(context)=> MainPage(),
      '/second/mainPage/third': (context) => FormPage4(),

    },
  ));
}

class FormPage extends StatefulWidget {
  @override
  FormPageChild createState() => FormPageChild();
}

class FormPageChild extends State<FormPage> {
  final GlobalKey<FormState> fKey = GlobalKey<FormState>();
  TextEditingController eCon = TextEditingController();
  TextEditingController nCon = TextEditingController();
  TextEditingController pCon = TextEditingController();

  String? validateEmail(value) {
    if (value.trim().isEmpty) {
      return 'Please enter an email';
    }
    bool emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value);
    if (!emailRegex) {
      return 'Please enter a valid email';
    }

    return null;
  }

  String? nameValidate(value) {
    if (value.trim().isEmpty) {
      return 'Please enter a name';
    }
    bool nameReg = RegExp(r'^[a-zA-Z_-]+(?: [a-zA-Z_-]+)*$').hasMatch(value);
    if (!nameReg) {
      return 'Please enter a valid name';
    }
    return null;
  }

  String? passwordValidate(value) {
    if (value.trim().isEmpty) {
      return 'Please enter a password';
    }
    bool passRegx = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+{}|:<>?~,-.]).{7,}$')
        .hasMatch(value);
    if (!passRegx) {
      return 'Password must contain at least one lowercase letter, one uppercase letter, one digit, and one special character.';
    }
    return null;
  }

  void statusOfSubmit() {
    ScaffoldMessenger.of(fKey.currentContext!).showSnackBar(
      const SnackBar(
        content: Text('Registered Successfully'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Welcome to the Registration Form"),
        actions: [
          InkWell(
            onTap: () {
              // Navigate to login page
              Navigator.pushNamed(context, '/second');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: EdgeInsets.all(15),
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: fKey,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: eCon,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: validateEmail,
              ),
              SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: nCon,
                decoration: InputDecoration(
                  labelText: 'Name',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: nameValidate,
              ),
              SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: pCon,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: passwordValidate,
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    if (fKey.currentState!.validate()) {
                      statusOfSubmit();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.green.withOpacity(1),
                  ),
                  child: Text('Register'),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Clear text fields on login button press
                    //eCon.clear();
                    //nCon.clear();
                   // pCon.clear();
                    Navigator.pushNamed(context, '/second');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.deepPurpleAccent.withOpacity(1),
                  ),
                  child: Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FormPage2 extends StatefulWidget {
  LoginPage createState() => LoginPage();
}

class LoginPage extends State<FormPage2> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passCon = TextEditingController();
  final GlobalKey<FormState> logKey = GlobalKey<FormState>();

  String? emailCheck(value) {
    if (value.trim().isEmpty || value == null) {
      return 'Please enter an email';
    }
  }

  String? passCheck(value) {
    if (value == null || value.trim().isEmpty) {
      return "Please Enter a password";
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Welcome to the login page'),
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5.0),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: logKey,
          child: Column(
            children: [
              SizedBox(height: 80),
              TextFormField(
                controller: emailCon,
                decoration: InputDecoration(
                  labelText: 'Email',
                  filled: true,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: emailCheck,
              ),
              SizedBox(height: 20),
              TextFormField(
                  controller: passCon,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    filled: true,
                    fillColor: Colors.grey,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: passCheck),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigate to the forgot password page
                      Navigator.pushNamed(context, '/forgotPassword');
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    if (logKey.currentState!.validate()) {
                      Navigator.pushNamed(context, '/second/mainPage');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    primary: Colors.green.withOpacity(1),
                  ),
                  child: Text('Login'),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      // Navigate to the registration page
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class MainPage extends StatefulWidget
{
  ChildMainPage createState()=>ChildMainPage();
}
class ChildMainPage extends State<MainPage> {
  //Navigator.pushNamed(context, '/second/mainPage/third');
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: _buildAppBar(),
      body: _buildGridView(context),
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 11.0,
      ),
      itemCount: 7,
      itemBuilder: (BuildContext context, int index) {
        return _buildListTile(context, index);
      },
    );
  }

  Widget _buildListTile(BuildContext context, int index) {
    List<Map<String, dynamic>> listItems = [
      {"icon": Icons.shopping_cart, "title": "Item Management", "color": Colors.blue},
      {"icon": Icons.account_circle, "title": "Profile Management", "color": Colors.orange},
      {"icon": Icons.attach_money, "title": "Sale Management", "color": Colors.purple},
      {"icon": Icons.payment, "title": "Billing Management", "color": Colors.red},
      {"icon": Icons.undo, "title": "Return Management", "color": Colors.teal},
      {"icon": Icons.shopping_basket, "title": "Purchase Management", "color": Colors.indigo},
      {"icon": Icons.account_balance, "title": "Finance Management", "color": Colors.deepOrange},
    ];

    IconData icon = listItems[index]["icon"];
    String title = listItems[index]["title"];
    Color backgroundColor = listItems[index]["color"];
    Color textColor = Colors.white;
    double fontSize = 16.0;

    return GestureDetector(
      onTap: () {
        _handleTap(context, title);
      },
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 30.0,
              child: Icon(
                icon,
                color: backgroundColor,
                size: 28.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _handleTap(BuildContext context, String title) {
    switch (title) {
      case "Item Management":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FormPage4()),
        );
        break;
      case "Profile Management":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileManagementPage()),
        );
        break;
      case "Sale Management":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SaleManagementPage()),
        );
        break;
      case "Billing Management":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BillingManagementPage()),
        );
        break;
      case "Return Management":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReturnManagementPage()),
        );
        break;
      case "Purchase Management":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PurchaseManagementPage()),
        );
        break;
      case "Finance Management":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FinanceManagementPage()),
        );
        break;
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        "Bilal Jewellers",
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}

class ItemManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Item Management")),
      body: Center(child: Text("Item Management Page")),
    );
  }
}

class ProfileManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Management")),
      body: Center(child: Text("Profile Management Page")),
    );
  }
}

class SaleManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sale Management")),
      body: Center(child: Text("Sale Management Page")),
    );
  }
}

class BillingManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Billing Management")),
      body: Center(child: Text("Billing Management Page")),
    );
  }
}

class ReturnManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Return Management")),
      body: Center(child: Text("Return Management Page")),
    );
  }
}

class PurchaseManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Purchase Management")),
      body: Center(child: Text("Purchase Management Page")),
    );
  }
}

class FinanceManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Finance Management")),
      body: Center(child: Text("Finance Management Page")),
    );
  }
}

class FormPage4 extends StatefulWidget
{
  ChildFormPage createState()=>ChildFormPage();
}
class ChildFormPage extends State<FormPage4>
{


  TextEditingController addItemCon=TextEditingController();
  final GlobalKey<FormState> addItemKey= GlobalKey<FormState>();
  TextEditingController addDate=TextEditingController();
  TextEditingController DescriptionCon=TextEditingController();

  final DateTime currentDate = DateTime.now();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  late String date;
  // Constructor for ChildFormPage
  ChildFormPage()
  {
    date = dateFormat.format(currentDate);
    addDate.text=date;
  }


  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(backgroundColor: Colors.green,
        title: Text(""),),

      body:Column(
        children: [
          Container
            (
            height: 70,
            color: Colors.greenAccent,
            child:Center(
                    child:Text("Item Management",style: TextStyle(
                      color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16,
                    ),),
      ),
          ),

          Expanded(
            child:Container(
              margin: EdgeInsets.all(8),
              child:Expanded(
                child:Form(
                  key:addItemKey,
                  child: ListView(
                    children: [
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:SizedBox(
                          width: 365,
                          child:TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: addItemCon,
                              decoration: InputDecoration(
                                labelText: 'Add Item',
                                filled: true,
                                fillColor: Colors.brown,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelStyle: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextStyle(fontWeight: FontWeight.bold,),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty)
                                {
                                  return 'Please must fill field';
                                }
                              }
                          ),),),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:SizedBox(
                          width: 365,
                          child:TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller:  DescriptionCon,
                              decoration: InputDecoration(
                                labelText: 'Description',
                                filled: true,
                                fillColor: Colors.brown,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelStyle: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextStyle(fontWeight: FontWeight.bold,),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty)
                                {
                                  return 'Please must fill field';
                                }
                              }
                          ),),),


                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child:SizedBox(
                          width: 200,
                          height: 50,
                          child:TextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              controller: addDate,
                              decoration: InputDecoration(
                                labelText: 'date',
                                filled: true,
                                fillColor: Colors.brown,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                labelStyle: TextStyle(color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: TextStyle(fontWeight: FontWeight.bold,),
                              validator: (value)
                              {
                                if (value == null || value.trim().isEmpty)
                                {
                                  return 'Please must fill date field';
                                }
                              }
                          ),
                        ),
                      ),

                      SizedBox(height: 15,),
                      Row(
                        children:[
                          SizedBox(
                            width: 100,
                            height: 60,
                            child:ElevatedButton(onPressed:()
                            {
                              if(addItemKey.currentState!.validate())
                              {
                                ScaffoldMessenger.of(addItemKey.currentContext!).showSnackBar(
                                  const SnackBar(
                                    content: Text('Item add Successfully'),
                                  ),
                                );
                              }
                            },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:BorderRadius.circular(10),
                                  ),
                                  primary: Colors.deepPurpleAccent.withOpacity(1),
                                ),
                                child:Text('Add')),
                          ),
                          SizedBox(width: 16),
                          SizedBox(
                            height: 60,
                            width: 250,
                            child:ElevatedButton(onPressed:()
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ItemManage()),
                              );
                            },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),

                              ),
                              child: Text("Update and Delete Item",style: TextStyle(
                                  fontSize: 18,fontWeight: FontWeight.bold,
                                  color: Colors.black),),),),],
                      ),
                      SizedBox(height: 15,),



                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ItemData {
  String name;

  ItemData(this.name);
}

class ItemManage extends StatefulWidget {
  @override
  ChildItemManage createState() => ChildItemManage();
}

class ChildItemManage extends State<ItemManage> {
  List<ItemData> items = List.generate(8, (index) => ItemData('Item ${index + 1}'));
  bool isEditMode = false;
  int? editingIndex;
  TextEditingController editingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Professional ListView'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              addItem();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: isEditMode && index == editingIndex
                ? TextField(
              controller: editingController,
              onChanged: (value) {
                // Handle text changes
              },
            )
                : Text(
              items[index].name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.blue,
                    size: 24.0,
                  ),
                  onPressed: () {
                    setState(() {
                      isEditMode = true;
                      editingIndex = index;
                      editingController.text = items[index].name;
                    });
                  },
                ),
                GestureDetector(
                  onTap: () {
                    // Handle delete action
                    setState(() {
                      items.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Deleted Item ${index + 1}'),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 24.0,
                  ),
                ),
              ],
            ),
            onTap: () {
              // Handle tap without dismissing
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Tapped Item ${index + 1}'),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void addItem() {
    setState(() {
      items.add(ItemData('New Item ${items.length + 1}'));
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added Item Successfully'),
      ),
    );
  }

  void updateItem() {
    setState(() {
      items[editingIndex!] = ItemData(editingController.text);
      isEditMode = false;
      editingIndex = null;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Updated Item Successfully'),
      ),
    );
  }
}


