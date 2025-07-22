import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["container"]

    connect() {
        this.index = this.containerTarget.children.length
    }

    add(event) {
        event.preventDefault()

        const template = `
      <div class="box mb-4">
        <div class="field">
          <label for="setting_social_satisfaction_levels_${this.index}_threshold">Próg</label>
          <input class="input" type="number" name="setting[social_satisfaction_levels][${this.index}][threshold]" id="setting_social_satisfaction_levels_${this.index}_threshold" />
        </div>
        <div class="field">
          <label for="setting_social_satisfaction_levels_${this.index}_text">Opis (HTML)</label>
          <textarea class="textarea" name="setting[social_satisfaction_levels][${this.index}][text]" id="setting_social_satisfaction_levels_${this.index}_text"></textarea>
        </div>
        <button type="button" class="button is-danger is-light mt-2" data-action="thresholds#remove">Usuń ten próg</button>
      </div>
    `
        this.containerTarget.insertAdjacentHTML("beforeend", template)
        this.index++
    }

    remove(event) {
        event.preventDefault()
        event.target.closest(".box").remove()
    }
}
