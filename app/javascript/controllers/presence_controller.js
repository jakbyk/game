import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.ping()
        this.timer = setInterval(() => this.ping(), 10000)
    }

    disconnect() {
        clearInterval(this.timer)
    }

    ping() {
        fetch("/ping", { method: "POST", headers: { "X-CSRF-Token": document.querySelector("[name='csrf-token']").content } })
    }
}