import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "value"]

    connect() {
        this.update()
    }

    update() {
        this.valueTarget.textContent = this.inputTarget.value
    }
}
