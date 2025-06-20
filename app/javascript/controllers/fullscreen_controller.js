import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["board", "button"]

    connect() {
        this.buttonTarget.textContent = "Pełny ekran"
        this.fullscreen = false
    }

    toggle() {
        this.fullscreen = !this.fullscreen

        if (this.fullscreen) {
            this.boardTarget.classList.add("fullscreen-mode")
            this.buttonTarget.textContent = "Mały ekran"
        } else {
            this.boardTarget.classList.remove("fullscreen-mode")
            this.buttonTarget.textContent = "Pełny ekran"
        }
    }
}
