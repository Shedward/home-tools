import { a_element_selector, a_css_query } from "./tools.js";

function a_select(id) {
  const selectElem = a_element_selector("Select", id);

  return {
    onSelect: (fn) => {
      selectElem().addEventListener("change", () => {
        fn(a_select(id));
      });
    },
    value: () => {
      return selectElem().value;
    },
    setValue: (newValue) => {
      selectElem().value = newValue;
    }
  };
};

export { a_select };