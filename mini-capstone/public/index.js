/* global Vue, VueRouter, axios */

// Products Components

var ProductsIndexPage = {
  template: "#products-index-page",
  data: function() {
    return {
      products: []
    };
  },
  created: function() {
    axios.get("/products").then(
      function(response) {
        this.products = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var ProductShowPage = {
  template: "#product-show-page",
  data: function() {
    return {
      product: {
        name: "",
        supplier: {},
        formatted: {},
        description: "",
        categories: [],
        images: []
      }
    };
  },
  created: function() {
    axios.get("/products/" + this.$route.params.id).then(
      function(response) {
        this.product = response.data;
      }.bind(this)
    );
  },
  methods: {},
  computed: {}
};

var ProductNewPage = {
  template: "#product-new-page",
  data: function() {
    return {
      name: "",
      price: "",
      description: "",
      supplierID: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        price: this.price,
        description: this.description,
        supplier_id: this.supplierID
      };
      axios
        .post("/products", params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
            router.push("/login");
          }.bind(this)
        );
    }
  }
};

var ProductEditPage = {
  template: "#product-edit-page",
  data: function() {
    return {
      name: "",
      price: "",
      description: "",
      imageUrl: "",
      errors: []
    };
  },
  created: function() {
    axios.get("/products/" + this.$route.params.id).then(
      function(response) {
        this.name = response.data.name;
        this.price = response.data.price;
        this.description = response.data.description;
      }.bind(this)
    );
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        price: this.price,
        description: this.description,
        supplier_id: this.supplierID
      };
      var imageURL = this.imageUrl;
      var id = this.$route.params.id;
      if (imageURL !== "") {
        axios
          .post("/images", {
            url: imageURL,
            product_id: parseInt(id)
          })
          .then(
            axios
              .patch("/products/" + this.$route.params.id, params)
              .then(function(response) {
                router.push("/products/" + response.data.id);
              })
              .catch(
                function(error) {
                  this.errors = error.response.data.errors;
                  router.push("/login");
                }.bind(this)
              )
          );
      } else {
        axios
          .patch("/products/" + this.$route.params.id, params)
          .then(function(response) {
            router.push("/products/" + response.data.id);
          })
          .catch(
            function(error) {
              this.errors = error.response.data.errors;
              router.push("/login");
            }.bind(this)
          );
      }
    }
  }
};

var ProductsDestroy = {
  created: function() {
    axios.delete("/products/" + this.$route.params.id).then(
      function(response) {
        router.push("/");
      }.bind(this)
    );
  }
};

// Shopping Components

var CartIndexPage = {
  template: "#cart-index-page",
  data: function() {
    return {
      cart: []
    };
  },
  created: function() {
    axios.get("/carted_products").then(
      function(response) {
        this.cart = response.data;
      }.bind(this)
    );
  }
};

var OrdersIndexPage = {
  template: "#cart-index-page",
  data: function() {
    return {
      cart: []
    };
  },
  created: function() {
    axios.get("/carted_products").then(
      function(response) {
        this.cart = response.data;
      }.bind(this)
    );
  }
};

// Authorization Components

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: ProductsIndexPage },
    { path: "/products", component: ProductsIndexPage },
    { path: "/products/new", component: ProductNewPage },
    { path: "/products/:id", component: ProductShowPage },
    { path: "/products/:id/edit", component: ProductEditPage },
    { path: "/product/:id/delete", component: ProductsDestroy },
    { path: "/carted_products", component: CartIndexPage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});
