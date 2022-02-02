<template>
  <div class="main">
    <div class="login">
      <div class="login__header">
        <h1>Вход</h1>
      </div>

      <v-card flat>
        <v-card-text>
          <v-form @submit.prevent="doLogin">
            <v-text-field
                v-model="customerLogin"
                label="Логин"
                required
                :error="isLoginFailed"
            />

            <v-text-field
                v-model="customerPassword"
                label="Пароль"
                type="password"
                required
                :error="isLoginFailed"
            />

            <v-btn
                x-large
                block
                :disabled="!valid"
                color="success"
                type="submit"
                :loading="isLoginInProgress"
                depressed
            >
              Войти
            </v-btn>

            <div
                v-if="isLoginFailed"
                class="login__error"
            >
              Неверный логин или пароль
            </div>
          </v-form>
        </v-card-text>
      </v-card>
    </div>
  </div>
</template>

<script>
import {mapGetters, mapActions} from "vuex"

export default {
  name: "Login",

  data() {
    return {
      customerLogin: "",
      customerPassword: "",
      dialog: true,
    }
  },

  created() {
    this.resetAppStateData()
  },

  computed: {
    ...mapGetters([
      "isLoginFailed",
      "isLoginInProgress",
    ]),

    valid() {
      return this.customerLogin && this.customerPassword
    },
  },

  methods: {
    ...mapActions([
      "login",
      "resetAppStateData"
    ]),

    async doLogin() {
      const customerLogin = this.customerLogin
      const customerPassword = this.customerPassword
      try {
        await this.login({customerLogin, customerPassword})
        await this.$router.push("/")
      } catch (error) {
        console.info(error.name + " : " + error.message)
      }
    },
  },
}
</script>

<style lang="scss">
.main {
  height: 100%;
  width: 100%;
  position: fixed;
  top: 0;
  left: 0;
  display: flex;
  align-items: center;
  align-content: center;
  justify-content: center;
  overflow: auto;
}

.login {
  width: 400px;
  border: solid gray .5px;

  &__header {
    padding-top: 10px;
    display: flex;
    justify-content: center;
  }

  &__error {
    display: flex;
    justify-content: center;
    color: red;
    padding-top: 10px;
  }
}
</style>
