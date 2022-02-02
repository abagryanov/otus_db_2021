<template>
  <v-container>
    <v-row>
      <v-col lg="6" md="10" sm="6">
        <v-card elevation="0" class="mb-6" tile="">
          <v-row align="start">
            <v-col class="shrink">
              <v-img src="https://image.shutterstock.com/image-photo/food-sources-plant-based-protein-600w-1892618254.jpg" max-width="200" class="ml-10"></v-img>
            </v-col>
            <v-col>
              <v-card-title>{{this.name}}</v-card-title>
              <v-card-subtitle>{{this.description}}</v-card-subtitle>
              <div style="padding-left: 15px">
                <p>Скидка: {{this.discount}}</p>
                <p>Цена: {{this.price}} (Руб.)</p>
                <v-text-field v-if="isLoggedIn" v-model="amount" label="Количество:"></v-text-field>
                <v-btn v-if="isLoggedIn" color="#BBDEFB">В корзину</v-btn>
              </div>
            </v-col>
          </v-row>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import {mapGetters} from "vuex"
export default {
  name: "Product",

  data() {
    return {
      amount: 0
    }
  },

  props: {
    id: {
      type: Number,
      required: true
    },

    name: {
      type: String,
      required: true
    },

    description: {
      type: String,
      required: true
    },

    productSaleType: {
      type: String,
      required: true
    },

    productPrice: {
      type: Number,
      required: true
    },

    productDiscount: {
      type: Number,
      required: true
    },

    productMargin: {
      type: Number,
      required: true
    }
  },

  computed: {
    ...mapGetters([
      "isLoggedIn",
    ]),
    discount() {
      return this.productDiscount * 100 + '%'
    },

    price() {
      return (this.productPrice * this.productMargin * (1 - this.productDiscount)).toFixed(2)
    }
  }
}
</script>

<style lang="scss">
  v-card {
    border: none;
  }
</style>