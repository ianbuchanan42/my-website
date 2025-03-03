/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    './app/views/**/*.{erb,haml,html,slim}',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js',
    './app/frontend/**/*.{js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
