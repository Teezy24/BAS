import ballerina/grpc;
import ballerina/io;

public function main() {
    // Create a new gRPC client
    grpc:Client client = check grpc:Client('localhost:9090');

    // Create a new product
    AddProductRequest req = {};
    req.product = {};
    req.product.name = "Product 1";
    req.product.description = "This is product 1";
    req.product.price = 10.99;
    req.product.stockQuantity = 10;
    req.product.sku = "SKU-1";
    req.product.status = ProductStatus.AVAILABLE;

    AddProductResponse res = check client->addProduct(req);
    io:println("Added product: " + res.productCode);

    // Search for a product
    SearchProductRequest searchReq = {};
    searchReq.sku = "SKU-1";

    SearchProductResponse searchRes = check client->searchProduct(searchReq);
    io:println("Product found: " + searchRes.product.name);

    // Add to cart
    AddToCartRequest cartReq = {};
    cartReq.userId = "user-1";
    cartReq.sku = "SKU-1";

    AddToCartResponse cartRes = check client->addToCart(cartReq);
    io:println("Added to cart");

    // Place order
    PlaceOrderRequest orderReq = {};
    orderReq.userId = "user-1";
    orderReq.products = [{name: "Product 1", sku: "SKU-1"}];

    PlaceOrderResponse orderRes = check client->placeOrder(orderReq)
}