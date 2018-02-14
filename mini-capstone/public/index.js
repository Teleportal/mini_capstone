var productTemplate = document.querySelector("#product-card");
var productContainer = document.querySelector(".card-deck");

axios.get("http://localhost:3000/products").then(function(response) {
  var products = response.data;
  products.forEach(function(product) {
    var productClone = productTemplate.content.cloneNode(true);
    productClone.querySelector(".card-title").innerText = product.name;
    productClone.querySelector(".card-img-top").src = product.images[0];
    productClone.querySelector(".supplier").innerText =
      product.supplier["name"];
    productClone.querySelector(".price").innerText = product.formatted.price;
    productClone.querySelector(".description").innerText = product.description;
    productClone.querySelector(".categories").innerText = product.categories;
    productContainer.appendChild(productClone);
  });
});
