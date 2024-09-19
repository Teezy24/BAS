import ballerina/http;
import ballerina/uuid;
import ballerinax/mongodb;
import ballerina/yaml;

mongodb:ConnectionConfig mongoConfig = ({
    connection: {
        serverAddress: {
            host: "localhost",
            port: 27017
        }
    }
} );

private Types:Configuration config = {
connectionstring: "mongodb://localhost:27017",
database: "dsaassignmentone"
};

// Creating the mongodb client instance
private Datastore:MongoDB mongo;

// Initialising the mongodb connection
function init() returns error? {
self.mongo = check new (self.config);
}


service on new http:Listener(9090) {
    private final mongodb:Database educationDb;

    function init() returns error? {
        self.educationDb = check mongoDb->getDatabase(database);
    }

    resource function get programmes() returns Programme[]|error {
        mongodb:Collection programmes = check self.educationDb->getCollection("programmes");
        stream<Programme, error?> result = check programmes->find();
        return from Programme p in result
            select p;
    }

    resource function get programmes/[string programmeCode]() returns Programme|error {
        return getProgramme(self.educationDb, programmeCode);
    }

    resource function post programmes(@http:Payload ProgrammeInput input) returns Programme|error {
        string programmeCode = uuid:createType1AsString();
        Programme programme = {
            programmeCode: programmeCode,
            programmeName: input.programmeName,
            nqfLevel: input.nqfLevel,
            faculty: input.faculty,
            department: input.department,
            qualificationTitle: input.qualificationTitle,
            courses: input.courses
        };
        mongodb:Collection programmes = check self.educationDb->getCollection("programmes");
        check programmes->insertOne(programme);
        return programme;
    }

    resource function put programmes/[string programmeCode](@http:Payload ProgrammeUpdate update) returns Programme|error {
        mongodb:Collection programmes = check self.educationDb->getCollection("programmes");
        mongodb:UpdateResult updateResult = check programmes->updateOne({programmeCode}, {set: update});
        if updateResult.modifiedCount != 1 {
            return error(string `Failed to update the programme with code ${programmeCode}`);
        }
        return getProgramme(self.educationDb, programmeCode);
    }

    resource function delete programmes/[string programmeCode]() returns string|error {
        mongodb:Collection programmes = check self.educationDb->getCollection("programmes");
        mongodb:DeleteResult deleteResult = check programmes->deleteOne({programmeCode});
        if deleteResult.deletedCount != 1 {
            return error(string `Failed to delete the programme ${programmeCode}`);
        }
        return programmeCode;
    }
}

isolated function getProgramme(mongodb:Database educationDb, string programmeCode) returns Programme|error {
    mongodb:Collection programmes = check educationDb->getCollection("programmes");
    stream<Programme, error?> findResult = check programmes->find({programmeCode});
    Programme[] result = check from Programme p in findResult
        select p;
    if result.length() != 1 {
        return error(string `Failed to find a programme with code ${programmeCode}`);
    }
    return result[0];
}

public type ProgrammeInput record {|
    string programmeName;
    int nqfLevel;
    string faculty;
    string department;
    string qualificationTitle;
    Course[] courses;
|};

public type ProgrammeUpdate record {|
    string programmeName?;
    int nqfLevel?;
    string faculty?;
    string department?;
    string qualificationTitle?;
|};

public type Programme record {|
    readonly string programmeCode;
    string programmeName;
    int nqfLevel;
    string faculty;
    string department;
    string qualificationTitle;
    Course[] courses;
|};

public type Course record {|
    string courseCode;
    string courseName;
    int nqfLevel;
|};

public type Faculty record {|
    string facultyId;
    string facultyName;
    string department;
    string location;
    int contactInfo;
|};
