import ballerina/io;
import ballerina/grpc;

// Define the client to communicate with the ShoppingService
ShoppingServiceClient shoppingClient = check new ("http://localhost:9090");

// Define message types (These types will be auto-generated from the proto file)

type Product record {
    string name;
    string size;
    decimal price;
    int quantity;
    string sku;
};

// Define request and response types
type ListAvailableProductsRequest record {};

type ListAvailableProductsResponse record {
    Product[] products;
};

type SearchProductRequest record {
    string productName;
};

type SearchProductResponse record {
    Product product;
};

type AddToCartRequest record {
    string productCode;
    int quantity;
};

type AddToCartResponse record {
    string confirmation;
};

type PlaceOrderRequest record {
    string orderId;
    string[] productCodes;
    decimal totalPrice;
};

type PlaceOrderResponse record {
    string confirmation;
};

public function main() {

    // Example 1: List available products
    ListAvailableProductsRequest listRequest = {};
    ListAvailableProductsResponse listResponse = check shoppingClient->listAvailableProducts(listRequest);
    io:println("Available Products: ", listResponse.products);

    // Example 2: Search for a product
    SearchProductRequest searchRequest = {productName: "Laptop"};
    SearchProductResponse searchResponse = check shoppingClient->searchProduct(searchRequest);
    io:println("Search Result for Laptop: ", searchResponse.product);

    // Example 3: Add a product to the cart
    AddToCartRequest addToCartRequest = {
        productCode: "PRODUCT-123",
        quantity: 2
    };
    AddToCartResponse addToCartResponse = check shoppingClient->addToCart(addToCartRequest);
    io:println("Added to cart, confirmation: ", addToCartResponse.confirmation);

    // Example 4: Place an order
    PlaceOrderRequest placeOrderRequest = {
        orderId: "ORDER-001",
        productCodes: ["PRODUCT-123", "PRODUCT-456"],
        totalPrice: 1500.50
    };
    PlaceOrderResponse placeOrderResponse = check shoppingClient->placeOrder(placeOrderRequest);
    io:println("Order placed, confirmation: ", placeOrderResponse.confirmation);

}
