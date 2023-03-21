import { Controller } from "@hotwired/stimulus"
import Tagify from "@yaireo/tagify"

// tagify_controller.js
export default class extends Controller {
  static targets = [ "tagify", "tagNames" ]
  connect() {
    const whitelist = this.element.getAttribute('data-whitelist').split(',')
    this.tagify = new Tagify(this.tagifyTarget, {
      whitelist: whitelist,
      maxTags: 5,
      dropdown: {
        classname: "color-blue",
        enabled: 0,
        maxItems: 30,
        closeOnSelect: false,
        highlightFirst: true,
      },
    })
    this.tagify.on('add', e => this.saveTagNames(e.detail.tagify))
    this.tagify.on('remove', e => this.saveTagNames(e.detail.tagify))

    const tagNamesStr = this.tagNamesTarget.value
    if (tagNamesStr.length > 0) {
      this.tagify.addTags(tagNamesStr.split(','))
    }
  }

  saveTagNames(tagify) {
    this.tagNamesTarget.value = tagify.value.map(v => v.value)
  }

  disconnect() {
    this.tagify.removeAllTags()
    const classes = this.element.getElementsByClassName('tagify')
    Array.from(classes).forEach(e => e.remove())
  }
}
