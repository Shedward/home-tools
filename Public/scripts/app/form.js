
import { a_element_selector, a_css_query } from "./tools.js";

function a_form(id) {

  const formElem = a_element_selector("Form", id);

  return {
    fields: () => {
      var fieldNodes = {}; 
      formElem().querySelectorAll('input').forEach((input) => {
        const fieldName = input.getAttribute('a.field');
        const fieldValue = input.value;
        if (fieldName) {
          fieldNodes[fieldName] = fieldValue;
        };
      });
    
      return fieldNodes;
    },

    field: (fieldName) => {
      const elem = formElem().querySelector(a_css_query`[a\\.field=${fieldName}]`)
      if (elem) {
        return elem.value;
      } else {
        throw new Error(`Field ${fieldName} not found in form ${id}`);
      }
    },

    onSubmit: (fn) => {
      formElem().addEventListener("submit", async (e) => {
        e.preventDefault();
        fn(a_form(id));
      });
    }
  };
};

export { a_form };