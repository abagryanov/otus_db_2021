let apiModule

if (process.env.NODE_ENV === "production" || process.env.VUE_APP_DEV_PROXY_BACK === "true") {
    apiModule = require("@/api/api")
} else {
    apiModule = require("@/api/api.stub")
}

export default apiModule.api