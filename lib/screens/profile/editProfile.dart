import 'package:fashion_shop/config/SizeConfig.dart';
import 'package:fashion_shop/constants/continentContryState.dart';
import 'package:fashion_shop/storage/db.dart';
import 'package:fashion_shop/utilities/style.dart';
import 'package:fashion_shop/widgets/button.dart';
import 'package:fashion_shop/widgets/customAppBar.dart';
import 'package:fashion_shop/widgets/customDropDown.dart';
import 'package:fashion_shop/widgets/customeInput.dart';
import 'package:fashion_shop/widgets/rowSeperator.dart';
import 'package:fashion_shop/widgets/topProfile.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _region = "Asia";
  String country = "Afghanistan";
  String state = "Badakhshān";

  final Map<String, String> _regionTypes = {
    // "Select Region": "Select Region",
    "Asia": "Asia",
    "Africa": "Africa",
    "Europe": "Europe",
    "Americas": "North-South America",
    "Oceania": "Australia",
  };

  List selectedCountry = [];

  Map<String, String> filterCountry = {};

  Map<String, String> filterState = {};

  bool sameAsSheeping = true;

  void switchStates(String thisCountry) {
    //load stated
    selectedCountry = countryStateCode
        .where((element) => element['name'] == thisCountry)
        .toList();

    //map states
    Map<String, String> stateMap = {};

    for (int i = 0; i < selectedCountry[0]['states'].length; i++) {
      stateMap[selectedCountry[0]['states'][i]['name']] =
          selectedCountry[0]['states'][i]['name'];
    }

    setState(() {
      filterState = stateMap;
    });
  }

  void switchCountry(String thisRegion) {
    List filteredCountry = countryStateCode
        .where((element) => element['region'] == thisRegion)
        .toList();

    Map<String, String> countryMap = {};

    for (int i = 0; i < filteredCountry.length; i++) {
      countryMap[filteredCountry[i]['name']] = filteredCountry[i]['name'];
    }
    setState(() {
      filterCountry = countryMap;
      selectedCountry = filteredCountry;
    });
  }

  TextEditingController firstNameController = TextEditingController();

  @override
  void initState() {
    switchCountry(_region);
    country = selectedCountry[0]['name'];
    switchStates(country);
    state = selectedCountry[0]['states'][0]['name'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    SizeConfig size = SizeConfig();
    return Scaffold(
      appBar: customAppBar(context, themeData, hasBack: true),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.getPercentageWidth(4)),
        child: Column(
          children: [
            ProfileTop(
              user: user,
              hasEdit: true,
            ),
            SizedBox(
              height: size.getPercentageWidth(5),
            ),
            seperator(context, "Personal Info", padding: 0),
            Row(
              children: [
                Expanded(
                  child: CustomInput(
                      emailController: firstNameController,
                      themedata: themeData,
                      hintText: "Firstname"),
                ),
                SizedBox(
                  width: size.getPercentageWidth(5),
                ),
                Expanded(
                  child: CustomInput(
                      emailController: firstNameController,
                      themedata: themeData,
                      hintText: "Lastname"),
                ),
              ],
            ),
            CustomInput(
                emailController: firstNameController,
                themedata: themeData,
                hintText: "Mobile Number"),
            seperator(context, "Contact Info", padding: 0),
            CustomInput(
                emailController: firstNameController,
                themedata: themeData,
                hintText: "Street Address"),
            CustomInput(
                emailController: firstNameController,
                themedata: themeData,
                hintText: "Apt, Suite, etc (optional)"),
            CustomDropdown(
              region: _region,
              regionType: _regionTypes,
              action: (String? newValue) {
                setState(() {
                  _region = newValue!;
                  switchCountry(newValue);
                  country = selectedCountry[0]['name'];
                });
              },
            ),
            CustomDropdown(
              region: country,
              regionType: filterCountry,
              action: (String? newValue) {
                setState(() {
                  country = newValue!;
                  switchStates(country);
                  state = selectedCountry[0]['states'][0]['name'];
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: CustomDropdown(
                    region: state,
                    regionType: filterState,
                    action: (String? newValue) {
                      setState(() {
                        state = newValue!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: size.getPercentageWidth(5),
                ),
                Expanded(
                  child: CustomInput(
                      emailController: firstNameController,
                      themedata: themeData,
                      hintText: "Zip Code"),
                ),
              ],
            ),
            /*---------------------------------
               Save same for shipping checkbox
            ---------------------------------*/
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Checkbox(
                    value: sameAsSheeping,
                    onChanged: (bool? value) {
                      setState(() {
                        sameAsSheeping = !sameAsSheeping;
                      });
                    },
                    checkColor: Colors.white,
                    activeColor: themeData.primaryColor,
                  ),
                  Text(
                    'Also save as shipping address',
                    style: darkPrimaryStyle(context, 15, false, opacity: 0.7),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
            PrimaryButton(
              title: "Save",
              action: () {},
            )
          ],
        ),
      )),
    );
  }
}
