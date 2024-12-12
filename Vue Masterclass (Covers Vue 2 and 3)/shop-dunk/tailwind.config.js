/** @type {import('tailwindcss').Config} */
import defaultTheme from 'tailwindcss/defaultTheme'

export default {
  content: ['./index.html', './src/**/*.{vue,js,ts}'],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Arimo', ...defaultTheme.fontFamily.sans],
      },
    },
    screens: {
      sm: '0px',
      md: '767px',
      lg: '1001px',
      xl: '1201px',
    },
  },
  plugins: [],
}
