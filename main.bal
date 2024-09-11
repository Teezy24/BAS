import ballerina/http;



type Faculty readonly & record {|
    string facultyid;
    string facultyName;
    string department;
    string location;
    int contactinfo;


|};

type Program readonly & record {|
    string programcode;
    string program_name;
    int nqf_level;
    string faculty;
    string department;
    string reg_date;
|};

type Course readonly & record {|
    string course_code;
    string course_name;
    int nqf_level;
    string program;
|};

table<Faculty> key(facultyid) facultys = table [
    {facultyid: "FOC", facultyName: "Faculty of Computing and Informatics", department: "Department of CyberSecurity", location: "House of Computing", contactinfo: 26481232235}
];

table<Program> key(programcode) programs = table [
    {programcode: "9364", program_name: "Engineering", nqf_level: 4, faculty: "Faculty of comuputing and informatics", department: "Department of computer science", reg_date: "2020-01-01"}
];

table<Course> key(course_code) courses = table [
    {course_code: "BMC394", course_name: "Computer Science", nqf_level: 4, program: "Artificial Intelligence"}
];

//Return code 
service /nust/programes on new http:Listener(9090) {

    resource function get facultys() returns Faculty[] {
        return facultys.toArray();
    }

    resource function post facultys(Faculty facultys) returns Faculty {
        return facultys;
    }

    resource function get programs() returns Program[] {
        return programs.toArray();

    }

    resource function post programs(Program programs) returns Program {
        return programs;
    }

    //finish resources fucntion for facultys and bal.run programs. 
    //then test postman to display information

    resource function get courses() returns Course[] {
        return courses.toArray();
    }

    resource function post courses(Course courses) returns Course {
        return courses;
    }

}

//Error Messages

public type ConflictingIsoCodesError record {|
    *http:Conflict;
    ErrorMsg body;
|};

public type InvalidIsoCodeError record {|
    *http:NotFound;
    ErrorMsg body;
|};

public type ErrorMsg record {|
    string errmsg;
|};
