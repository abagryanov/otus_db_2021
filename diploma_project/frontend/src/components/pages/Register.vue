<template>
  <div class="main">
    <div class="register">
      <div class="register__header">
        <h1>Регистрация</h1>
      </div>

      <v-card flat>
        <v-card-text>
          <v-form @submit.prevent="doRegister">
            <v-text-field
                v-model="customerFirstName"
                label="Имя"
                required
                :error="isRegisterFailed"
            />

            <v-text-field
                v-model="customerLastName"
                label="Фамилия"
                :error="isRegisterFailed"
            />

            <v-text-field
                v-model="customerLogin"
                label="Логин"
                required
                :error="isRegisterFailed"
            />

            <v-text-field
                v-model="customerPassword"
                label="Пароль"
                type="password"
                required
                :error="isRegisterFailed"
            />

            <v-text-field
                v-model="email"
                label="Эл. почта"
                required
                :error="isRegisterFailed"
            />

            <v-btn
                x-large
                block
                :disabled="!valid"
                color="success"
                type="submit"
                :loading="isRegisterInProgress"
                depressed
            >
              Зарегистрироваться
            </v-btn>

            <div
                v-if="isRegisterFailed"
                class="register__error"
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
import api from "@/api";

export default {
  name: "Register",

  data() {
    return {
      customerFirstName: "",
      customerLastName: "",
      customerLogin: "",
      customerPassword: "",
      email: "",
      phone: "",
      roles: ["USER"],
      dialog: true,
      isRegisterFailed: false,
      isRegisterInProgress: false
    }
  },

  computed: {
    valid() {
      return this.customerLogin && this.customerPassword && this.email
    },
  },

  methods: {
    async doRegister() {
      const customerFirstName = this.customerFirstName
      const customerLastName = this.customerLastName
      const customerLogin = this.customerLogin
      const customerPassword = this.customerPassword
      const email = this.email
      const phone = this.phone
      const roles = this.roles
      try {
        this.isRegisterInProgress = true
        this.isRegisterFailed = false
        await api.registerCustomer({customerFirstName, customerLastName, customerLogin, customerPassword, email, phone, roles})
        await this.$router.push("/login")
      } catch (error) {
        console.info(error.name + " : " + error.message)
        this.isRegisterFailed = true
      } finally {
        this.isRegisterInProgress = false
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

.register {
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