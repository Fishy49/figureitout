module.exports = {
  purge: {
    enabled: false,
    content: ["views/*.erb"],
  },
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [require("@tailwindcss/ui")],
};
