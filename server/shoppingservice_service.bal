import server.datastore as Datastore;
import server.pb as PB;

import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: PROTOBUF_DESC}
service "ShoppingService" on ep {

    remote function addProduct(PB:AddProductRequest value) returns PB:AddProductResponse|error {
        do {
            Datastore:addProduct.add(value.product);
            PB:AddProductResponse response = {product_code: value.product.sku};
            return response;
        } on fail var e {

            return e;

        }
    }

    remote function updateProduct(PB:UpdateProductRequest value) returns PB:UpdateProductResponse|error {
        Datastore:addProduct.put(value.product);
        return error grpc:UnimplementedError("not supported yet");
    }

    remote function removeProduct(RemoveProductRequest value) returns PB:RemoveProductResponse|error {
        do {
            var _ = Datastore:addProduct.remove(value.sku);
            PB:RemoveProductResponse response = {products: Datastore:addProduct.toArray()};
            return response;
        } on fail var e {
            return e;

        }
    }

    remote function listAvailableProducts(ListAvailableProductsRequest value) returns PB:ListAvailableProductsResponse|error {
        do {
            PB:Product[] products = from var product in Datastore:addProduct
                where product.stock_quantity > 0
                select product;
            PB:ListAvailableProductsResponse listofproducts = {products: products};
            return  listofproducts;
        } on fail var e {
            return e;

        }
    }

remote function searchProduct(SearchProductRequest value) returns SearchProductResponse|error {
    do {
        PB:Product[] products = from var product in Datastore:addProduct
            where product.name.toLowerAscii() == product.name.toLowerAscii()
            select product;
        
        PB:SearchProductResponse searchProductResponse = {product:products[0]};
        return searchProductResponse;
    } on fail var e {
        return error("Failed to search products", e);
    }
}

    remote function addToCart(AddToCartRequest value) returns AddToCartResponse|error {
            if value.user_id == "customer"{
                AddToCartResponse response = {message: "Product added to cart"};
                return response;
            }
        
        return error grpc:UnimplementedError("not supported yet");
    }

    remote function placeOrder(PlaceOrderRequest value) returns PlaceOrderResponse|error {
            

        return error grpc:UnimplementedError("not supported yet");
    }

    remote function createUsers(stream<CreateUserRequest, grpc:Error?> clientStream) returns CreateUsersResponse|error {
        return error grpc:UnimplementedError("not supported yet");
    }
}

