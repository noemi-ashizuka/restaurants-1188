import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="insert-in-list"
export default class extends Controller {
  static targets = ["list"]
  connect() {
    // console.log(this.element); // this is the whole div where the controller is
    // console.log(this.listTarget);
    // console.log(this.formTarget);
  }

  send(event) {
    event.preventDefault();
    // console.log("TODO: send request in AJAX");
    // send post request to rails
    const form = event.target
    const url = form.action
    // console.log(form)
    fetch(url, {
      method: "POST",
      headers: { "Accept": "application/json"},
      body: new FormData(form)
    })
    .then(response => response.json())
    .then((data) => {
      // accept a json response
      console.log(data);
      // display the json response
      if(data.review_html) {
        this.listTarget.insertAdjacentHTML('afterbegin', data.review_html)
      }
      form.outerHTML = data.form_html
    })
  }
}
