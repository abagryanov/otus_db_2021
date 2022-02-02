import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from "vuex-persistedstate"
import api from "@/api"

Vue.use(Vuex)

const initialState = {
  loginStatus: "",
  customerId: "",
  customerLogin: "",
}

const store = new Vuex.Store({
  state: Object.assign({}, initialState),

  getters: {
    isLoggedIn: state => !!state.customerLogin,
    isNotLoggedIn: state => !state.customerLogin,
    isLoginInProgress: state => state.loginStatus === "inProgress",
    isLoginFailed: state => state.loginStatus === "error",
    getCustomerId: state => state.customerId,
    getCustomerName: state => state.customerLogin,
    getProductsData: state => state.productsData
  },

  mutations: {
    resetStateData(state) {
      Object.assign(state, initialState)
    },

    setAuthInProgress(state) {
      state.loginStatus = "inProgress"
    },

    setAuthSuccess(state, userData) {
      state.loginStatus = "success"
      state.customerId = userData.customerId
      state.customerLogin = userData.customerLogin
    },

    setAuthError(state) {
      state.loginStatus = "error"
      state.customerId = ""
      state.customerLogin = ""
    },

    setProductsDataStore(state, data) {
      state.productsData = data
    }
  },

  actions: {
    async login({commit}, user) {
      try {
        commit("setAuthInProgress")
        const userData = await api.login(user)
        commit("setAuthSuccess", userData)
        console.log("USR_DATA1: " + userData.customerId)
        console.log("USR_DATA2: " + userData.customerLogin)
        console.log("LOGIN: " + this.state.customerLogin)
      } catch (error) {
        commit("setAuthError")
        throw error
      }
    },

    resetAppStateData({commit}) {
      commit("resetStateData")

      api.logout()
    },

    async setProductsData({commit}, productCategories) {
      const productsData = await api.getProducts(productCategories)
      commit("setProductsDataStore", productsData.slice(0)
          .sort((a, b) => a.name.localeCompare(b.name)))
    }
  },

  modules: {
  },

  plugins: [createPersistedState()],
})

export default store
