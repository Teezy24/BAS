import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: PROTOBUF_DESC}
service "ShoppingService" on ep {

    remote function addProduct(AddProductRequest value) returns AddProductResponse|error {
    }

    remote function updateProduct(UpdateProductRequest value) returns UpdateProductResponse|error {
    }

    remote function removeProduct(RemoveProductRequest value) returns RemoveProductResponse|error {
    }

    remote function listAvailableProducts(ListAvailableProductsRequest value) returns ListAvailableProductsResponse|error {
    }

    remote function searchProduct(SearchProductRequest value) returns SearchProductResponse|error {
    }

    remote function addToCart(AddToCartRequest value) returns AddToCartResponse|error {
    }

    remote function placeOrder(PlaceOrderRequest value) returns PlaceOrderResponse|error {
    }

    remote function createUsers(stream<CreateUserRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
    }
}

