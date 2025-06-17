import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["textarea"]

    connect() {
        console.log("✅ chat-form controller connected")
    }

    keydown(e) {
        if (e.key === "Enter" && !e.shiftKey) {
            e.preventDefault()
            this.element.requestSubmit()        // triggers Turbo form submit
        }
    }

    // Fires after Turbo receives the server response
    clear(e) {
        if (e.detail.success) {
            this.textareaTarget.value = ""
        }
    }
}
