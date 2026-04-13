function copyCommand() {
  const text = document.getElementById("curlCmd").innerText;
  const btn = document.querySelector(".copy-btn");
  const iconCopy = document.getElementById("icon-copy");
  const iconCheck = document.getElementById("icon-check");

  navigator.clipboard.writeText(text).then(() => {
    btn.classList.add("copied");
    iconCopy.style.display = "none";
    iconCheck.style.display = "block";

    setTimeout(() => {
      btn.classList.remove("copied");
      iconCopy.style.display = "block";
      iconCheck.style.display = "none";
    }, 2000);
  });
}
