import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  search(event) {
    const query = this.inputTarget.value

    if (query.length < 3) return

    fetch(`https://api-adresse.data.gouv.fr/search/?q=${encodeURIComponent(query)}&limit=5`)
      .then(response => response.json())
      .then(data => {
        this.showSuggestions(data.features.map(f => f.properties.label))
      })
  }

  showSuggestions(suggestions) {
    let datalistId = this.inputTarget.getAttribute("list")
    if (!datalistId) {
      datalistId = "address-options"
      this.inputTarget.setAttribute("list", datalistId)
    }

    let datalist = document.getElementById(datalistId)
    if (!datalist) {
      datalist = document.createElement("datalist")
      datalist.id = datalistId
      document.body.appendChild(datalist)
    }

    datalist.innerHTML = ""
    suggestions.forEach(suggestion => {
      const option = document.createElement("option")
      option.value = suggestion
      datalist.appendChild(option)
    })
  }
}
