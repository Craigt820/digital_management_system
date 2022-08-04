import 'dart:developer';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:digital_management_sysem/index.dart';
import 'package:flutter/services.dart';

import '../selected_box/box_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../home_page/home_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class SelectedJobWidget extends StatefulWidget {
  final String project;

  const SelectedJobWidget({Key key, this.project}) : super(key: key);

  @override
  _SelectedJobWidgetState createState() => _SelectedJobWidgetState();
}

class Box extends Comparable<Box> {
  String name;
  int id;
  Status status;

  Box(this.name, this.id, this.status);

  @override
  int compareTo(Box other) {
    return this.name.compareTo(other.name);
  }
}

enum Status { Unprepped, Prepped, Prepping }

class _SelectedJobWidgetState extends State<SelectedJobWidget> {
  List<Box> groups = List();
  List<Box> found = List();
  String project;

  void _filter(String keyword) {
    List<Box> results = List();
    if (keyword.isEmpty) {
      results = groups;
    } else {
      results = groups
          .where(
              (box) => box.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    setState(() {
      found = results;
    });
  }

  int compareIntPrefixes(Box a, Box b) {
    var aValue = parseIntPrefix(a.name);
    var bValue = parseIntPrefix(b.name);
    if (aValue != null && bValue != null) {
      return aValue - bValue;
    }

    if (aValue == null && bValue == null) {
      // If neither string has an integer prefix, sort the strings lexically.
      return a.compareTo(b);
    }

    // Sort strings with integer prefixes before strings without.
    if (aValue == null) {
      return 1;
    } else {
      return -1;
    }
  }

  int parseIntPrefix(String s) {
    var re = RegExp(r'(-?[0-9]+).*');
    var match = re.firstMatch(s);
    if (match == null) {
      return null;
    }
    return int.parse(match.group(1));
  }


  Future<List<Box>> getGroups() async {
    var groups = List<Box>();
    var query = await conn.execute(
        "SELECT name,id FROM " + selProj.toString().trim() + "_G", {}, true);
    query.rowsStream.forEach((element) {
      var values = element.assoc().values;
      groups.add(Box(values.elementAt(0),
          int.parse(values.elementAt(1), radix: 10), Status.Unprepped));
    }).catchError((e) {
      log(e.toString());
    });

    await conn.close();
    return groups;
  }

  Color get_Color_Status(Status status) {
    switch (status) {
      case Status.Unprepped:
        return Color.fromRGBO(150, 150, 150, 1);
        break;
      case Status.Prepped:
        return Color.fromRGBO(67, 160, 77, 1);
        break;
      case Status.Prepping:
        return Color.fromRGBO(0, 0, 255, 1);
        break;
    }
    return null;
  }

  String someText;
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => getGroups().then((value) => {
              super.setState(() {
                var val = value;
                val.forEach((element) {
                  // log(element.jobId + " " + element.completed.toString() + " " + element.id.toString());
                  groups.add(element);
                });
                groups.sort(compareIntPrefixes);
                found = groups;
              })
            }));
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      this.project = widget.project;
      project = selProj;
    });

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF190B99),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 32,
          ),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyJobsWidget(),
              ),
            );
          },
        ),
        title: Text(
          project.toString(),
          style: FlutterFlowTheme.of(context).title2.override(
                fontFamily: 'Poppins',
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 1,
      ),
      backgroundColor: Color(0xFCFFFFFF),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: AlignmentDirectional(0, -0.05),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(40, 0, 40, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: Text(
                                'Description',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Color(0xF9FFFFFF),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: double.infinity,
                              child: TextFormField(
                                onChanged: (value) => _filter(value),
                                controller: textController,
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Search....',
                                  hintStyle:
                                      FlutterFlowTheme.of(context).bodyText2,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x752B343A),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0x752B343A),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF2B343A),
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Column(mainAxisSize: MainAxisSize.max, children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: found.length,
                          itemBuilder: (BuildContext bc, int index) {
                            return Container(
                                child: ListTile(
                              onTap: () async {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BoxWidget()));
                              },
                              leading: Icon(
                                Icons.inbox_sharp,
                                color: get_Color_Status(
                                    found.elementAt(index).status),
                                size: 32,
                              ),
                              title: Text(
                                found.elementAt(index).name,
                                style: FlutterFlowTheme.of(context)
                                    .subtitle1
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              subtitle: Text(
                                found.elementAt(index).status.name,
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Poppins',
                                      fontSize: 13,
                                    ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                color: Color(0xFF303030),
                                size: 20,
                              ),
                              tileColor: Color(0xFFF5F5F5),
                              dense: false,
                            ));
                          },
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
