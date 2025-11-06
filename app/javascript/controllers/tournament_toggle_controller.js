import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["tournamentFieldsOver", "tournamentFieldsBelow"]

    connect() {
        this.setRequiredFields()
    }

    toggleTournament(event) {
        if (event.target.checked) {
            this.clearFields(this.tournamentFieldsBelowTarget)
            this.tournamentFieldsOverTarget.classList.remove("is-hidden")
            this.tournamentFieldsBelowTarget.classList.add("is-hidden")
        } else {
            this.clearFields(this.tournamentFieldsOverTarget)
            this.tournamentFieldsOverTarget.classList.add("is-hidden")
            this.tournamentFieldsBelowTarget.classList.remove("is-hidden")
        }
        this.setRequiredFields()
    }

    clearFields(section) {
        if (!section) return
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

    setRequiredFields() {
        if (this.hasTournamentFieldsOverTarget) {
            let over = this.tournamentFieldsOverTarget
            over.querySelectorAll("input, textarea, select").forEach((field) => {
                if (over.classList.contains("is-hidden")) {
                    field.removeAttribute("required")
                } else {
                    field.setAttribute("required", "required")
                }
            })
        }

        if (this.hasTournamentFieldsBelowTarget) {
            let below = this.tournamentFieldsBelowTarget
            below.querySelectorAll("input, textarea, select").forEach((field) => {
                if (below.classList.contains("is-hidden")) {
                    field.removeAttribute("required")
                } else {
                    field.setAttribute("required", "required")
                }
            })
        }
    }
}
