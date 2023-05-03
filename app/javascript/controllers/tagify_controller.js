import { Controller } from "@hotwired/stimulus";
import Tagify from "@yaireo/tagify";

export default class extends Controller {
  static targets = ["tagify", "tagNames"];

  connect() {
    const whitelist = this.element.getAttribute("data-whitelist").split(",");
    this.tagify = new Tagify(this.tagifyTarget, {
      whitelist: whitelist,
      maxTags: 10,
      dropdown: {
        classname: "tags-look",
        enabled: 0,
        maxItems: 20,
        closeOnSelect: false,
      },
    });

    this.tagify.on("add", (e) => {
      this.saveTagNames(e.detail.tagify);
      this.updateDropdownItems();
    });

    this.tagify.on("remove", (e) => {
      this.saveTagNames(e.detail.tagify);
      this.updateDropdownItems();
    });

    this.tagify.on('invalid', e => this.handleInvalidTag(e.detail));

  }

  saveTagNames(tagify) {
    this.tagNamesTarget.value = tagify.value.map((v) => v.value);
  }

  updateDropdownItems() {
    const currentTags = this.tagify.value.map((v) => v.value);
    const updatedWhitelist = this.element
      .getAttribute("data-whitelist")
      .split(",")
      .filter((tag) => !currentTags.includes(tag));
    this.tagify.settings.whitelist = updatedWhitelist;
    this.tagify.dropdown.show.call(this.tagify, this.tagify.input.value);
  }

  handleInvalidTag(detail) {
    if (detail.message === 'number of tags exceeded') {
      this.showToast('タグは最大10個までです');
    }
  }

  showToast(message) {
    const toastElement = document.createElement('div');
    toastElement.classList.add('toast', 'border', 'rounded-3', 'bg-white', 'text-dark');
    toastElement.setAttribute('data-controller', 'toast');
    toastElement.setAttribute('role', 'alert');
    toastElement.setAttribute('aria-live', 'assertive');
    toastElement.setAttribute('aria-atomic', 'true');
    toastElement.style.position = 'fixed';
    toastElement.style.top = '2rem';
    toastElement.style.right = '1rem';
    toastElement.style.zIndex = '999999999';

    const toastBody = document.createElement('div');
    toastBody.classList.add('toast-body', 'd-flex');
    toastBody.innerHTML = `
      <i class="bi bi-info-circle-fill text-muted me-2"></i>
      <strong class="text-gray-dark" style="color: #5b5d5f;">${message}</strong>
      <button class="btn-close me-1 m-auto" type="button" aria-label="閉じる" data-bs-dismiss="toast"></button>`;
    toastElement.appendChild(toastBody);

    document.body.appendChild(toastElement);
    const toastInstance = new bootstrap.Toast(toastElement);
    toastInstance.show();

    setTimeout(() => {
      document.body.removeChild(toastElement);
    }, 5000);
  }

  disconnect() {
    this.tagify.removeAllTags();
    const classes = this.element.getElementsByClassName("tagify");
    Array.from(classes).forEach((e) => e.remove());
  }
}
