import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['form', 'submit'];

  connect() {
    this.formTarget.addEventListener('submit', this.handleSubmit.bind(this));
  }

  handleSubmit(event) {
    if (!this.formTarget.checkValidity()) {
      event.preventDefault();
      this.formTarget.reportValidity();
    } else {
      this.submitTarget.disabled = true;
      this.submitTarget.innerHTML = `
        <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white inline-block" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
          <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
          <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
        </svg>
        Sending...
      `;
    }
  }
}
