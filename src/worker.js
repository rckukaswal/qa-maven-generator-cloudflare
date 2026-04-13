import html from "../site/index.html";
import css from "../site/style.css";
import js from "../site/app.js";

export default {
  async fetch(request) {
    const url = new URL(request.url);

    // Home page
    if (url.pathname === "/") {
      return new Response(html, {
        headers: {
          "content-type": "text/html; charset=UTF-8"
        }
      });
    }

    // CSS
    if (url.pathname === "/style.css") {
      return new Response(css, {
        headers: {
          "content-type": "text/css"
        }
      });
    }

    // JS
    if (url.pathname === "/app.js") {
      return new Response(js, {
        headers: {
          "content-type": "application/javascript"
        }
      });
    }

    // IMPORTANT: Bash install route untouched
    if (url.pathname === "/bash/install.sh") {
      const script = `#!/bin/bash
set -e

echo "Installing QA Maven Generator..."
mkdir -p ~/qa-maven-generator
cd ~/qa-maven-generator

curl -fsSL https://raw.githubusercontent.com/rckukaswal/qa-maven-generator/main/bash/install.sh -o install.sh

chmod +x install.sh
./install.sh

echo "Installation completed successfully."
`;
      return new Response(script, {
        headers: {
          "content-type": "text/plain",
          "cache-control": "no-store"
        }
      });
    }

    return new Response("404 Not Found", { status: 404 });
  }
}