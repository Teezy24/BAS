import ballerina/grpc;
import ballerina/io;

// Define the request and response
type AddProductRequest record {
    string name;
    int quantity;
};

type AddProductResponse record {
    string message;
};

type UpdateProductRequest record {
    string name;
    int newQuantity;
};

type UpdateProductResponse record {
    string message;
};

type RemoveProductRequest record {
    string name;
};

type RemoveProductResponse record {
    string message;
};

type ListAvailableProductsRequest record {};

type ListAvailableProductsResponse record {
    string[] products;
};

type SearchProductRequest record {
    string name;
};

type SearchProductResponse record {
    string[] products;
};

type AddToCartRequest record {
    string productName;
    int quantity;
};

type AddToCartResponse record {
    string message;
};

type PlaceOrderRequest record {
    string[] products;
};

type PlaceOrderResponse record {
    string message;
};

type CreateUsersStreamingClient object {
    remote function onNext(User user) {};
    remote function onError(error e) {};
    remote function onComplete() {};
};

type User record {
    string name;
    string email;
};

// Defining the service
service "ShoppingService" {
    function addProduct(AddProductRequest req) returns AddProductResponse = {
        io:println("Adding product: ", req.name, " with quantity: ", req.quantity);
        AddProductResponse { message: "Product added successfully" };
    };

    function updateProduct(UpdateProductRequest req) returns UpdateProductResponse = {
        io:println("Updating product: ", req.name, " with new quantity: ", req.newQuantity);
        UpdateProductResponse { message: "Product updated successfully" };
    };

    function removeProduct(RemoveProductRequest req) returns RemoveProductResponse = {
        io:println("Removing product: ", req.name);
        RemoveProductResponse { message: "Product removed successfully" };
    };

    function listAvailableProducts(ListAvailableProductsRequest req) returns ListAvailableProductsResponse = {
        string[] products = ["Product1", "Product2", "Product3"];
        ListAvailableProductsResponse { products };
    };

    function searchProduct(SearchProductRequest req) returns SearchProductResponse = {
        string[] products = ["Product1", "Product2"];
        SearchProductResponse { products };
    };

    function addToCart(AddToCartRequest req) returns AddToCartResponse = {
        io:println("Adding product: ", req.productName, " to cart with quantity: ", req.quantity);
        AddToCartResponse { message: "Product added to cart successfully" };
    };

    function placeOrder(PlaceOrderRequest req) returns PlaceOrderResponse = {
        io:println("Placing order for products: ", req.products);
        PlaceOrderResponse { message: "Order placed successfully" };
    };

    function createUsers() returns CreateUsersStreamingClient = {
        CreateUsersStreamingClient {
            onNext: function (User user) {
                io:println("User created: ", user.name, " with email: ", user.email);
            },
            onError: function (error e) {
                io:println("Error creating user: ", e.getMessage());
            },
            onComplete: function () {
                io:println("User creation completed");
            }
        };
    };
}

type ShoppingServiceClient client<ShoppingService>;
