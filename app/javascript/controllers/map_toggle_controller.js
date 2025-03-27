import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["map", "grid", "search"];

  connect() {
    console.log("Coucou");
    this.toggleMap();
  }

  toggleMap() {
    console.log("Toggle OK");
    const showMap = this.element.querySelector("#toggle-map").checked;
    console.log("état du toggle :", showMap);

    if (showMap) {

      this.mapTarget.style.display = "block";
      this.gridTarget.style.gridTemplateColumns = "1fr 1fr";
      this.searchTarget.style.gridColumn = "span 2";
    } else {
      this.mapTarget.style.display = "none";
      this.gridTarget.style.gridTemplateColumns = "1fr 1fr 1fr";
      this.searchTarget.style.gridColumn = "span 1";
    }
  }
}
