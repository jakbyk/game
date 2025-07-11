import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["id", "name", "email"]

    connect() {
        this.element.addEventListener("submit", this.validate.bind(this))
    }

    validate(event) {
        let id = this.idTarget.value.trim()
        if(id === "0"){ id = undefined }
        const name = this.nameTarget.value.trim()
        const email = this.emailTarget.value.trim()

        if ((id && name) || (id && email) || (name && email)) {
            event.preventDefault()
            alert("Wypełnij tylko jedno pole.")
        } else if (!id && !name && !email) {
            event.preventDefault()
            alert("Musisz wypełnić jedno pole: znajomy, imię, email.")
        }
    }
}
