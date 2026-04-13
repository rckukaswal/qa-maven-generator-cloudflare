function copyCommand() {
  const text = document.getElementById("curlCmd").innerText;
  navigator.clipboard.writeText(text);
  alert("Command copied successfully!");
}