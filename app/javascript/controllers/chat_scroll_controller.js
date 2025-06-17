import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        console.log("✅ chat-scroll controller connected")
        this.scrollToBottom()

        // Watch for DOM changes (Turbo Stream append)
        this.observer = new MutationObserver(() => this.scrollToBottom())
        this.observer.observe(this.element, { childList: true })
    }

    disconnect() {
        this.observer.disconnect()
    }

    scrollToBottom() {
        this.element.scrollTop = this.element.scrollHeight
    }
}
