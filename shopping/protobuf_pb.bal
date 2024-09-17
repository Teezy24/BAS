import ballerina/grpc;
import ballerina/protobuf;

public const string PROTOBUF_DESC = "0A0E70726F746F6275662E70726F746F120873686F7070696E6722F9010A0750726F6475637412120A046E616D6518012001280952046E616D6512200A0B6465736372697074696F6E180220012809520B6465736372697074696F6E12140A0570726963651803200128015205707269636512250A0E73746F636B5F7175616E74697479180420012805520D73746F636B5175616E7469747912100A03736B751805200128095203736B7512370A0673746174757318062001280E321F2E73686F7070696E672E50726F647563742E50726F64756374537461747573520673746174757322300A0D50726F64756374537461747573120D0A09415641494C41424C45100012100A0C4F55545F4F465F53544F434B100122400A1141646450726F6475637452657175657374122B0A0770726F6475637418012001280B32112E73686F7070696E672E50726F64756374520770726F6475637422370A1241646450726F64756374526573706F6E736512210A0C70726F647563745F636F6465180120012809520B70726F64756374436F646522B3010A114372656174655573657252657175657374121A0A08757365726E616D651801200128095208757365726E616D65121A0A0870617373776F7264180220012809520870617373776F726412410A09757365725F7479706518032001280E32242E73686F7070696E672E43726561746555736572526571756573742E55736572547970655208757365725479706522230A085573657254797065120C0A08435553544F4D4552100012090A0541444D494E100122150A134372656174655573657273526573706F6E736522430A1455706461746550726F6475637452657175657374122B0A0770726F6475637418012001280B32112E73686F7070696E672E50726F64756374520770726F6475637422170A1555706461746550726F64756374526573706F6E736522280A1452656D6F766550726F647563745265717565737412100A03736B751801200128095203736B7522460A1552656D6F766550726F64756374526573706F6E7365122D0A0870726F647563747318012003280B32112E73686F7070696E672E50726F64756374520870726F6475637473221E0A1C4C697374417661696C61626C6550726F647563747352657175657374224E0A1D4C697374417661696C61626C6550726F6475637473526573706F6E7365122D0A0870726F647563747318012003280B32112E73686F7070696E672E50726F64756374520870726F647563747322280A1453656172636850726F647563745265717565737412100A03736B751801200128095203736B7522440A1553656172636850726F64756374526573706F6E7365122B0A0770726F6475637418012001280B32112E73686F7070696E672E50726F64756374520770726F64756374223D0A10416464546F436172745265717565737412170A07757365725F6964180120012809520675736572496412100A03736B751802200128095203736B7522130A11416464546F43617274526573706F6E7365225B0A11506C6163654F726465725265717565737412170A07757365725F69641801200128095206757365724964122D0A0870726F647563747318022003280B32112E73686F7070696E672E50726F64756374520870726F647563747322140A12506C6163654F72646572526573706F6E736532A6050A0F53686F7070696E675365727669636512490A0A61646450726F64756374121B2E73686F7070696E672E41646450726F64756374526571756573741A1C2E73686F7070696E672E41646450726F64756374526573706F6E73652200124D0A0B6372656174655573657273121B2E73686F7070696E672E43726561746555736572526571756573741A1D2E73686F7070696E672E4372656174655573657273526573706F6E73652200280112520A0D75706461746550726F64756374121E2E73686F7070696E672E55706461746550726F64756374526571756573741A1F2E73686F7070696E672E55706461746550726F64756374526573706F6E7365220012520A0D72656D6F766550726F64756374121E2E73686F7070696E672E52656D6F766550726F64756374526571756573741A1F2E73686F7070696E672E52656D6F766550726F64756374526573706F6E73652200126A0A156C697374417661696C61626C6550726F647563747312262E73686F7070696E672E4C697374417661696C61626C6550726F6475637473526571756573741A272E73686F7070696E672E4C697374417661696C61626C6550726F6475637473526573706F6E7365220012520A0D73656172636850726F64756374121E2E73686F7070696E672E53656172636850726F64756374526571756573741A1F2E73686F7070696E672E53656172636850726F64756374526573706F6E7365220012460A09616464546F43617274121A2E73686F7070696E672E416464546F43617274526571756573741A1B2E73686F7070696E672E416464546F43617274526573706F6E7365220012490A0A706C6163654F72646572121B2E73686F7070696E672E506C6163654F72646572526571756573741A1C2E73686F7070696E672E506C6163654F72646572526573706F6E73652200620670726F746F33";

