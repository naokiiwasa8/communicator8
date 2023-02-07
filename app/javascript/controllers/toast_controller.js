import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toast"
export default class extends Controller {
  connect() {
    new bootstrap.Toast(this.element, { delay: 5000 }).show()
  }
}

// BootstrapのToastをimport
// import { Toast } from "bootstrap"

// // Connects to data-controller="toast"
// export default class extends Controller {
//   connect() {
//     // Toastを生成
//     const toast = new Toast(this.element)
//     // Toastを表示
//     toast.show()
//   }
// }