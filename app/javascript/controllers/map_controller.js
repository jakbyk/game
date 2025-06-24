import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["map", "wrapper"]

    connect(){
        fetch(this.mapTarget.dataset.src)
            .then(r => r.text())
            .then(svgText => {
                const gameId = this.mapTarget.dataset.gameId;
                this.wrapperTarget.innerHTML = svgText;
                const raw = this.mapTarget.dataset.regions;
                const pairs = [...raw.matchAll(/:([A-Z]+\d+)\s*=>\s*"([^"]+)"/g)];

                const voivodeships = Object.fromEntries(
                    pairs.map(([, code, name]) => [code, name])
                );

                document.querySelectorAll("#map svg [name]").forEach(path => {
                    path.classList.add("region");

                    path.addEventListener("click", () => {
                        const myId = path.getAttribute("id");
                        const myName = path.getAttribute("name");
                        Turbo.visit("?map_id=" + myId);
                    });
                });
            })
            .catch(err => console.error("Nie można załadować mapy:", err));
    }
}