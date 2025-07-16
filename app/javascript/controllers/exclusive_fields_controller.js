import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["id", "name", "email", "idBox", "nameBox", "emailBox"]

    connect() {
        this.element.addEventListener("submit", this.validate.bind(this))
        this.emailTarget.addEventListener("change", (e) => {
            if (this.emailTarget.value != "") {
                this.idBoxTarget.classList.add("is-hidden")
                this.nameBoxTarget.classList.add("is-hidden")
            }
            else {
                this.idBoxTarget.classList.remove("is-hidden")
                this.nameBoxTarget.classList.remove("is-hidden")
            }
        })
        this.nameTarget.addEventListener("change", (e) => {
            if (this.nameTarget.value != "") {
                this.idBoxTarget.classList.add("is-hidden")
                this.emailBoxTarget.classList.add("is-hidden")
            }
            else {
                this.idBoxTarget.classList.remove("is-hidden")
                this.emailBoxTarget.classList.remove("is-hidden")
            }
        })
        this.idTarget.addEventListener("change", (e) => {
            if (this.idTarget.value != "0") {
                this.nameBoxTarget.classList.add("is-hidden")
                this.emailBoxTarget.classList.add("is-hidden")
            }
            else {
                this.nameBoxTarget.classList.remove("is-hidden")
                this.emailBoxTarget.classList.remove("is-hidden")
            }
        })
    }

    validate(event) {
        let id = this.idTarget.value.trim()
        if (id === "0") {
            id = undefined
        }
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
