
import { a_element_selector, a_remove_node, a_css_query, a_clean_node } from "./tools.js";

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

function fillTable(table, data) {
  if (data !== undefined && data.forEach) {
    data.forEach((item) => {
      var [id, rowData] = item;
      if (id === undefined) {
        throw new Error(`Item ${item} does not contains id at first position`);
      }
      if (rowData === undefined) {
        throw new Error(`Item ${item} does not contains value at second position`);
      }
      const row = renderRow(id, rowData);
      table.append(row);
    });
  }
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
    },
    replace: (data) => {
      let elem = tableElem();
      a_clean_node(elem);
      fillTable(elem, data);
    }
  };
}

a_table.create = (id, data) => {
  var tableElem = document.createElement("table");
  tableElem.setAttribute("id", id);
  fillTable(tableElem, data);
  return tableElem;
}

export { a_table };