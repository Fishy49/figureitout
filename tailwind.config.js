module.exports = {
  purge: {
    enabled: true,
    content: ["views/*.erb"],
  },
  theme: {
    extend: {},
  },
  variants: {},
  plugins: [require("@tailwindcss/ui")],
};
