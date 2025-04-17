// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

document.addEventListener("DOMContentLoaded", function () {
  const toggleMoreBtn = document.getElementById("toggle-more");
  const moreResults = document.getElementById("more-results");

  if (toggleMoreBtn && moreResults) {
    toggleMoreBtn.addEventListener("click", () => {
      const isHidden = moreResults.style.display === "none";
      moreResults.style.display = isHidden ? "block" : "none";
      toggleMoreBtn.textContent = isHidden ? "閉じる" : "ガチャの詳細を確認する";
    });
  }
});