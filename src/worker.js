export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    if (url.pathname === "/bash/install.sh") {
      return fetch("https://raw.githubusercontent.com/rckukaswal/qa-maven-generator-cloudflare/main/bash/install.sh");
    }

    // Baaki sab assets se serve karo
    return env.ASSETS.fetch(request);
  }
};
