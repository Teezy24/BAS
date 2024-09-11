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
    int nqflevel;
    string faculty;
    string department;
    string reg_date;
|};

type Course readonly & record {|
    string coursecode;
    string course_name;
    int nqflevel;
    string program;
|};

table<Faculty> key(facultyid) faculties = table [
    {facultyid: "FOC", facultyName: "Faculty of Computing and Informatics", department: "Department of CyberSecurity", location: "House of Computing", contactinfo: 26481232235}
];

table<Program> key(programcode) programs = table [
    {programcode: "9364", program_name: "Engineering", nqflevel: 4, faculty: "Faculty of comuputing and informatics", department: "Department of computer science", reg_date: "2020-01-01"}
];

table<Course> key(coursecode) courses = table [
    {coursecode: "BMC394", course_name: "Computer Science", nqflevel: 4, program: "Artificial Intelligence"}
];

//Return code 
service /nust/programes on new http:Listener(9090) {

    resource function get faculties() returns Faculty[] {
        return faculties.toArray();
    }

    resource function post faculties(Faculty faculties) returns Faculty {
        return faculties;
    }

    resource function get programs() returns Program[] {
        return programs.toArray();

    }

    resource function post programs(Program programs) returns Program {
        return programs;
    }

    //finish resources fucntion for faculties and bal.run programs. 
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
