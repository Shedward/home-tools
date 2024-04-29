
function a_element_selector(type, id) {
  return () => {
    const formElem = document.getElementById(id);

    if (!formElem) {
      throw new Error(`${type} ${id} not found`);
    }

    return formElem
  }
}

function a_remove_node(node) {
  node.parentNode.removeChild(node)
};

function a_clean_node(node) {
  node.textContent = '';
};

function a_css_query(strings, ...values) {
  const escapedValues = values.map(CSS.escape)
  return String.raw({ raw: strings }, ...escapedValues);
}

export { a_element_selector, a_remove_node, a_clean_node, a_css_query };