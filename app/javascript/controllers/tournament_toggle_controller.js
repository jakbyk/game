import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["tournamentFieldsOver", "tournamentFieldsBelow"]

    connect(){
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

    setRequiredFields(){
        console.log("setRequiredFields start");
        if(this.tournamentFieldsOverTarget.classList.contains("is-hidden")){
            this.tournamentFieldsOverTarget.querySelectorAll("input, textarea, select").forEach((field) => {
                console.log("fjdsuifghusd");
                console.log(field);
                field.removeAttribute("required")
            })
        }
        else {
            this.tournamentFieldsOverTarget.querySelectorAll("input, textarea, select").forEach((field) => {
                field.setAttribute("required", "required")
            })
        }
        if(this.tournamentFieldsBelowTarget.classList.contains("is-hidden")){
            this.tournamentFieldsBelowTarget.querySelectorAll("input, textarea, select").forEach((field) => {
                console.log("fjdsuifghusd");
                field.removeAttribute("required")
            })
        }
        else {
            this.tournamentFieldsBelowTarget.querySelectorAll("input, textarea, select").forEach((field) => {
                field.setAttribute("required", "required")
            })
        }
        console.log("setRequiredFields end");
    }
}
