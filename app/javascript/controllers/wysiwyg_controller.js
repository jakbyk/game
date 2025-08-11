import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["editor", "textarea", "fileInput", "formatButton"]

    connect() {
        this.editorTarget.innerHTML = this.textareaTarget.value || ""
        if (this.editorTarget.dataset.upload === "big") {
            this.fileInputTarget.addEventListener("change", this.uploadImage.bind(this))
        } else {
            this.fileInputTarget.addEventListener("change", this.uploadSmallImage.bind(this))
        }

        document.addEventListener("selectionchange", this.updateFormattingButtons.bind(this))
        this.editorTarget.addEventListener("input", (event) => this.sync())
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

        fetch("/images", {
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

    uploadSmallImage(event) {
        const file = event.target.files[0]
        if (!file) return

        const maxWidth = 680
        const maxHeight = 320

        const reader = new FileReader()
        reader.onload = (readerEvent) => {
            const img = new Image()
            img.onload = () => {
                let {width, height} = img

                if (width > maxWidth || height > maxHeight) {
                    const aspectRatio = width / height
                    if (width > height) {
                        width = maxWidth
                        height = Math.round(maxWidth / aspectRatio)
                    } else {
                        height = maxHeight
                        width = Math.round(maxHeight * aspectRatio)
                    }
                }

                const canvas = document.createElement("canvas")
                canvas.width = width
                canvas.height = height
                const ctx = canvas.getContext("2d")
                ctx.drawImage(img, 0, 0, width, height)

                canvas.toBlob((blob) => {
                    const formData = new FormData()
                    formData.append("image[file]", blob, file.name)

                    fetch("/images", {
                        method: "POST",
                        headers: {
                            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
                        },
                        body: formData
                    })
                        .then(response => response.json())
                        .then(data => {
                            if (data.url) {
                                document.execCommand(
                                    'insertHTML',
                                    false,
                                    `<div style="display: flex; justify-content: center; align-items: center; max-width: 100%; overflow: hidden;"><img src="${data.url}" alt="Uploaded Image" style="max-width: 100%; max-height: 100%; height: auto; display: block;" /></div>`
                                )
                                this.sync()
                            } else {
                                alert("Błąd uploadu obrazka")
                            }
                        })
                        .catch(() => alert("Błąd uploadu obrazka"))
                }, file.type, 0.9) // type and quality
            }
            img.src = readerEvent.target.result
        }
        reader.readAsDataURL(file)
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
