import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = { interval: Number }

    connect() {
        this.timer = setInterval(() => {
            this.element.src = this.element.src
        }, this.intervalValue || 10000)
    }

    disconnect() {
        clearInterval(this.timer)
    }
}