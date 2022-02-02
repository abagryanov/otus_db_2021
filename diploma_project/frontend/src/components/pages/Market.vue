<template>
  <div><h1>Магазин</h1>
    <product v-for="product in productsData"
             :key="product.id"
             :id="product.id"
             :name="product.name"
             :description="product.description"
             :product-sale-type="product.productSaleType"
             :product-price="product.productPrice"
             :product-discount="product.productDiscount"
             :product-margin="product.productMargin">
    </product>
  </div>
</template>

<script>
import Product from "@/components/Product";
import {mapGetters, mapActions} from "vuex"

export default {
  name: "Market",

  components: {
    Product
  },

  computed: {
    ...mapGetters([
        "getProductsData"
    ]),

    productsData() {
      return this.getProductsData
    }
  },

  methods: {
    ...mapActions([
        "setProductsData"
    ])
  },

  created() {
    this.setProductsData([])
  }
}
</script>

<style scoped>

</style>