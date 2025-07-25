import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        this.ping()
        this.timer = setInterval(() => this.ping(), 10000)
        this.setVh();
        window.addEventListener('resize', () => this.setVh());
    }

    disconnect() {
        clearInterval(this.timer)
    }

    ping() {
        fetch("/ping", { method: "POST", headers: { "X-CSRF-Token": document.querySelector("[name='csrf-token']").content } })
    }

    setVh() {
        const vh = window.innerHeight * 0.01;
        document.documentElement.style.setProperty('--vh', `${vh}px`);
    }
}