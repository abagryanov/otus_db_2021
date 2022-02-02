import axios from "axios"
import jwt_decode from "jwt-decode"
import Endpoints from "@/api/endpoints/endpoints"

class Api {
    _client = axios.create()
    _customerId = null
    _customerLogin = null
    _accessToken = null

    constructor() {
        this._client.interceptors.request.use(
            config => {
                if (!this._accessToken) {
                    return config
                }
                const newConfig = {
                    headers: {},
                    ...config,
                }
                newConfig.headers.Authorization = `Bearer ${this._accessToken}`
                return newConfig
            },
            e => Promise.reject(e)
        )
    }

    getConfig() {
        const newConfig = {
            headers: {}
        }
        if (!this._accessToken) {
            return newConfig
        }
        newConfig.headers.Authorization = `Bearer ${this._accessToken}`
        return newConfig
    }

    _parseAccessToken(accessToken) {
        const {sub, customerLogin} = jwt_decode(accessToken)
        return {tokenCustomerId: sub, tokenCustomerLogin: customerLogin}
    }

    _login(newAccessToken) {
        const {tokenCustomerId, tokenCustomerLogin} = this._parseAccessToken(newAccessToken)
        this._customerId = tokenCustomerId
        this._customerLogin = tokenCustomerLogin
        this._accessToken = newAccessToken
        return {customerId: this._customerId, customerLogin: this._customerLogin}
    }

    async login({customerLogin, customerPassword}) {
        try {
            const {data} = await this._client.post(Endpoints.authLogin, {customerLogin, customerPassword})
            return this._login(data.accessToken)
        } catch (error) {
            throw new Error("Login failed")
        }
    }

    async registerCustomer({customerFirstName, customerLastName, customerLogin, customerPassword, email, phone, roles}) {
        console.log(customerFirstName + " " + customerPassword)
        try {
            await this._client.post(Endpoints.register, {customerFirstName, customerLastName, customerLogin,
                customerPassword, email, phone, roles})
        } catch (error) {
            throw new Error("Registration failed")
        }
    }

    async getProducts(productCategories) {
        try {
            const products = await this._client.post(Endpoints.products, {productCategories: productCategories}, this.getConfig())
            return products.data.productsData;
        } catch (error) {
            throw new Error("Failed to get products")
        }
    }

    logout() {
        this._customerId = null
        this._customerLogin = null
        this._accessToken = null
    }
}

export const api = new Api()
