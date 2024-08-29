import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["authorFilter"]

  filter() {
    const filter_type = this.authorFilterTarget.getAttribute("data-type");
    const filter_val = this.authorFilterTarget.value;
    location.href = `<%= metadatas_path %>?filter_type=${filter_type}&filter_val=${filter_val}`;
    // viewからmetadatas_pathをもらって次回は表示させるところからスタート。
  }
}
