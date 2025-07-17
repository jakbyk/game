import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["editor", "textarea", "fileInput", "formatButton"]

    connect() {
        // Synchronizuj przy starcie (jeśli textarea ma wartość)
        this.editorTarget.innerHTML = this.textareaTarget.value || ""
        this.fileInputTarget.addEventListener("change", this.uploadImage.bind(this))
        document.addEventListener("selectionchange", this.updateFormattingButtons.bind(this))
    }

    format(event) {
        event.preventDefault()
        const command = event.currentTarget.dataset.command

        document.execCommand(command, false, null)
        this.sync()
    }

    insertLink(event) {
        event.preventDefault()
        const text = prompt("Podaj tekst linku:")
        if (!text) return

        let url = prompt("Podaj URL (z http:// lub https://):")
        if (!url) return

        // Prosty sanityzator - dodaj http jeśli nie ma
        if (!url.match(/^https?:\/\//)) {
            url = "http://" + url
        }

        // Wstaw link w edytorze
        document.execCommand('insertHTML', false, `<a href="${url}" target="_blank" rel="noopener noreferrer">${text}</a>`)
        this.sync()
    }

    insertImage(event) {
        event.preventDefault()
        this.fileInputTarget.click()
    }

    uploadImage(event) {
        const file = event.target.files[0]
        if (!file) return

        const formData = new FormData()
        formData.append("image[file]", file)

        fetch("/images", {  // przykładowy endpoint do uploadu
            method: "POST",
            headers: {
                "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
            },
            body: formData
        })
            .then(response => response.json())
            .then(data => {
                if (data.url) {
                    document.execCommand('insertHTML', false, `<img src="${data.url}" alt="Uploaded Image" style="max-width: 100%; height: auto;" />`)
                    this.sync()
                } else {
                    alert("Błąd uploadu obrazka")
                }
            })
            .catch(() => alert("Błąd uploadu obrazka"))
    }

    updateFormattingButtons() {
        const selection = window.getSelection()

        const hasSelection =
            selection &&
            selection.rangeCount > 0 &&
            !selection.isCollapsed &&
            this.editorTarget.contains(selection.anchorNode)

        this.formatButtonTargets.forEach(button => {
            button.disabled = !hasSelection
        })
    }

    sync() {
        this.textareaTarget.value = this.editorTarget.innerHTML
    }
}
