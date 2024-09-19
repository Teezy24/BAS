import server.pb as PB;

public table<PB:Product> key(sku) addProduct = table [
    {name: "",description: "",price: 0.0,stock_quantity: 0, sku: ""}

];

public table<PB:Product> key(sku) addToCart = table [


];
