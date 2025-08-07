import {Controller} from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["map", "wrapper", "event", "newsColumn"]

    connect() {
        fetch(this.mapTarget.dataset.src)
            .then(r => r.text())
            .then(svgText => {
                const gameId = this.mapTarget.dataset.gameId;
                const activeId = this.mapTarget.dataset.activeId;
                const json = this.mapTarget.dataset.regions
                    .replace(/:(\w+)/g, '"$1"')
                    .replace(/=>/g, ':');
                const regionsList = JSON.parse(json);
                this.wrapperTarget.innerHTML = svgText;
                const raw = this.mapTarget.dataset.regions;
                const pairs = [...raw.matchAll(/:([A-Z]+\d+)\s*=>\s*"([^"]+)"/g)];

                const voivodeships = Object.fromEntries(
                    pairs.map(([, code, name]) => [code, name])
                );

                document.querySelectorAll("#map svg [name]").forEach(path => {
                    path.classList.add("region");
                    path.classList.add(path.id);

                    if (path.getAttribute("id") === activeId) {
                        path.classList.add("active");
                    }

                    path.addEventListener("mouseenter", (e) => {
                        const id = path.getAttribute("id");
                        tooltip.textContent = regionsList[id] || "Nieznany region";
                        tooltip.style.opacity = 1;
                    });

                    path.addEventListener("mousemove", (e) => {
                        tooltip.style.left = `${e.clientX + 10}px`;
                        tooltip.style.top = `${e.clientY + 10}px`;
                    });

                    path.addEventListener("mouseleave", () => {
                        tooltip.style.opacity = 0;
                    });

                    path.addEventListener("click", () => {
                        const myId = path.getAttribute("id");
                        const myName = path.getAttribute("name");
                        Turbo.visit("?map_id=" + myId);
                    });
                });
                this.eventTargets.forEach(box => {
                    if (box.dataset.regionId){
                        box.addEventListener("mouseenter", () => {
                            document.querySelector(`#map svg #${box.dataset.regionId}`).classList.add('active');
                        });

                        box.addEventListener("mouseleave", () => {
                            document.querySelector(`#map svg #${box.dataset.regionId}`).classList.remove('active');
                        });
                    }
                })
                this.setNewsColumnHeight();
                window.addEventListener("resize", () => this.setNewsColumnHeight());
                document.querySelectorAll('a.resize-button').forEach(button => {
                    button.addEventListener("click", () =>{
                        this.setNewsColumnHeight();
                    })
                })
            })
            .catch(err => console.error("Nie można załadować mapy:", err));
    }

    setNewsColumnHeight() {
        if (!this.hasWrapperTarget || !this.hasNewsColumnTarget) return

        let mapHeight = this.wrapperTarget.offsetHeight
        if (document.querySelector('#inner-window').offsetHeight > this.wrapperTarget.offsetHeight){
            mapHeight = document.querySelector('#inner-window').offsetHeight
        }
        if(mapHeight > 700){
            mapHeight = 700
        }

        this.newsColumnTarget.style.maxHeight = `${mapHeight}px`
        this.newsColumnTarget.style.overflowY = "auto"
    }
}