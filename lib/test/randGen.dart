import 'dart:math';

class Generator {
  List<Map<String, Object>> generateColumn(DateTime start, DateTime end) {
    //id , name,time_start,time_end,latitude,longitude,index_name,is_mocked
    const String ID = "id";
    const String NAME = "name";
    const String TIME_START = "time_start";
    const String TIME_END = "time_end";
    const String LATITUDE = "latitude";
    const String LONGITUDE = "longitude";
    const String INDEX_NAME = "index_name";
    const String IS_MOCKED = "is_mocked";
    DateTime cur = start;
    List<Map<String, Object>> data = [];
    int id = 1;
    Random rnd = new Random();
    DateTime endT = cur;
    //print("generating: " + cur.compareTo(end).toString());
    while (cur.compareTo(end) < 0) {
      //print("inside");
      endT = cur.add(Duration(minutes: rnd.nextInt(120)));
      data.add({
        ID: id++,
        NAME: names[rnd.nextInt(names.length)],
        TIME_START: cur.toIso8601String(),
        TIME_END: endT.toIso8601String(),
        LATITUDE: 0.0,
        LONGITUDE: 0.0,
        INDEX_NAME: indexNames[rnd.nextInt(indexNames.length)],
        IS_MOCKED: true
      });
      cur = endT;
      //print("generated:$id " + cur.toString() + " " + endT.toString());
    }
    //print(data.toString());
    return data;
  }

  List<String> names = [
    "Swantantra Bhawan",
    "GTAC",
    "Cafeteria",
    "Gymkhana",
    "ABLT",
    "Library",
    "Director Office",
    "Director Office",
    "LT1",
    "LT1",
    "Behind DO",
    "MICEE Hall",
    "Lab A",
    "Lab B",
    "Lab C",
    "Office",
    "Cabin",
    "Geoinformatics",
    "G1",
    "G2",
    "Mech CLass",
    "G3",
    "HOD Office",
    "Prof Office",
    "Washroom",
    "Prof Office",
    "Washroom",
    "Cabin",
    "Washroom",
    "Lab",
    "Lab",
    "Computer Lab",
    "Lab",
    "F1",
    "F2",
    "Library",
    "BnSI office",
    "Prof Office",
    "Concrete lab",
    "Transportation",
    "Geo Lab",
    "Geo Lab 2",
    "Seminar Hall",
    "Conference Hall",
    "New IIT Girls",
    "Vishwakarma",
    "Vishwakarma",
    "Saluja House",
    "S.C. Dey",
    "Vivekananda",
    "Limbdi",
    "Rajputana",
    "Vivekananda",
    "Vishweshwaraya",
    "Vishweshwaraya",
    "Morvi",
    "Morvi",
    "GSMC ext",
    "GSMC ext",
    "GSMC ext",
    "DhanrajGiri",
    "DhanrajGiri",
    "C.V. Raman",
    "C.V. Raman",
    "C.V. Raman",
    "Dr. S. Ramanujan",
    "Dr. S. Ramanujan",
    "Dr. S. Ramanujan",
    "Dr. S. Ramanujan",
    "Prof.S.N. Bose",
    "Prof.S.N. Bose",
    "Prof.S.N. Bose",
    "Prof.S.N. Bose",
    "S.C. Dey",
    "GSMC old",
    "GSMC old",
    "GSMC old",
    "Limbdi",
    "Aryabhatta2",
    "Aryabhatta2",
    "Aryabhatta2",
    "Aryabhatta2",
    "Aryabhatta1",
    "Aryabhatta1",
    "Aryabhatta1",
    "Aryabhatta1",
    "Carpentry Workshop 2",
    "Carpentry Workshop",
    "Foundry Workshop",
    "Blacksmithy Workshop",
    "Basketball A",
    "Basketball B",
    "Basketball C",
    "Volleyball B",
    "Volleyball A",
    "Badminton 6",
    "Badminton 2",
    "Badminton 5",
    "Badminton 4",
    "Badminton 3",
    "Badminton 1",
    "Football",
    "Hockey",
    "Kabaddi",
    "Tennis",
    "Cricket",
    "Cricket Pitch"
  ];
  List<String> indexNames = [
    "Administrative",
    "Hostels",
    "Electronics Inner Part",
    "Chemical Departmentt Innerpart",
    "Civil Department Inner Parts",
    "Concrete Geology inner parts",
    "Electrical Department inner parts",
    "Electronics Inner Part",
    "Main Workshop Inner Parts",
    "Sports and Grounds Inner Parts",
    "Out of Campus",
    "Other"
  ];
}
