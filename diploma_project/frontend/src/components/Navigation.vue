<template>
  <v-navigation-drawer
      app
      expand-on-hover
      touchless
      dark
  >
    <v-list-item class="px-2">
      <v-list-item-icon>
        <v-icon x-large>
          mdi-account-circle
        </v-icon>
      </v-list-item-icon>
      <v-list-item-content>
        <v-list-item-title class="font-weight-bold" v-if="isLoggedIn">
          {{getCustomerName}}
        </v-list-item-title>
        <v-list-item-title class="font-weight-bold" v-else>
          Гость
        </v-list-item-title>
      </v-list-item-content>
    </v-list-item>

    <router-link
        to="/login"
        class="nav-bar__item"
    >
      <v-list-item link v-if="isNotLoggedIn">
        <v-list-item-icon>
          <v-icon>
            mdi-login
          </v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>
            Войти
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </router-link>

    <router-link
        to="/register"
        class="nav-bar__item"
    >
      <v-list-item link v-if="isNotLoggedIn">
        <v-list-item-icon>
          <v-icon>
            mdi-account-plus
          </v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>
            Регистрация
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </router-link>

    <router-link
        to="/logout"
        class="nav-bar__item"
    >
      <v-list-item link v-if="isLoggedIn">
        <v-list-item-icon>
          <v-icon>
            mdi-logout
          </v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title>
            Выйти
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </router-link>

    <v-divider/>

    <v-list>
      <router-link
          to="/"
          class="nav-bar__item"
      >
        <v-list-item link>
          <v-list-item-icon>
            <v-icon>
              mdi-shopping
            </v-icon>
          </v-list-item-icon>
          <v-list-item-title>Магазин</v-list-item-title>
        </v-list-item>
      </router-link>

      <router-link
          to="/bucket"
          v-if="isLoggedIn"
          class="nav-bar__item"
      >
        <v-list-item link>
          <v-list-item-icon>
            <v-icon>
              mdi-bucket
            </v-icon>
          </v-list-item-icon>
          <v-list-item-title>Корзина</v-list-item-title>
        </v-list-item>
      </router-link>
    </v-list>

  </v-navigation-drawer>
</template>

<script>
import {mapGetters} from "vuex"

export default {
  name: "Navigation",

  components: {},

  computed: {
    ...mapGetters([
      "isLoggedIn",
      "isNotLoggedIn",
      "getCustomerName",
    ]),
  },
}
</script>

<style lang="scss">
.nav {
  &-bar {
    &__item {
      text-decoration: none !important;
      color: white !important;
    }
  }
}
</style>