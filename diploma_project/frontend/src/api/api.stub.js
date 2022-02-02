import authLoginStub from "@/api/stubs/auth-login"
import jwt_decode from "jwt-decode"
import register from "@/api/stubs/register";
import products from "@/api/stubs/products"

class Api {
    _customerId = null
    _customerLogin = null
    _accessToken = null

    constructor() {
    }

    async _getDataWithTimeout(data) {
        await new Promise(resolve => {
            setTimeout(resolve, 500)
        })
        return data
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
        if (customerLogin === "abagryanov" && customerPassword === "Test") {
            let {data} = await this._getDataWithTimeout(authLoginStub)
            return this._login(data.accessToken)
        } else {
            throw new Error("Login failed")
        }
    }

    async registerCustomer() {
        await this._getDataWithTimeout(register)
    }

    async getProducts() {
        const _products = await this._getDataWithTimeout(products)
        return _products.data.productsData;
    }

    logout() {
        this._customerId = null
        this._customerLogin = null
        this._accessToken = null
    }

}

export const api = new Api()
