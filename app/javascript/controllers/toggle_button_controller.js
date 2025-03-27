import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-button"
export default class extends Controller {
  static targets = ["hobbieCheckbox", "hobbieLabel"]

  connect() {
    const selectedInput = this.element.querySelector('input[type="radio"]:checked');
    console.log(selectedInput)
    if (selectedInput) {
      const selectedLabel = selectedInput.closest('label');
      if (selectedLabel) {
        selectedLabel.classList.add('mood-selected');
      }
    }
  }

  toggleHobby(event) {
    const label = event.currentTarget.closest(".hobbie-checkbox").querySelector(".hobbie-label")
    if (event.currentTarget.checked) {
      label.classList.add("hobbie-selected")
    } else {
      label.classList.remove("hobbie-selected")
    }
  }
}