public isolated client class ShoppingServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, PROTOBUF_DESC);
    }

    isolated remote function addProduct(AddProductRequest|ContextAddProductRequest req) returns AddProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddProductRequest message;
        if req is ContextAddProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/addProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddProductResponse>result;
    }

    isolated remote function addProductContext(AddProductRequest|ContextAddProductRequest req) returns ContextAddProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddProductRequest message;
        if req is ContextAddProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/addProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <AddProductResponse>result, headers: respHeaders};
    }

    isolated remote function updateProduct(UpdateProductRequest|ContextUpdateProductRequest req) returns UpdateProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateProductRequest message;
        if req is ContextUpdateProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/updateProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <UpdateProductResponse>result;
    }

    isolated remote function updateProductContext(UpdateProductRequest|ContextUpdateProductRequest req) returns ContextUpdateProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        UpdateProductRequest message;
        if req is ContextUpdateProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/updateProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <UpdateProductResponse>result, headers: respHeaders};
    }

    isolated remote function removeProduct(RemoveProductRequest|ContextRemoveProductRequest req) returns RemoveProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveProductRequest message;
        if req is ContextRemoveProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/removeProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <RemoveProductResponse>result;
    }

    isolated remote function removeProductContext(RemoveProductRequest|ContextRemoveProductRequest req) returns ContextRemoveProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        RemoveProductRequest message;
        if req is ContextRemoveProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/removeProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <RemoveProductResponse>result, headers: respHeaders};
    }

    isolated remote function listAvailableProducts(ListAvailableProductsRequest|ContextListAvailableProductsRequest req) returns ListAvailableProductsResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableProductsRequest message;
        if req is ContextListAvailableProductsRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/listAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <ListAvailableProductsResponse>result;
    }

    isolated remote function listAvailableProductsContext(ListAvailableProductsRequest|ContextListAvailableProductsRequest req) returns ContextListAvailableProductsResponse|grpc:Error {
        map<string|string[]> headers = {};
        ListAvailableProductsRequest message;
        if req is ContextListAvailableProductsRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/listAvailableProducts", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <ListAvailableProductsResponse>result, headers: respHeaders};
    }

    isolated remote function searchProduct(SearchProductRequest|ContextSearchProductRequest req) returns SearchProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        SearchProductRequest message;
        if req is ContextSearchProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/searchProduct", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <SearchProductResponse>result;
    }

    isolated remote function searchProductContext(SearchProductRequest|ContextSearchProductRequest req) returns ContextSearchProductResponse|grpc:Error {
        map<string|string[]> headers = {};
        SearchProductRequest message;
        if req is ContextSearchProductRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/searchProduct", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <SearchProductResponse>result, headers: respHeaders};
    }

    isolated remote function addToCart(AddToCartRequest|ContextAddToCartRequest req) returns AddToCartResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartRequest message;
        if req is ContextAddToCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/addToCart", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <AddToCartResponse>result;
    }

    isolated remote function addToCartContext(AddToCartRequest|ContextAddToCartRequest req) returns ContextAddToCartResponse|grpc:Error {
        map<string|string[]> headers = {};
        AddToCartRequest message;
        if req is ContextAddToCartRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/addToCart", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <AddToCartResponse>result, headers: respHeaders};
    }

    isolated remote function placeOrder(PlaceOrderRequest|ContextPlaceOrderRequest req) returns PlaceOrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        PlaceOrderRequest message;
        if req is ContextPlaceOrderRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/placeOrder", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <PlaceOrderResponse>result;
    }

    isolated remote function placeOrderContext(PlaceOrderRequest|ContextPlaceOrderRequest req) returns ContextPlaceOrderResponse|grpc:Error {
        map<string|string[]> headers = {};
        PlaceOrderRequest message;
        if req is ContextPlaceOrderRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("shopping.ShoppingService/placeOrder", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <PlaceOrderResponse>result, headers: respHeaders};
    }

    isolated remote function createUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("shopping.ShoppingService/createUsers");
        return new CreateUsersStreamingClient(sClient);
    }
}

