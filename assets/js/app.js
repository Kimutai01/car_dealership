// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).
import "../css/app.css";

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html";
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "../vendor/topbar";

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (info) => topbar.show());
window.addEventListener("phx:page-loading-stop", (info) => topbar.hide());

// connect if there are any LiveViews on the pag

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;

// assets/js/app.js

let Hooks = {};

Hooks.Swiper = {
  mounted() {
    const swiper = new Swiper(".swiper", {
      // Optional parameters
      direction: "horizontal",
      loop: true,
      autoplay: {
        delay: 5000, // Autoplay delay in milliseconds (5 seconds in this example)
      },

      // If we need pagination

      // Navigation arrows

      // Responsive breakpoints
      breakpoints: {
        // when window width is >= 768px (desktop)
        768: {
          slidesPerView: 1,
        },
        // when window width is < 768px (mobile)
        0: {
          slidesPerView: 1,
        },
      },
    });
  },
};

Hooks.BlogSwiper = {
  mounted() {
    const swiper = new Swiper(".blogswiper", {
      // Optional parameters
      direction: "horizontal",
      loop: true,
      autoplay: {
        delay: 5000, // Autoplay delay in milliseconds (5 seconds in this example)
      },

      // If we need pagination

      // Navigation arrows

      // Responsive breakpoints
      breakpoints: {
        // when window width is >= 768px (desktop)
        768: {
          slidesPerView: 2,
        },
        // when window width is < 768px (mobile)
        0: {},
      },
    });
  },
};

Hooks.Blog1Swiper = {
  mounted() {
    const swiper = new Swiper(".blogswiper1", {
      // Optional parameters
      direction: "horizontal",
      loop: true,
      autoplay: {
        delay: 5000, // Autoplay delay in milliseconds (5 seconds in this example)
      },

      // If we need pagination

      // Navigation arrows

      // Responsive breakpoints
      breakpoints: {
        // when window width is >= 768px (desktop)
        768: {
          slidesPerView: 2,
        },
        // when window width is < 768px (mobile)
        0: {},
      },
    });
  },
};

Hooks.Scroll = {
  mounted() {
    const navigation = document.querySelector(".transparent");
    const windowHeight = window.innerHeight;

    function handleScroll() {
      const scrollTop = window.scrollY;

      const opacity = Math.min(scrollTop / windowHeight, 1);
      navigation.style.backgroundColor = `rgba(0, 0, 0, ${opacity})`;
    }

    // Attach scroll event listener
    window.addEventListener("scroll", handleScroll);
  },
};
Hooks.Map = {
  mounted() {
    // ADD YOUR ACCESS TOKEN FROM
    // https://account.mapbox.com
    mapboxgl.accessToken =
      "pk.eyJ1IjoiYW5uZXRvdG9oIiwiYSI6ImNsYjB2cDl1dzFrOTQzcHFtOWdxcHBjbGgifQ.LADz9TYffPhRsjZ_O_hUHw";
    const map = new mapboxgl.Map({
      container: "map", // container ID
      // Choose from Mapbox's core styles, or make your own style with Mapbox Studio
      style: "mapbox://styles/mapbox/streets-v12", // style URL
      center: [36.811667, -1.266944], // starting position [lng, lat]
      zoom: 9, // starting zoom
    });

    // Add a marker to the map
    new mapboxgl.Marker()
      .setLngLat([36.811667, -1.266944]) // marker position [lng, lat]
      .addTo(map);
  },
  updated() {
    // ADD YOUR ACCESS TOKEN FROM
    // https://account.mapbox.com
    mapboxgl.accessToken =
      "pk.eyJ1IjoiYW5uZXRvdG9oIiwiYSI6ImNsYjB2cDl1dzFrOTQzcHFtOWdxcHBjbGgifQ.LADz9TYffPhRsjZ_O_hUHw";
    const map = new mapboxgl.Map({
      container: "map", // container ID
      // Choose from Mapbox's core styles, or make your own style with Mapbox Studio
      style: "mapbox://styles/mapbox/streets-v12", // style URL
      center: [-74.5, 40], // starting position [lng, lat]
      zoom: 9, // starting zoom
    });

    // Add a marker to the map
    new mapboxgl.Marker()
      .setLngLat([-74.5, 40]) // marker position [lng, lat]
      .addTo(map);
  },
};

Hooks.NavScroll = {
  mounted() {
    const navigation = document.querySelector(".navtransparent");
    const windowHeight = window.innerHeight;

    function handleScroll() {
      const scrollTop = window.scrollY;

      const opacity = Math.min(scrollTop / windowHeight, 1);
      navigation.style.backgroundColor = `rgba(0, 0, 0, ${opacity})`;
    }

    // Attach scroll event listener
    window.addEventListener("scroll", handleScroll);
  },
};

Hooks.Navbar = {
  mounted() {
    const toggleButton = document.getElementById("toggleButton");
    const sidebar = document.getElementById("sidebar");

    toggleButton.addEventListener("click", () => {
      sidebar.classList.toggle("-translate-x-full");
    });

    document.getElementById("sidebarContent").addEventListener("click", () => {
      sidebar.classList.toggle("-translate-x-full");
    });
  },
};

// };

// Hooks.Editor = {
//   mounted() {
//     // Wait for the DOM to be fully loaded
//     const markdownElement = document.querySelector(".markdown");

//     //   ClassicEditor.create(document.querySelector(".markdown"), {
//     //     toolbar: [
//     //       "heading",
//     //       "|",
//     //       "bold",
//     //       "italic",
//     //       "link",
//     //       "bulletedList",
//     //       "numberedList",
//     //       "blockQuote",
//     //       "undo",
//     //       "redo",
//     //     ],
//     //   })
//     //     .then((editor) => {
//     //       window.editor = editor;
//     //     })
//     //     .catch((error) => {
//     //       console.error("Oops, something went wrong!");
//     //       console.error("Please, report the following error on");
//     //       console.error(error);
//     //     });
//     // });
//   },
// };

let liveSocket = new LiveSocket("/live", Socket, {
  hooks: Hooks,
  params: { _csrf_token: csrfToken },
});

liveSocket.connect();
