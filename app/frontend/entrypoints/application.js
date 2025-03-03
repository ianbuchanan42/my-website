// app/frontend/entrypoints/application.js
console.log('Vite ⚡️ Rails');

// Entry point for the build
import '@hotwired/turbo-rails';
import { Application } from '@hotwired/stimulus';

// Initialize Stimulus controller registry
const application = Application.start();

// Configure Stimulus development experience
application.debug = false;

export { application };
