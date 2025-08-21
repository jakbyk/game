import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["description", "event"]

    toggle() {
        if(this.descriptionTarget.classList.contains("is-hidden")){
            this.descriptionTarget.classList.remove("is-hidden");
            this.eventTarget.style.cursor = "default";
        }
    }
}
