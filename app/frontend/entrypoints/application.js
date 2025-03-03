// app/frontend/entrypoints/application.js
console.log('Vite ⚡️ Rails');

// Entry point for the build
import '@hotwired/turbo-rails';
import { Application } from '@hotwired/stimulus';

// Import Tailwind CSS
import '../styles/application.css';

// Import all the channels for Action Cable
// import './channels'

// Initialize Stimulus controller registry
const application = Application.start();

// Configure Stimulus development experience
application.debug = false;
window.Stimulus = application;

export { application };
