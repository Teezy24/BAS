import ballerina/http;
import ballerinax/mongodb;
import ballerina/io;
import ballerina/mime;
import ballerina/log;

mongodb:ConnectionConfig mongoConfig = {
    connection: {
        serverAddress: {
            host: "localhost",
            port: 27017
        }
    }
};

configurable string database = "DSA";
configurable string collection = "programmes";

// Creating the mongodb client instance
mongodb:Client mongo = check new (mongoConfig);

service /programmes on new http:Listener(9000) {
    private final mongodb:Database educationDb;

    function init() returns error? {
        self.educationDb = check mongo->getDatabase(database);
        
        // Test MongoDB connection
        mongodb:Collection testCollection = check self.educationDb->getCollection("test");
        check testCollection->insertOne({"test": "connection"});
        log:printInfo("MongoDB connection test successful");
    }

    resource function get .() returns Programme[]|error {
    mongodb:Collection programmes = check self.educationDb->getCollection(collection);
    stream<Programme, error?> result = check programmes->find();
    Programme[] programmeList = [];
    check from Programme p in result
        do {
            programmeList.push(p);
        };
    return programmeList;
}
    resource function post .(@http:Payload Programme[]? programmes) returns Programme[]|ConflictingProgrammeCodesError|error {
        log:printInfo("Received POST request with payload: " + programmes.toString());

        if programmes is () || programmes.length() == 0 {
            log:printError("Empty payload received");
            return error("Empty payload: Programme data is required");
        }

        mongodb:Collection programmesCollection = check self.educationDb->getCollection(collection);
        string[] conflictingCodes = [];
        
        foreach Programme programme in programmes {
            log:printInfo("Processing programme: " + programme.toString());
            Programme? existingProgramme = check programmesCollection->findOne({programmeCode: programme.programmeCode});
            if (existingProgramme != ()) {
                conflictingCodes.push(programme.programmeCode);
            }
        }

        if conflictingCodes.length() > 0 {
            log:printWarn("Conflicting programme codes found: " + conflictingCodes.toString());
            return {
                body: {
                    errmsg: string:'join(" ", "Conflicting Programme Codes:", ...conflictingCodes)
                }
            };
        }
        
        foreach Programme programme in programmes {
            log:printInfo("Attempting to insert programme: " + programme.toString());
            do {
                check programmesCollection->insertOne(programme);
                log:printInfo("Successfully inserted programme: " + programme.programmeCode);
            } on fail var e {
                log:printError("Failed to insert programme: " + programme.programmeCode, 'error = e);
                return error("Failed to insert programme: " + programme.programmeCode, e);
            }
        }
        
        log:printInfo("Successfully inserted all programmes");
        return programmes;
    }

    resource function get [string programmeCode]() returns Programme|InvalidProgrammeCodeError|error {
        mongodb:Collection programmes = check self.educationDb->getCollection(collection);
        Programme? programme = check programmes->findOne({programmeCode: programmeCode});
        if programme is () {
            return {
                body: {
                    errmsg: string `Invalid Programme Code: ${programmeCode}`
                }
            };
        }
        return programme;
    }

    resource function put [string programmeCode](@http:Payload ProgrammeUpdate update) returns Programme|error {
        mongodb:Collection programmes = check self.educationDb->getCollection(collection);
        mongodb:UpdateResult updateResult = check programmes->updateOne({programmeCode}, {set: update});
        if updateResult.modifiedCount != 1 {
            return error(string `Failed to update the programme with code ${programmeCode}`);
        }
        return check getProgramme(self.educationDb, programmeCode);
    }

    resource function delete [string programmeCode]() returns string|error {
        mongodb:Collection programmes = check self.educationDb->getCollection(collection);
        mongodb:DeleteResult deleteResult = check programmes->deleteOne({programmeCode});
        if deleteResult.deletedCount != 1 {
            return error(string `Failed to delete the programme ${programmeCode}`);
        }
        return programmeCode;
    }


    // New function to retrieve programmes by faculty
    resource function get faculty/[string faculty]() returns Programme[]|error {
        mongodb:Collection programmes = check self.educationDb->getCollection(collection);
        stream<Programme, error?> result = check programmes->find({faculty: faculty});
        return from Programme p in result
            select p;
    }

    // Function to serve the UI
    resource function get ui() returns http:Response|error {
        http:Response response = new;
        string html = check io:fileReadString("ui.html");
        response.setTextPayload(html, contentType = mime:TEXT_HTML);
        return response;
    }
}

isolated function getProgramme(mongodb:Database educationDb, string programmeCode) returns Programme|error {
    mongodb:Collection programmes = check educationDb->getCollection(collection);
    Programme? programme = check programmes->findOne({programmeCode: programmeCode});
    if programme is () {
        return error(string `Failed to find a programme with code ${programmeCode}`);
    }
    return programme;
}

public type Programme record {|
    readonly string programmeCode;
    string programmeName;
    int nqfLevel;
    string faculty;
    string department;
    string qualificationTitle;
    string registrationDate;
    Course[] courses;
|};

public type ProgrammeUpdate record {|
    string programmeName?;
    int nqfLevel?;
    string faculty?;
    string department?;
    string qualificationTitle?;
    string registrationDate?;
    Course[]? courses?;
|};

public type Course record {|
    string courseCode;
    string courseName;
    int nqfLevel;
|};

public type ConflictingProgrammeCodesError record {|
    *http:Conflict;
    ErrorMsg body;
|};

public type InvalidProgrammeCodeError record {|
    *http:NotFound;
    ErrorMsg body;
|};

public type ErrorMsg record {|
    string errmsg;
|};