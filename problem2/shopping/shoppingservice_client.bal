import ballerina/io;
import ballerina/grpc;


ShoppingServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    AddProductRequest addProductRequest = {product: {name: "ballerina", description: "ballerina", price: 1, stock_quantity: 1, sku: "ballerina", status: "AVAILABLE"}};
    AddProductResponse addProductResponse = check ep->addProduct(addProductRequest);
    io:println(addProductResponse);

    UpdateProductRequest updateProductRequest = {product: {name: "ballerina", description: "ballerina", price: 1, stock_quantity: 1, sku: "ballerina", status: "AVAILABLE"}};
    UpdateProductResponse updateProductResponse = check ep->updateProduct(updateProductRequest);
    io:println(updateProductResponse);

    RemoveProductRequest removeProductRequest = {sku: "ballerina"};
    RemoveProductResponse removeProductResponse = check ep->removeProduct(removeProductRequest);
    io:println(removeProductResponse);

    ListAvailableProductsRequest listAvailableProductsRequest = {message: "ballerina"};
    ListAvailableProductsResponse listAvailableProductsResponse = check ep->listAvailableProducts(listAvailableProductsRequest);
    io:println(listAvailableProductsResponse);

    SearchProductRequest searchProductRequest = {sku: "ballerina"};
    SearchProductResponse searchProductResponse = check ep->searchProduct(searchProductRequest);
    io:println(searchProductResponse);

    AddToCartRequest addToCartRequest = {user_id: "ballerina", sku: "ballerina"};
    AddToCartResponse addToCartResponse = check ep->addToCart(addToCartRequest);
    io:println(addToCartResponse);

    PlaceOrderRequest placeOrderRequest = {user_id: "ballerina", products: [{name: "ballerina", description: "ballerina", price: 1, stock_quantity: 1, sku: "ballerina", status: "AVAILABLE"}]};
    PlaceOrderResponse placeOrderResponse = check ep->placeOrder(placeOrderRequest);
    io:println(placeOrderResponse);

    CreateUserRequest createUsersRequest = {username: "ballerina", password: "ballerina", user_type: "CUSTOMER"};
    CreateUsersStreamingClient createUsersStreamingClient = check ep->createUsers();
    check createUsersStreamingClient->sendCreateUserRequest(createUsersRequest);
    check createUsersStreamingClient->complete();
    CreateUsersResponse? createUsersResponse = check createUsersStreamingClient->receiveCreateUsersResponse();
    io:println(createUsersResponse);
}

