import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["textarea"]

    format(event) {
        event.preventDefault()
        const formatType = event.currentTarget.dataset.format
        const textarea = this.textareaTarget

        const start = textarea.selectionStart
        const end = textarea.selectionEnd
        const selectedText = textarea.value.substring(start, end)

        let before = ""
        let after = ""

        switch (formatType) {
            case "bold":
                before = "**"
                after = "**"
                break
            case "italic":
                before = "_"
                after = "_"
                break
            case "strikethrough":
                before = "~~"
                after = "~~"
                break
        }

        if (start === end) {
            textarea.setRangeText(before + after, start, end, "end")
            textarea.selectionStart = textarea.selectionEnd = start + before.length
        } else {
            const newText = before + selectedText + after
            textarea.setRangeText(newText, start, end, "end")
            textarea.selectionStart = start
            textarea.selectionEnd = start + newText.length
        }

        textarea.focus()
    }
}
