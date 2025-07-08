import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "preview", "submit"]

    preview(event) {
        event.preventDefault();

        const input = this.inputTarget
        const file = input.files[0]

        if (file && file.type.startsWith("image/")) {
            const reader = new FileReader()

            reader.onload = (e) => {
                const figure = document.createElement("figure")
                figure.className = "image is-128x128"
                const img = document.createElement("img")
                img.src = e.target.result
                img.className = "is-rounded"
                figure.appendChild(img)

                this.previewTarget.innerHTML = ""
                this.previewTarget.appendChild(figure)
            }

            reader.readAsDataURL(file)
            this.submitTarget.classList.remove("is-hidden")
        } else {
            this.previewTarget.innerHTML = "<p class='has-text-danger'>Nieprawidłowy plik</p>"
        }
    }
}
