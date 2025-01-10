import { a_element_selector, a_css_query } from "./tools.js";

function a_select(id) {
  const elem = a_element_selector("Select", id);

  return {
    onSelect: (fn) => {
        elem().addEventListener("change", () => {
        fn(a_select(id));
      });
    },
    value: () => {
      return elem().value;
    },
    setValue: (newValue) => {
        elem().value = newValue;
    },

    setOptions: (options) => {
      const e = elem();
      e.innerHTML = "";

      options.forEach(item => {
        const option = document.createElement("option");
        option.value = item.value;
        option.textContent = item.title;
        e.appendChild(option);
      });
    }
  };
};

export { a_select };
