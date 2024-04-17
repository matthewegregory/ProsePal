// import { Controller } from "stimulus";

// export default class extends Controller {
//   static targets = ["container"];

//   connect() {
//     // Subscribe to Turbo Streams events
//     this.element.addEventListener("turbo:stream:received", this.handleStreamReceived.bind(this));
//   }

//   handleStreamReceived(event) {
//     const stream = event.detail.stream;
//     const newPostHTML = stream.getInnerHTML();

//     // Append the new post HTML to the container element
//     this.containerTarget.insertAdjacentHTML("beforeend", newPostHTML);
//   }
// }
