import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["element"];

  connect() {
    if (window.innerWidth <= 768) {
      this.text = "The best career advice for engineers \<br> comes from engineers";
    } else {
      this.text = "The best career advice for engineers       comes from engineers";
    }

    // if (window.innerWidth <= 768) {
    //   this.text = "エンジニアのキャリア相談は \<br> エンジニアへ";
    // } else {
    //   this.text = "エンジニアのキャリア相談は       エンジニアへ";
    // }

    this.index = 0;
    this.typingInterval = setInterval(this.type.bind(this), 100);
    this.blinkInterval = setInterval(this.blink.bind(this), 500);
  }

  disconnect() {
    clearInterval(this.typingInterval);
    clearInterval(this.blinkInterval);
    this.elementTarget.textContent = this.text;
  }

  type() {
    if (this.index <= this.text.length) {
      this.elementTarget.innerHTML =
        this.text.slice(0, this.index++) +
        '<span class="cursor">|</span>';
    } else {
      clearInterval(this.typingInterval);
      this.elementTarget.innerHTML =
        this.text + '<span class="cursor">|</span>';
    }
  }

  blink() {
    const cursor = this.elementTarget.querySelector(".cursor");
    if (cursor.style.opacity === "0") {
      cursor.style.opacity = "1";
    } else {
      cursor.style.opacity = "0";
    }
  }
}
