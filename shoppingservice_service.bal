import ballerina/grpc;
import shopping_service.pb as PB;
import shopping_service.datastore as Datastore;
import ballerina/log;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: PB:PROTOBUF_DESC}
service "ShoppingService" on ep {

    remote function addProduct(PB:AddProductRequest value) returns PB:AddProductResponse|error {
        log:printInfo("Product Successfully added");
        Datastore:products.add(value);
        return 
    }

    remote function updateProduct(PB:UpdateProductRequest value) returns PB:UpdateProductResponse|error {
    }

    remote function removeProduct(PB:RemoveProductRequest value) returns PB:RemoveProductResponse|error {
    }

    remote function listAvailableProducts(PB:ListAvailableProductsRequest value) returns PB:ListAvailableProductsResponse|error {
    }

    remote function searchProduct(PB:SearchProductRequest value) returns PB:SearchProductResponse|error {
    }

    remote function addToCart(PB:AddToCartRequest value) returns PB:AddToCartResponse|error {
    }

    remote function placeOrder(PB:PlaceOrderRequest value) returns PB:PlaceOrderResponse|error {
    }

    remote function createUsers(stream<PB:CreateUserRequest, grpc:Error?> clientStream) returns PB:CreateUsersResponse|error {
    }
}

