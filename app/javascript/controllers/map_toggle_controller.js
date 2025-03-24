import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["map", "grid", "search"];

  connect() {
    console.log("✅ Stimulus: Contrôleur chargé !");
    this.toggleMap();
  }

  toggleMap() {
    console.log("🟡 Toggle détecté !");
    const showMap = this.element.querySelector("#toggle-map").checked;
    console.log("🔍 L’état du toggle :", showMap);

    if (showMap) {
      this.mapTarget.style.display = "block";
      this.gridTarget.style.gridTemplateColumns = "1fr 1fr";
      this.searchTarget.style.gridColumn = "span 2";
      console.log("📌 Map affichée, grille en 2 colonnes.");
    } else {
      this.mapTarget.style.display = "none";
      this.gridTarget.style.gridTemplateColumns = "1fr 1fr 1fr";
      this.searchTarget.style.gridColumn = "span 1";
      console.log("📌 Map cachée, grille en 3 colonnes.");
    }
  }
}
