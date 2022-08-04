import 'dart:async';

import 'package:digital_management_sysem/selected_job/selected_job_widget.dart';
import 'package:flutter/services.dart';
import 'package:mysql_client/mysql_client.dart';

import '../selected_box/box_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../home_page/home_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer';
import 'package:barcode_scan2/barcode_scan2.dart';
import '../main.dart';

class MyJobsWidget extends StatefulWidget {
  const MyJobsWidget({Key key}) : super(key: key);

  @override
  _MyJobsWidgetState createState() => _MyJobsWidgetState();
}

class Project {
  String id;
  String jobId;
  String client;
  String completed;

  Project(this.id, this.client, this.jobId, this.completed);
}

class _MyJobsWidgetState extends State<MyJobsWidget> {
  final List<Project> jobs = List();
  List<Project> found = List();
  ScanResult scanResult;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  FutureOr<void> barcodeScan() async {
    try {
      final scan = await BarcodeScanner.scan();
      setState(() {
        scanResult = scan;
      });
    } on PlatformException catch (e) {
      log(e.stacktrace);
    }
    // FlutterBarcodeScanner.getBarcodeStreamReceiver('#ff6666', "Cance", true, ScanMode.BARCODE).listen((event) {});
  }

  void _filter(String keyword) {
    List<Project> results = List();
    if (keyword.isEmpty) {
      results = jobs;
    } else {
      results = jobs
          .where((project) =>
      project.jobId.toLowerCase().contains(keyword.toLowerCase()) ||
          project.client.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    } //
    setState(() {
      found = results;
    });
  }

  Future<List<Project>> getProjects() async {
    var projs = List<Project>();
    var query = await conn.execute(
        "SELECT p.id,c.name as client,job_id,completed FROM projects p LEFT JOIN clients c ON c.id=p.client_id",
        {},
        true);
    query.rowsStream.forEach((element) {
      var values = element
          .assoc()
          .values;
      projs.add(Project(
          values.elementAt(0),
          values.elementAt(1),
          values.elementAt(2),
          values.elementAt(3).contains("0") ? "Incomplete" : "Complete"));
    }).catchError((e) {
      log(e);
    });

    await conn.close();
    return projs;
  }

  @override
  void initState() {
    super.initState();
    found = jobs;
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        getProjects()
            .then((value) =>
        {
          super.setState(() {
            var val = value;
            val.forEach((element) {
              // log(element.jobId + " " + element.completed.toString() + " " + element.id.toString());
              jobs.add(element);
            });
            jobs.sort((a, b) => a.jobId.compareTo(b.jobId));
          })
        })
            .onError((error, stackTrace) => null));
  }