public isolated client class CreateUsersStreamingClient {
    private final grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendCreateUserRequest(CreateUserRequest message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextCreateUserRequest(ContextCreateUserRequest message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveCreateUsersResponse() returns CreateUsersResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <CreateUsersResponse>payload;
        }
    }

    isolated remote function receiveContextCreateUsersResponse() returns ContextCreateUsersResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <CreateUsersResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public isolated client class ShoppingServiceRemoveProductResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendRemoveProductResponse(RemoveProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextRemoveProductResponse(ContextRemoveProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceAddToCartResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendAddToCartResponse(AddToCartResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextAddToCartResponse(ContextAddToCartResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServicePlaceOrderResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendPlaceOrderResponse(PlaceOrderResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextPlaceOrderResponse(ContextPlaceOrderResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceSearchProductResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendSearchProductResponse(SearchProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextSearchProductResponse(ContextSearchProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceListAvailableProductsResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendListAvailableProductsResponse(ListAvailableProductsResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextListAvailableProductsResponse(ContextListAvailableProductsResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceUpdateProductResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendUpdateProductResponse(UpdateProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextUpdateProductResponse(ContextUpdateProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceAddProductResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendAddProductResponse(AddProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextAddProductResponse(ContextAddProductResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public isolated client class ShoppingServiceCreateUsersResponseCaller {
    private final grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCreateUsersResponse(CreateUsersResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCreateUsersResponse(ContextCreateUsersResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextCreateUserRequestStream record {|
    stream<CreateUserRequest, error?> content;
    map<string|string[]> headers;
|};

public type ContextAddProductResponse record {|
    AddProductResponse content;
    map<string|string[]> headers;
|};

public type ContextListAvailableProductsRequest record {|
    ListAvailableProductsRequest content;
    map<string|string[]> headers;
|};

public type ContextListAvailableProductsResponse record {|
    ListAvailableProductsResponse content;
    map<string|string[]> headers;
|};

public type ContextAddToCartResponse record {|
    AddToCartResponse content;
    map<string|string[]> headers;
|};

public type ContextRemoveProductResponse record {|
    RemoveProductResponse content;
    map<string|string[]> headers;
|};

public type ContextAddProductRequest record {|
    AddProductRequest content;
    map<string|string[]> headers;
|};

public type ContextUpdateProductRequest record {|
    UpdateProductRequest content;
    map<string|string[]> headers;
|};

public type ContextSearchProductRequest record {|
    SearchProductRequest content;
    map<string|string[]> headers;
|};

public type ContextAddToCartRequest record {|
    AddToCartRequest content;
    map<string|string[]> headers;
|};

public type ContextPlaceOrderResponse record {|
    PlaceOrderResponse content;
    map<string|string[]> headers;
|};

public type ContextPlaceOrderRequest record {|
    PlaceOrderRequest content;
    map<string|string[]> headers;
|};

public type ContextRemoveProductRequest record {|
    RemoveProductRequest content;
    map<string|string[]> headers;
|};

public type ContextCreateUserRequest record {|
    CreateUserRequest content;
    map<string|string[]> headers;
|};

public type ContextSearchProductResponse record {|
    SearchProductResponse content;
    map<string|string[]> headers;
|};

public type ContextCreateUsersResponse record {|
    CreateUsersResponse content;
    map<string|string[]> headers;
|};

public type ContextUpdateProductResponse record {|
    UpdateProductResponse content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type AddProductResponse record {|
    string product_code = "";
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type ListAvailableProductsRequest record {|
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type ListAvailableProductsResponse record {|
    Product[] products = [];
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type AddToCartResponse record {|
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type Product record {|
    string name = "";
    string description = "";
    float price = 0.0;
    int stock_quantity = 0;
    string sku = "";
    Product_ProductStatus status = AVAILABLE;
|};

public enum Product_ProductStatus {
    AVAILABLE, OUT_OF_STOCK
}

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type RemoveProductResponse record {|
    Product[] products = [];
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type AddProductRequest record {|
    Product product = {};
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type UpdateProductRequest record {|
    Product product = {};
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type SearchProductRequest record {|
    string sku = "";
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type AddToCartRequest record {|
    string user_id = "";
    string sku = "";
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type PlaceOrderResponse record {|
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type PlaceOrderRequest record {|
    string user_id = "";
    Product[] products = [];
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type RemoveProductRequest record {|
    string sku = "";
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type CreateUserRequest record {|
    string username = "";
    string password = "";
    CreateUserRequest_UserType user_type = CUSTOMER;
|};

public enum CreateUserRequest_UserType {
    CUSTOMER, ADMIN
}

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type SearchProductResponse record {|
    Product product = {};
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type CreateUsersResponse record {|
|};

@protobuf:Descriptor {value: PROTOBUF_DESC}
public type UpdateProductResponse record {|
|};

