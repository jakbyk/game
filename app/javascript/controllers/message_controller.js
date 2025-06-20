import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["content", "menu"]
    static values = { authorId: Number }

    connect() {
        if (window.currentUserId !== this.authorIdValue && window.isAdmin === false) {
            this.menuTarget.classList.add("is-hidden")
        }
    }

    async edit(event) {
        const id = event.target.dataset.messageId
        const chatId = event.target.dataset.chatId
        const response = await fetch(`/chats/${chatId}/messages/${id}/edit`, {
            headers: { Accept: "text/vnd.turbo-stream.html" }
        })
        if (response.ok) {
            const html = await response.text()
            Turbo.renderStreamMessage(html)
        }
    }

    async delete(event) {
        const id = event.target.dataset.messageId
        const chatId = event.target.dataset.chatId
        const confirmed = confirm("Czy na pewno chcesz usunąć tą wiadomość?")
        if (!confirmed) return

        await fetch(`/chats/${chatId}/messages/${id}`, {
            method: "DELETE",
            headers: {
                "Accept": "text/vnd.turbo-stream.html",
                "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
            },
            credentials: "same-origin"
        })
    }
}
