import {Controller} from "@hotwired/stimulus";

export default class extends Controller {
    static targets = ["menu", "button", "openIcon", "closeIcon"];

    toggle() {
        this.menuTarget.classList.toggle("is-active");
        this.openIconTarget.classList.toggle("is-hidden");
        this.closeIconTarget.classList.toggle("is-hidden");
    }
}