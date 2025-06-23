import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["board", "minButton", "maxButton", "main", "scrolled"]

    connect() {
        this.fullscreen = this.#cookieGet("gameboard_fullscreen") === "true"
        this.#applyFullscreenStyles()
    }

    toggle() {
        this.fullscreen = !this.fullscreen
        this.#applyFullscreenStyles()
        this.#cookieSet("gameboard_fullscreen", this.fullscreen, 365)
    }

    #applyFullscreenStyles() {
        if (this.fullscreen) {
            this.boardTarget.classList.add("fullscreen-mode")
            this.minButtonTarget.classList.remove("is-hidden")
            this.maxButtonTarget.classList.add("is-hidden")

            this.mainTarget.classList.add("is-flex", "is-flex-direction-column")
            this.mainTarget.style.height = "100vh"

            this.scrolledTarget.style.overflowY = "auto"
            this.scrolledTarget.style.flexGrow   = "1"
        } else {
            this.boardTarget.classList.remove("fullscreen-mode")
            this.minButtonTarget.classList.add("is-hidden")
            this.maxButtonTarget.classList.remove("is-hidden")

            this.mainTarget.classList.remove("is-flex", "is-flex-direction-column")
            this.mainTarget.style.height = ""

            this.scrolledTarget.style.overflowY = ""
            this.scrolledTarget.style.flexGrow  = ""
        }
    }

    #cookieGet(name) {
        const match = document.cookie.match(new RegExp("(^|; )" + name + "=([^;]*)"))
        return match ? decodeURIComponent(match[2]) : null
    }

    #cookieSet(name, value, days) {
        const expires = new Date(Date.now() + days*24*60*60*1000).toUTCString()
        document.cookie = `${name}=${encodeURIComponent(value)}; expires=${expires}; path=/; SameSite=Lax`
    }
}
