import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['submit'];

  connect() {
    this.submitTarget.addEventListener('click', this.handleSubmit.bind(this));
  }

  disconnect() {
    this.submitTarget.removeEventListener(
      'click',
      this.handleSubmit.bind(this)
    );
  }

  handleSubmit(event) {
    event.preventDefault();

    const form = event.target.closest('form');
    const formData = new FormData(form);

    this.submitTarget.disabled = true;
    this.submitTarget.textContent = 'Sending...';

    fetch(form.action, {
      method: 'POST',
      body: formData,
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')
          .content,
      },
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.success) {
          this.showSuccess();
          form.reset();
        } else {
          this.showError(data.message);
        }
      })
      .catch((error) => {
        this.showError('An error occurred. Please try again.');
      })
      .finally(() => {
        this.submitTarget.disabled = false;
        this.submitTarget.textContent = 'Send Message';
      });
  }

  showSuccess() {
    const successMessage = document.createElement('div');
    successMessage.className =
      'mt-4 p-4 bg-green-100 text-green-700 rounded-md';
    successMessage.textContent =
      "Thank you for your message! I'll get back to you soon.";

    this.element.insertAdjacentElement('beforebegin', successMessage);

    setTimeout(() => {
      successMessage.remove();
    }, 5000);
  }

  showError(message) {
    const errorMessage = document.createElement('div');
    errorMessage.className = 'mt-4 p-4 bg-red-100 text-red-700 rounded-md';
    errorMessage.textContent = message;

    this.element.insertAdjacentElement('beforebegin', errorMessage);

    setTimeout(() => {
      errorMessage.remove();
    }, 5000);
  }
}
