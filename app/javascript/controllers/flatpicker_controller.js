import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";
import "flatpickr/dist/l10n/fr.js";
// Connects to data-controller="flatpicker"
export default class extends Controller {
  connect() {
    console.log("flatpickerconnected")
    flatpickr(this.element,
      {locale: "fr",
        dateformat: "Z",
        enableTime: true,
        time_24hr: true,
      }
    )
  }
}
