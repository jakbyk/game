import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["budgetFields", "reserveFields"]

    toggleBudget(event) {
        if (!event.target.checked) {
            if (confirm("Czy na pewno chcesz wyłączyć tą sekcję? Spowoduje to wymazanie danych w niej zawartej.")) {
                this.clearFields(this.budgetFieldsTarget)
                this.budgetFieldsTarget.classList.add("is-hidden")
            } else {
                event.target.checked = true
            }
        } else {
            this.budgetFieldsTarget.classList.remove("is-hidden")
        }
    }

    toggleReserve(event) {
        if (!event.target.checked) {
            if (confirm("Czy na pewno chcesz wyłączyć tą sekcję? Spowoduje to wymazanie danych w niej zawartej.")) {
                this.clearFields(this.reserveFieldsTarget)
                this.reserveFieldsTarget.classList.add("is-hidden")
            } else {
                event.target.checked = true
            }
        } else {
            this.reserveFieldsTarget.classList.remove("is-hidden")
        }
    }

    clearFields(section) {
        section.querySelectorAll("input, textarea, select").forEach((field) => {
            if (field.type === "number") {
                field.value = 0
            } else if (field.type === "checkbox" || field.type === "radio") {
                field.checked = false
            } else {
                field.value = ""
            }
        })
    }
}
