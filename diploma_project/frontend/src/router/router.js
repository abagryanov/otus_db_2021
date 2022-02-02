import Vue from "vue"
import Router from "vue-router"
import Market from "@/components/pages/Market"
import Login from "@/components/pages/Login"
import NotFound from "@/components/pages/NotFound"
import Bucket from "@/components/pages/Bucket"
import Register from "@/components/pages/Register"
import store from "@/store"

Vue.use(Router)

const router = new Router({
    mode: "history",

    routes: [
        {
            path: "/login",
            name: "Login",
            component: Login,
            meta: {
                title: "Вход"
            }
        },
        {
            path: "/",
            name: "Market",
            component: Market,
            meta: {
                title: "Магазин"
            }
        },
        {
            path: "/bucket",
            name: "Bucket",
            component: Bucket,
            meta: {
                requiresAuth: true,
                title: "Корзина"
            }
        },
        {
            path: "/register",
            name: "Register",
            component: Register,
            meta: {
                title: "Регистрация"
            }
        },
        {
            path: "*",
            component: NotFound,
            meta: {
                title: "Not Found"
            }
        },
    ]
})

router.beforeEach(async function (to, from, next) {
    document.title = to.meta.title
    if (to.matched.some(record => record.meta.requiresAuth)) {
        if (store.getters.isLoggedIn) {
            next()
        } else {
            next({
                path: "/login",
                query: {
                    redirect: to
                }
            })
        }
    } else {
        if (to.fullPath.startsWith("/logout")) {
            await store.dispatch("resetAppStateData")
            next({
                path: "/login",
                query: {
                    redirect: to
                }
            })
        }
        else if (to.fullPath === "/login?redirect=") {
            next({
                path: "/",
                query: {
                    redirect: to
                }
            })
        } else {
            next()
        }
    }
})

export default router