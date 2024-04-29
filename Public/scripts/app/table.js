
import { a_element_selector, a_remove_node, a_css_query } from "./tools.js";

function renderRow(id, value) {
  var tr = document.createElement("tr");
  tr.setAttribute("a.id", id);

  if (value.forEach) {
    value.forEach((cellValue) => {
      var td = document.createElement("td");
      td.innerHTML = cellValue;
      tr.append(td);
    });
  } else if (typeof value === 'string') {
    tr.innerHTML = value;
  }

  return tr;
}

function a_table(id) {

  const tableElem = a_element_selector("Table", id)

  return {
    prependRow: (id, row) => {
      let rowNode = renderRow(id, row);
      tableElem().prepend(rowNode)
    },
    appendRow: (id, row) => {
      let rowNode = renderRow(id, row);
      tableElem().append(rowNode);
    },
    deleteRow: (id) => {
      tableElem().querySelectorAll(a_css_query`[a\\.id=${id}]`).forEach(a_remove_node);
    }
  };
}

export { a_table };