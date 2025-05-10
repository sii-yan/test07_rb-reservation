// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require rails-ujs


import Rails from "@rails/ujs"
// import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "bootstrap";
import "../stylesheets/application.scss";



Rails.start()
// Turbolinks.start()
ActiveStorage.start()


// カレンダー"flatpickr"を適用
import flatpickr from "flatpickr";
import "flatpickr/dist/flatpickr.min.css";
import { Japanese } from "flatpickr/dist/l10n/ja.js";

flatpickr("#datepicker", {
    locale: Japanese
});

document.addEventListener("DOMContentLoaded", function () {
  flatpickr(".js-picker", {
    dateFormat: "Y-m-d",
    minDate: "today",
    locale: "ja"
  });
});

// 固定headerを一定間スクロールしたら背景色を変える
document.addEventListener("DOMContentLoaded", function () {
  const navbar = document.querySelector(".Navbar--secondary"); 
  const firstView = document.querySelector(".FirstView"); 
  const recommendArea = document.querySelector(".RecommendAreaSection");

  if (!navbar || !firstView || !recommendArea) return; 

  function updateNavbarStyle() {
    const firstViewBottom = firstView.getBoundingClientRect().bottom; 
    const recommendAreaTop = recommendArea.getBoundingClientRect().top; 

    if (firstViewBottom > 0) {
      // `.FirstView` 内では背景を透明にする
      navbar.classList.remove("Navbar--secondary--scrolled");
    } else if (recommendAreaTop < window.innerHeight) {
      // `.RecommendAreaSection` 内では半透明にする
      navbar.classList.add("Navbar--secondary--scrolled");
    }
  }

  window.addEventListener("scroll", updateNavbarStyle);
  updateNavbarStyle(); // 初期表示時にも適用
});

// ファイルが選択された瞬間にプレビュー画像を更新する
document.addEventListener("DOMContentLoaded", function () {
  const fileInput = document.querySelector('input[type="file"][name="user[profile_image]"]');
  const previewImage = document.querySelector(".FileUploadArea__image");

  if (fileInput && previewImage) {
    fileInput.addEventListener("change", function (event) {
      const file = event.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function (e) {
          previewImage.src = e.target.result;
        };
        reader.readAsDataURL(file);
      }
    });
  }
});

