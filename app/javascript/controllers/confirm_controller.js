import { Controller } from "@hotwired/stimulus"

// Użycie: data-controller="confirm" data-confirm-message="Czy na pewno?"
export default class extends Controller {
    static targets = ["confirm"]

    connect(){
        console.log(this.confirmTarget)
    }

    confirm(event) {
        if (!confirm(this.confirmTarget.dataset.message)) {
            event.preventDefault()
            event.stopImmediatePropagation()
        }
    }
}
