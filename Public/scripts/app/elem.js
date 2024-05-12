import { a_element_selector } from "./tools.js";

function a_elem(id) {
  const selectElem = a_element_selector("Element", id);

  return {
    shimmer: (isShimmering) => {
      if (isShimmering) {
        selectElem().classList.add("shimmer");
      } else {
        selectElem().classList.remove("shimmer");
      }
    },

    disabled: (isDisabled) => {
      if (isDisabled) {
        selectElem().classList.add("disabled");
      } else {
        selectElem().classList.remove("disabled");
      }
    },

    loading: (isLoading) => {
      const elem = a_elem(id);
      elem.shimmer(isLoading);
      elem.disabled(isLoading);
    }
  };
};

export { a_elem };