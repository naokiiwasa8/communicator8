import { Controller } from "@hotwired/stimulus"
import Tagify from "@yaireo/tagify"

export default class extends Controller {
  static targets = ["tagify", "tagNames"]

  connect() {
    const whitelist = this.element.getAttribute('data-whitelist').split(',')
    this.tagify = new Tagify(this.tagifyTarget, {
      whitelist: whitelist,
      maxTags: 10,
      dropdown: {
        classname: "tags-look",
        enabled: 0,
        maxItems: 20,
        closeOnSelect: false,
      },
    })

    this.tagify.on('add', e => this.saveTagNames(e.detail.tagify))
    this.tagify.on('remove', e => this.saveTagNames(e.detail.tagify))
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