  @override
  Widget build(BuildContext context) {
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
                builder: (context) => HomePageWidget(),
              ),
            );
          },
        ),
        title: Text(
          'My Projects',
          style: FlutterFlowTheme
              .of(context)
              .title2
              .override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2,
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
                              EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                              child: Text(
                                'Welcome,',
                                style: FlutterFlowTheme
                                    .of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Text(
                                '[Full Name]\n',
                                style: FlutterFlowTheme
                                    .of(context)
                                    .bodyText1
                                    .override(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
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
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                    hintText: 'Search....',
                                    hintStyle:
                                    FlutterFlowTheme
                                        .of(context)
                                        .bodyText2,
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
                                    suffixIcon: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                               var scan = await barcodeScan();

                                            },
                                            icon: Icon(Icons.qr_code)),
                                      ],
                                    )),
                                style: FlutterFlowTheme
                                    .of(context)
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
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.9,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: found.length,
                          itemBuilder: (BuildContext bc, int index) {
                            return Container(
                              child: ListTile(
                                onTap: () async {
                                  selProj = found
                                      .elementAt(index)
                                      .jobId;
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SelectedJobWidget(),
                                    ),
                                  );
                                },
                                leading: Icon(
                                  Icons.inbox_sharp,
                                  size: 32,
                                ),
                                title: Text(
                                  '${found[index].client + " - " +
                                      found[index].jobId}',
                                  style: FlutterFlowTheme
                                      .of(context)
                                      .subtitle1
                                      .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                  ),
                                ),
                                subtitle: Text(
                                  '${found[index].completed}',
                                  style: FlutterFlowTheme
                                      .of(context)
                                      .bodyText2
                                      .override(
                                    fontFamily: 'Poppins',
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Color(0xFF303030),
                                  size: 20,
                                ),
                                tileColor: Color(0xFFF5F5F5),
                                dense: false,
                              ),
                            );
                          },
                          // children: [
                          //   InkWell(
                          //     onTap: () async {
                          //       await Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => BoxWidget(),
                          //         ),
                          //       );
                          //     },
                          //     child: ListTile(
                          //       leading: Icon(
                          //         Icons.inbox_sharp,
                          //         size: 32,
                          //       ),
                          //       title: Text(
                          //         'Job 1',
                          //         style: FlutterFlowTheme.of(context)
                          //             .subtitle1
                          //             .override(
                          //               fontFamily: 'Poppins',
                          //               fontSize: 16,
                          //             ),
                          //       ),
                          //       subtitle: Text(
                          //         'Unprepped',
                          //         style: FlutterFlowTheme.of(context)
                          //             .bodyText2
                          //             .override(
                          //               fontFamily: 'Poppins',
                          //               fontSize: 13,
                          //               fontWeight: FontWeight.w500,
                          //             ),
                          //       ),
                          //       trailing: Icon(
                          //         Icons.arrow_forward_ios,
                          //         color: Color(0xFF303030),
                          //         size: 20,
                          //       ),
                          //       tileColor: Color(0xFFF5F5F5),
                          //       dense: false,
                          //     ),
                          //   ),
                          //   ListTile(
                          //     leading: Icon(
                          //       Icons.inbox_sharp,
                          //       color: Color(0xFF791E20),
                          //       size: 32,
                          //     ),
                          //     title: Text(
                          //       'Job 2',
                          //       style: FlutterFlowTheme.of(context)
                          //           .subtitle1
                          //           .override(
                          //             fontFamily: 'Poppins',
                          //             fontSize: 16,
                          //             fontWeight: FontWeight.w500,
                          //           ),
                          //     ),
                          //     subtitle: Text(
                          //       'Prepping',
                          //       style: FlutterFlowTheme.of(context)
                          //           .bodyText2
                          //           .override(
                          //             fontFamily: 'Poppins',
                          //             fontSize: 13,
                          //           ),
                          //     ),
                          //     trailing: Icon(
                          //       Icons.arrow_forward_ios,
                          //       color: Color(0xFF303030),
                          //       size: 20,
                          //     ),
                          //     tileColor: Color(0xFFF5F5F5),
                          //     dense: false,
                          //   ),
                          //   ListTile(
                          //     leading: Icon(
                          //       Icons.inbox_sharp,
                          //       color: Color(0xFF1E7928),
                          //       size: 32,
                          //     ),
                          //     title: Text(
                          //       'Job ',
                          //       style: FlutterFlowTheme.of(context)
                          //           .subtitle1
                          //           .override(
                          //             fontFamily: 'Poppins',
                          //             fontSize: 16,
                          //             fontWeight: FontWeight.w500,
                          //           ),
                          //     ),
                          //     subtitle: Text(
                          //       'Prepped',
                          //       style: FlutterFlowTheme.of(context)
                          //           .bodyText2
                          //           .override(
                          //             fontFamily: 'Poppins',
                          //             fontSize: 13,
                          //           ),
                          //     ),
                          //     trailing: Icon(
                          //       Icons.arrow_forward_ios,
                          //       color: Color(0xFF303030),
                          //       size: 20,
                          //     ),
                          //     tileColor: Color(0xFFF5F5F5),
                          //     dense: false,
                          //   ),
                          // ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(MyJobsWidget oldWidget) {}
}
